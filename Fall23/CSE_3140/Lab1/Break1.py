import subprocess

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
        print("Trying:", password)
        subprocess.run(['python3', 'Login.pyc', 'Adam', password], check=True)
except subprocess.CalledProcessError as e:
    print(f"Error has occured: {e}")