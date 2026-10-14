import os
import sys
import time
from flask import Flask, jsonify

app = Flask(__name__)
START_TIME = time.time()

@app.route('/')
def home():
    return "Hello from Dockerized Python! The app is running successfully."

@app.route('/health')
def health():
    return jsonify({
        "status": "healthy",
        "service": "python-docker-exercise",
        "uptime_seconds": round(time.time() - START_TIME, 2),
        "timestamp": int(time.time())
    }), 200

@app.route('/api/info')
def api_info():
    return jsonify({
        "service": "DevOps Python Microservice",
        "version": "1.1.0",
        "python_version": sys.version.split()[0],
        "environment": os.getenv("FLASK_ENV", "production")
    }), 200

if __name__ == '__main__':
    port = int(os.getenv("PORT", 5000))
    app.run(host='0.0.0.0', port=port)