import os
from Crypto.Hash import SHA256
from Crypto.PublicKey import RSA
from Crypto.Signature import PKCS1_v1_5


key = RSA.import_key(open("./Q3pk.pem", "rb").read())


for file in os.listdir("./Q3files"):
    if os.path.isfile(os.path.join("./Q3files", file)):
        with open(os.path.join("./Q3files", file), "rb") as f:
            data = f.read()
        digest = SHA256.new(data)
        PKCS1_v1_5.new(key).verify(digest, data)
        print(f"Signature match: {file}")
        break