# How to Package Kolide Launcher
Kolide Launcher is an osquery wrapper. Find more information [here](https://github.com/kolide/launcher).

## Linking a 'user' to a device
Launcher easily records a device UUID, or wifi name. However, it's not always obvious knowing *who* belongs to the device from this.

### MacOS
With launcher for MacOS there is a workaround to allow you to pass 'user' information back to the dashboard.

1. Encode the user information you want to show on the dashboard in base64. The example repo uses an email address.
2. Attach this base64 encoded string to the start of the `launcher.pkg` e.g. `ZXhhbXBsZUBlbWFpbC5jb20=-launcher.darwin-launcher.pkg` 
>NB: This **must** be a standard format for the rest to work.
3. Using osquery decorators and the `kolide_json` table you can get the package name from osquery on each query.

I recommend writing a script for this. You can simply put the base packages in a folder and have the script make a copy with the new package name.

```
SELECT value as "downloaded_name" FROM kolide_json where path="/private/etc/launcher/installer-info.json" and key="download_file";
```

1. We can use Filebeat's processors to parse `downloaded_name` and send an email address field to elasticsearch.
   
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