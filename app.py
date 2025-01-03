import socket

from flask import Flask
from flask import jsonify


app = Flask(__name__)

@app.route("/hostname")
def hostname():
   return jsonify({"hostname": socket.gethostname()})

if __name__ == '__main__':
   app.run()
