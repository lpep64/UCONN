import hashlib
import os

# The target SHA-256 checksum
target_hash = "f527aea19810e3723e36018017855b681d453a65fc38b27ad91bd54f8e40095f"

# Directory containing the files
directory = os.getcwd()

for filename in os.listdir(directory):
    if os.path.isfile(os.path.join(directory, filename)):
        with open(os.path.join(directory, filename), "rb") as file:
            # Calculate the SHA-256 checksum
            sha256 = hashlib.sha256()
            while True:
                data = file.read(65536)  # Read the file in 64k chunks
                if not data:
                    break
                sha256.update(data)
            file_hash = sha256.hexdigest()
            
            # Check if the checksum matches the target checksum
            if file_hash == target_hash:
                print(filename)
                break