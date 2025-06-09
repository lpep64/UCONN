"""
Server side: open a socket on a port, listen for a message from a client,
and send an echo reply; echoes lines until eof when client closes socket;
spawns a thread to handle each client connection; threads share global
memory space with main thread; this is more portable than fork: threads
work on standard Windows systems, but process forks do not;
"""

import time, re                          # re for wildcard queries, no thread in basic server
from socket import *                     # get socket constructor and constants
myHost = ''                              # server machine, '' means local host
myPort = 50006                           # listen on a non-reserved port number

sockobj = socket(AF_INET, SOCK_STREAM)           # make a TCP socket object
sockobj.setsockopt(SOL_SOCKET, SO_REUSEADDR, 1)
sockobj.bind((myHost, myPort))                   # bind it to server port number
sockobj.listen(5)                                # allow up to 5 pending connects
sockobj.settimeout(3000)  # Set a timeout of 30 seconds

def now():
    return time.ctime(time.time())               # current time on the server

def handleClient(connection):                    # in spawned thread: reply
    time.sleep(2)                                # simulate a blocking activity
    with open('wordlist.txt', 'r') as file:      # load word list
        wordlist = file.read().splitlines()
        
    while True:                                  # read, write a client socket
        data = connection.recv(1024)
        if not data: break
        query = data.decode().strip()  # Decode the data to a string
            
        pattern = re.compile(query.replace('?', '.').replace('*', '.*'))  # Convert wildcard to regex
        matches = [word for word in wordlist if pattern.search(word) and len(word) > len(query)]
        
        response = "404 Not Found"               # base response is not found
        if len(matches) != 0:                    # if matches exist 200 OK ...
            response = f"200 OK\nNumber of matching words: {len(matches)}\n" + "\n".join(matches)
        
        connection.send(response.encode())
    connection.close()

def dispatcher():                                # listen until process killed
    while True:                                  # wait for next connection,
        connection, address = sockobj.accept()   # pass to thread for service
        print('Server connected by', address, end=' ')
        print('at', now())
        handleClient(connection)                 # removal of threading

dispatcher()
