#!/bin/bash

rm cert.csr
rm privkey.pem
rm key.pem
rm localhost.pem
rm cert.pem

openssl req -new > cert.csr
openssl rsa -in privkey.pem -out key.pem
openssl x509 -in cert.csr -out cert.pem -req -signkey key.pem -days 1001
cat key.pem>>localhost.pem
cat cert.csr>>localhost.pem