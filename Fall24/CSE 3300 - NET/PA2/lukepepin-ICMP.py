from socket import *
import os
import sys
import struct
import time
import select
import binascii  

ICMP_ECHO_REQUEST = 8



def MyChecksum(hexlist):
    summ=0
    carry=0
    for i in range(0,len(hexlist),2):
        summ+=(hexlist[i]<< 8)  + hexlist[i+1]
        carry=summ>>16
        summ=(summ & 0xffff)  + carry
        #print(str(hex((hexlist[i]<< 8)  + hexlist[i+1]))+" "+str(hex(summ)) + "  " +str(hex(carry)) + " " + str(hex(summ^0xffff)))

    while( summ != (summ & 0xffff)):
        carry=summ>>16
        summ=summ & 0xffffffff  + carry
        #print("loop loop")

    summ^=0xffff #invert it
    return summ



def checksum(string): 
	csum = 0
	countTo = (len(string) // 2) * 2  
	count = 0

	while count < countTo:
		thisVal = ord(string[count+1]) * 256 + ord(string[count]) 
		csum = csum + thisVal 
		csum = csum & 0xffffffff  
		count = count + 2
	
	if countTo < len(string):
		csum = csum + ord(string[len(string) - 1])
		csum = csum & 0xffffffff 
	
	csum = (csum >> 16) + (csum & 0xffff)
	csum = csum + (csum >> 16)
	answer = ~csum 
	answer = answer & 0xffff 
	answer = answer >> 8 | (answer << 8 & 0xff00)
	#print(hex(answer))
	#print(hex(checksum0(string)))
	return answer
	
def receiveOnePing(mySocket, ID, timeout, destAddr):
	timeLeft = timeout
	
	while 1: 
		startedSelect = time.time()
		whatReady = select.select([mySocket], [], [], timeLeft)
		howLongInSelect = (time.time() - startedSelect)
		if whatReady[0] == []: # Timeout
			return "Request timed out."
	
		timeReceived = time.time() 
		recPacket, addr = mySocket.recvfrom(1024)
	       
	    #Fill in start
        # Print Addr and Raw Packet Data
		print("Packet received from:", addr)
		print("Raw packet data:", recPacket)

		#Fetch the ICMP header from the IP packet
		ICMPheader = recPacket[20:28]
		type, code, receivedChecksum, receivedID, sequence = struct.unpack("bbHHh", ICMPheader)
		print(f"ICMP Header - Type: {type}, Code: {code}, Checksum: {receivedChecksum}, ID: {receivedID}, Sequence: {sequence}")

		# Ensure type is 0 and receivedID is consistant with ID
		if type == 0 and receivedID == ID:
      
			# Extract the time data from the packet
			timeData = recPacket[28:]
			print("Time data extracted from packet:", timeData)
					
			# Recreate the header for checksum calculation
			combinedData = (struct.pack("bbHHh", type, code, 0, receivedID, sequence)) + timeData
			print("Combined header and data for checksum:", combinedData)
					
			# Calculate the checksum
			calculatedChecksum = htons(MyChecksum([i for i in combinedData]) & 0xffff)	 # Convert the calculated checksum to network byte order
			print(f"Calculated checksum: {calculatedChecksum}, Received checksum: {receivedChecksum}")
			
   			# Verify the checksum		
			if calculatedChecksum == receivedChecksum:
				# Extract the time sent from the packet
				timeSent = struct.unpack("d", timeData)[0]
						
				# Calculate the round-trip time (RTT)
				roundTripTime = (timeReceived - timeSent) * 1000
				print(f"Round-trip time (RTT) ms:")
				return roundTripTime
		else:
			print("Received ICMP packet with incorrect Type or Code, Trying Again")
        
       	#Fill in end
		timeLeft = timeLeft - howLongInSelect
		if timeLeft <= 0:
			return "Request timed out."
	
def sendOnePing(mySocket, destAddr, ID):
	# Header is type (8), code (8), checksum (16), id (16), sequence (16)
	
	myChecksum = 0
	
        # Make a dummy header with a 0 checksum
	# struct -- Interpret strings as packed binary data
	header = struct.pack("bbHHh", ICMP_ECHO_REQUEST, 0, myChecksum, ID, 1)
	data = struct.pack("d", time.time())
    
	# Calculate the checksum on the data and the dummy header.
	#myChecksum = checksum(str(header + data))
	myChecksum = MyChecksum ([i for i in header] + [i for i in data])
	# Get the right checksum, and put in the header
	if sys.platform == 'darwin':
		# Convert 16-bit integers from host to network  byte order
		myChecksum = htons(myChecksum) & 0xffff		
	else:
		myChecksum = htons(myChecksum)
		
	header = struct.pack("bbHHh", ICMP_ECHO_REQUEST, 0, myChecksum, ID, 1)
	packet = header + data
	
	mySocket.sendto(packet, (destAddr, 1)) # AF_INET address must be tuple, not str
	# Both LISTS and TUPLES consist of a number of objects
	# which can be referenced by their position number within the object.
	
	
def doOnePing(destAddr, timeout): 
	icmp = getprotobyname("icmp")
	# SOCK_RAW is a powerful socket type. For more details:   http://sock-raw.org/papers/sock_raw

	mySocket = socket(AF_INET, SOCK_RAW, icmp)
	
	myID = os.getpid() & 0xFFFF  # Return the current process i
	sendOnePing(mySocket, destAddr, myID)
	delay = receiveOnePing(mySocket, myID, timeout, destAddr)
	
	mySocket.close()
	return delay
	
def ping(host, timeout=1):
	# timeout=1 means: If one second goes by without a reply from the server,
	# the client assumes that either the client's ping or the server's pong is lost
	dest = gethostbyname(host)
	print("Pinging " + dest + " using Python:")
	print("")
	# Send ping requests to a server separated by approximately one second
	while 1 :
		delay = doOnePing(dest, timeout)
		print(delay)
		print("___________________________")
		time.sleep(1)# one second
	return delay
	
ping('8.8.8.8', 5)
