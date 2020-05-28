docker run --name elastic-helm-charts-certs -i -w /app \
  docker.elastic.co/elasticsearch/elasticsearch:7.3.1 \
  /bin/sh -c " \
    elasticsearch-certutil ca --out /app/elastic-stack-ca.p12 --pass '' && \
    elasticsearch-certutil cert --name elasticsearch-master --dns elasticsearch-master --ca /app/elastic-stack-ca.p12 --pass '' --ca-pass '' --out /app/elastic-certificates.p12" && \
docker cp elastic-helm-charts-certs:/app/elastic-certificates.p12 ./ && \
docker rm -f elastic-helm-charts-certs && \
openssl pkcs12 -nodes -passin pass:'' -in elastic-certificates.p12 -out elastic-certificate.pem && \
kubectl create secret generic elastic-certificates --from-file=elastic-certificates.p12 && \
kubectl create secret generic elastic-certificate-pem --from-file=elastic-certificate.pem