# AES
AES for Objective-C,PHP and Android

Php Encryption
$value = "example";
$key = "A262B453cE794b0E"; //16 Character Key
echo Security::encrypt($value, $key);

Android Decryption
Security.decrypt(val,"A262B453cE794b0E");

Objective-c Decryption
[AES128Encrypt AES128Decrypt:val key:@"A262B453cE794b0E"];




