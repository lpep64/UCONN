import hashlib
gang_pass = "Andrew,814b97e52ce8cac1,3faf98e4c41cc52c78b3c3baad872778"
comma = gang_pass.index(',')
name = gang_pass[0:comma]
salted = gang_pass[comma+1:]

comma = salted.index(',')
salt = salted[0:comma]
Hash = salted[comma+1:]

print(name, salt, Hash)

for i in range(10):
    salted_p = str(hashlib.sha256(bytes(str(i), 'utf-8')).hexdigest())
    print(salted_i)
    if(salted_i == salt):
        print("WINNER:", i)
