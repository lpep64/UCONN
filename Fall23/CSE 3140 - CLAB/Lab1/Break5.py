import hashlib
import subprocess

with open('gang', 'r') as file:
    gang_members = file.read().splitlines() 

with open('HashedPWs', 'r') as file:
    userfile = file.read().splitlines() 

with open('PwnedPWs100k', 'r') as file:
    all_passwords = file.read().splitlines() 

print("Gang members found in HashedPWs:")
gang_hacked = []
for member in gang_members:
    mem = len(member)
    for user in userfile:
        comma = user.index(',')
        if (member == user[0:comma]):
            print("Gang member info found:", user)
            gang_hacked.append(user)
            

for password in all_passwords:
    for i in range(100):
        password2 = password + str(i)
        salted_i = str(hashlib.sha256(bytes(i, 'utf-8')).hexdigest())
        sha256_hash = str(hashlib.sha256(bytes(password2, 'utf-8')).hexdigest())
        for gang_pass in gang_hacked:
            comma = gang_pass.index(',')
            if (sha256_hash == gang_pass[comma+1:]):
                print("Login successful:", gang_pass, password2)