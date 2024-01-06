import requests

url = 'http://localhost:2223'  # Update the URL to match your server

data = {
    'username': 'Jamillah222',  # Replace with the actual username
    'password': '140888',  # Replace with the actual password
    'submit': 'Sign In'  # The name and value of the submit button
}

response = requests.post(url, data=data)

if response.status_code == 200:
    if "You Logged In as" in response.text:
        print(f"Successful login with password: {data['password']}")
    else:
        print(f"{data['password']} failed")
else:
    print(f"Request failed with status code: {response.status_code}")
