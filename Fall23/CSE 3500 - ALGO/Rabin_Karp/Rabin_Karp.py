def rabin_karp_search(text, pattern):
    def calculate_hash(string, length):
        hash_value = 0
        for i in range(length):
            hash_value = (hash_value * 256 + ord(string[i])) % prime
        return hash_value

    def rehash(old_hash, old_char, new_char, length):
        new_hash = (old_hash - ord(old_char) * (256**(length-1)) % prime) * 256 + ord(new_char)
        return new_hash % prime

    prime = 101  # A prime number for the hash function (can be any prime)

    text_length = len(text)
    pattern_length = len(pattern)
    pattern_hash = calculate_hash(pattern, pattern_length)
    text_hash = calculate_hash(text, pattern_length)

    for i in range(text_length - pattern_length + 1):
        if pattern_hash == text_hash and text[i:i+pattern_length] == pattern:
            print("Pattern found at index", i)

        if i < text_length - pattern_length:
            text_hash = rehash(text_hash, text[i], text[i+pattern_length], pattern_length)

# Example usage
text = "ABABDABACDABABCABAB"
pattern = "ABABCABAB"
rabin_karp_search(text, pattern)
