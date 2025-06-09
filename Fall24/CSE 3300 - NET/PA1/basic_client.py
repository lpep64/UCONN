import socket                                                                   # get socket constructor

def main():
    server_address = ('localhost', 50006)                                       # set localhost and port same as server
    
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:             # create a TCP/IP socket
        sock.connect(server_address)                                            # connect to the server
        
        query = input("Enter your wildcard query (e.g., 'a?t'): ")              # Get the wildcard query from the user
        print(f'Sending query: {query}')
        sock.sendall(query.encode())                                            # send the query to the server
        
        data = sock.recv(4096)                                                  # receive the response (larger buffer for potentially many words)
        response = data.decode()
        
        print('Received response:')                                             # Print the server's response
        print(response)
        
        sock.close()    


main()