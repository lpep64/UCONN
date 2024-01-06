import random
import string

'''Rabin-Karp Algorithm: Finds a text pattern in a body of text'''
def rabin_karp_search(text, pattern):

    '''Calculates the hash of the pattern we'd like to find'''
    def calculate_hash(string, length):
        hash_value = 0
        for i in range(length):
            hash_value = (hash_value * 256 + ord(string[i])) % prime
        return hash_value


    '''Function to handle hash collisions'''
    def rehash(old_hash, old_char, new_char, length):
        new_hash = (old_hash - ord(old_char) * (256**(length-1)) % prime) * 256 + ord(new_char)
        return new_hash % prime



    prime = 101  # A prime number for the hash function (can be any prime)
    text_length = len(text)
    pattern_length = len(pattern)
    pattern_hash = calculate_hash(pattern, pattern_length) # calculate initial hash of the pattern
    text_hash = calculate_hash(text, pattern_length)       # calculate initial hash of the text


    # List to store indices of matches
    matches = []


    # Iterate through the text from start to end of where the pattern could be found
    for i in range(text_length - pattern_length + 1):

        # Check if the current hash of the pattern and the hash of the current substring match
        # Also compare the substring with the pattern to confirm if its a match
        if pattern_hash == text_hash and text[i:i+pattern_length] == pattern:
            matches.append(i)

        # if there are more characters in the text to process, update text_hash for the next iteration
        if i < text_length - pattern_length:
            text_hash = rehash(text_hash, text[i], text[i+pattern_length], pattern_length)
   
    if len(matches) != 0:
        print(f'Pattern "{pattern}" found at indices: "{matches}" in "{text}"')
    else:
        print(f'Pattern "{pattern}" not found in "{text}"')




# Table Data
text = ''.join(random.choices(string.ascii_letters + string.digits, k=10000000))
pattern = "ZyXoV"
rabin_karp_search(text, pattern)