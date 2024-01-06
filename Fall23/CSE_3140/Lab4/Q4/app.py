from flask import Flask, redirect, render_template
app = Flask(__name__)

@app.route('/')
@app.route('.index.html')
def index():
    return render_template('index.html')

@app.route('/login', methods=['POST'])
def login():
    # This is the page to which you will redirect after a successful login
    return redirect('https://localhost:2223')

if __name__ == '__main__':
    app.run(debug=True)