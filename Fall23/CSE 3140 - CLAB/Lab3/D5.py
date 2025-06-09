import os
import sys
from Crypto.Util.Padding import unpad
from Crypto.Hash import SHA256,MD5
from Crypto.PublicKey import RSA
from Crypto.Signature import PKCS1_v1_5
from Crypto.Cipher import PKCS1_OAEP
from Crypto.Cipher import AES
from Crypto.Util.Padding import unpad
from Crypto.Random import get_random_bytes

file_in = open ('Encrypted5', 'rb')
iv = file_in.read(16)
original_data = file_in.read()
file_in.close()

BLOCKSIZE = 2048
count=0
h= MD5.new()
with open( 'R5.py' , 'rb') as afile:
    buf = afile.read(BLOCKSIZE)
    while len(buf) > 0:
        count = count + 1
        h.update(buf)
        buf = afile.read(BLOCKSIZE)
hf = h.digest()


cipher = AES.new(hf,
AES.MODE_CBC , iv = iv )
ciphered_data = cipher.decrypt(original_data)
print(ciphered_data)