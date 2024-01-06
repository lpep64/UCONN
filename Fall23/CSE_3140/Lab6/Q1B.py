from flask import Flask, request, make_response


app = Flask(__name__)


# Replace these values with your own
netid = "your_\netid"
last_name = "your_last_name"
vm_ip = "your_vm_ip"


@app.route('/')
def index():
   # Set Cookie Q1B1
   response = make_response("Welcome to the Flask website!")
   response.set_cookie('Q1B1', netid)


   return response


@app.route('/Q1B2')
def q1b2():
   # Set Cookie Q1B2 for requests to folder Q1B2
   response = make_response("This is folder Q1B2.")
   response.set_cookie('Q1B2', last_name)


   return response


@app.route('/Q1B3')
def q1b3():
   # Set Cookie Q1B3 with the IP address of the VM
   vm_ip_address = request.remote_addr  # Get the client's IP address
   response = make_response(f"VM IP Address: {vm_ip_address}")
   response.set_cookie('Q1B3', vm_ip, secure=True, httponly=True, samesite='Strict')


   return response


if __name__ == '__main__':
   app.run(debug=True)
