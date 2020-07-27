# How to Package Kolide Launcher
Kolide Launcher is an osquery wrapper. Find more information [here](https://github.com/kolide/launcher).

## Linking a 'user' to a device
Launcher easily records a device UUID, or wifi name. However, it's not always obvious knowing *who* belongs to the device from this.

### MacOS
With launcher for MacOS there is a workaround to allow you to pass 'user' information back to the dashboard.

1. Encode the user information you want to show on the dashboard in base64. The example repo uses an email address.
2. Attach this base64 encoded string to the start of the `launcher.pkg` e.g. `ZXhhbXBsZUBlbWFpbC5jb20=-launcher.darwin-launcher.pkg` 
would be the name of the package for the email `example@email.com`
>NB: This **must** be a standard format for the following instructions to work.
3. Using osquery decorators and the `kolide_json` table you can get the package name from osquery on each query.

I recommend writing a script for this. You can simply put the base packages in a folder and have the script make a copy with the new package name.

```
SELECT value as "downloaded_name" FROM kolide_json where path="/private/etc/launcher/installer-info.json" and key="download_file";
```

4. We can use Filebeat's processors to parse `downloaded_name` and send an email address field to elasticsearch.
   
Excerpt from [filebeat-configmap.yaml](../templates/../../templates/filebeat-configmap.yaml)
```
filebeat.inputs:
- type: log
  paths:
    - {{ .Values.fleet.filesystem.result_volume }}/result.log
  json.keys_under_root: true
  processors:
    - dissect:
        tokenizer: "%{base64email}-launcher.%{restofpackagename}"
        field: "decorations.downloaded_name"
        target_prefix: ""
    - decode_base64_field:
        field:
          from: "base64email"
          to: "email"
        ignore_missing: true
        fail_on_error: false
```

5. Send the package to the user whose email you associated with that install.
6. See their email appear for each log entry!


## Windows
For Windows you can use the `--identifier` flag on build of a launcher package. The limitation to this is that you can only build Windows packages on Windows, due to the dependency on WiX toolset.

1. Encode the email in base64.
`ZXhhbXBsZUBlbWFpbC5jb20=` would be the encoding for `example@email.com`
2. Strip any `=` characters from the base64 string. Becomes `ZXhhbXBsZUBlbWFpbC5jb20`. This is because a valid identifier cannot have any `=`s in it.
3. Prepend a dummy character. Becomes `DZXhhbXBsZUBlbWFpbC5jb20`. This is because the first character of the identifier will be capitalised. 
4. Build the launcher package using the custom identifier e.g. for `example@email.com`
```
.\package-builder.exe make —-hostname=<host_name> --enroll_secret=<enroll_secret> --identifier=DZXhhbXBsZUBlbWFpbC5jb20
```
5. Add a decorator (targetting windows), to get the service name.
```
SELECT name as 'service_name' FROM services WHERE lower(name) LIKE 'launcher%svc';
```
> The identifer is used to set the service name in format: `LauncherIdentifierSvc`

6. Setup filebeat processors to translate this encoding.
```
- dissect:
    tokenizer: "Launcher%{base64emailWin}Svc"
    field: "decorations.service_name"
    target_prefix: ""
- script:
    lang: javascript
    id: correctb64padding
    source: >
      function process(event) {
        var base64emailWithDummy = event.Get('base64emailWin')
        var base64email = base64emailWithDummy.slice(1)
        var lenB64email = base64email.length;
        var paddingLen = (4 - (lenB64email % 4)) % 4
        var i;
        for (i = 0; i < paddingLen; i++) {
          base64email = base64email + "=";
        }
        event.Put('base64emailWinAfter', base64email)
      }
- decode_base64_field:
    field:
      from: "base64emailWinAfter"
      to: "email"
    ignore_missing: true
    fail_on_error: false
```
> The script part of this:
> 1. Strips the the dummy letter
> 2. Calculates the length of padding required (proper base64 must be a length that is a multiple of 4), else decoding fails.
> 3. Add the padding and then put a new field in the document.


## Notes
- You can use filebeats `if then` construct to use the processors for Mac and Windows together, to set a single `email` field for both OSs.
- Use `drop_fields` to drop the fields created during the intermediate steps