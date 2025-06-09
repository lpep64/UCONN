import subprocess

gang_members = [
"Adam",
"Al",
"Charles",
"Ted",
"Tom",
"Bonnie",
"Clyde",
"Kevin",
"Andrew",
"Jack",
"Richard",
"Donald",
"Kim",
"Vlad",
"Benedict",
"Billy",
"Anne"
]

common_passwords = [
"123456",
"123456789",
"picture1",
"password",
"12345678",
"111111",
"123123",
"12345",
"1234567890",
"senha",
"1234567",
"qwerty",
"abc123",
"Million2",
"1234",
"iloveyou",
"aaron431",
"password1",
"qqww1122"] #no

try:
    for password in common_passwords:
        for member in gang_members:
            print("Trying: " + str(member) + str(password))
            subprocess.run(['python3', 'Login.pyc', member, password], check=True)
except subprocess.CalledProcessError as e:
    print(f"Error has occured: {e}")
