import hashlib
import subprocess

with open('gang', 'r') as file:
    gang_members = file.read().splitlines() 

with open('SaltedPWs', 'r') as file:
    userfile = file.read().splitlines() 

with open('PwnedPWs100k', 'r') as file:
    all_passwords = file.read().splitlines() 

print("Gang members found in HashedPWs:")
gang_hacked = []
gang_passwords = []
for member in gang_members:
    mem = len(member)
    for user in userfile:
        comma = user.index(',')
        if (member == user[0:comma]):
            print("Gang member info found:", user)
            gang_hacked.append(user)

for password in all_passwords:
    for i in range(10):
        for gang_pass in gang_hacked:
            comma = gang_pass.index(',')
            salter = gang_pass[comma+1:]
            comma = salter.index(',')
            salt = salter[0:comma]
            passwordhalf = str(password) + str(i)
            password2 = str(hashlib.sha256(bytes(str(str(salt) + str(password) + str(i)), 'utf-8')).hexdigest())
            if (password2 == salter[comma+1:]):
                comma = gang_pass.index(',')
                result = subprocess.run(['python3', 'Login.pyc', gang_pass[0:comma], (str(password)+str(i))], capture_output=True, text=True, check=True)
                if ('successful' in result.stdout):
                    print('Successful', gang_pass[0:comma], (str(password) + str(i)))