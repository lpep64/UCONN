from Crypto.Cipher import AES
from Crypto.Util.Padding import unpad

variable = b'\x12k\xeeP6\x8esH\xa0\xd6\x18z\x9c_\xff\xce'


with open('Encrypted4', 'rb') as encrypted_file:
    iv = encrypted_file.read(16)
    encrypted_data = encrypted_file.read().strip()


cipher = AES.new(variable, AES.MODE_CBC, iv=iv)


decrypted_data = unpad(cipher.decrypt(encrypted_data), AES.block_size).strip()
decrypted_string = decrypted_data.decode('utf-8')
print(f'{decrypted_string} is the plaintext')


with open('decrypted_plaintext.txt', 'wb') as output_file:
    output_file.write(decrypted_data)