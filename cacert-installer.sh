#!/bin/bash

cert_file = $1
openssl x509 -inform DER -in $cert_file -out burp.pem
hash = openssl x509 -inform PEM -subject_hash_old -in burp.pem |head -1 
mv burp.pem $hash.0
adb root
adb remount
adb shell
adb push $hash.0 /system/etc/security/cacerts
adb -c "chmod 644 /system/etc/security/cacerts/$hash.0"
reboot
