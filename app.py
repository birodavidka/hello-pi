import os, socket, platform, json
from datetime import datetime
from flask import Flask, jsonify

app = Flask(__name__)

@app.get("/")
def root():
    greeting = os.getenv("GREETING", "Hello from Raspberry Pi!")
    return jsonify({
        "message": greeting,
        "hostname": socket.gethostname(),
        "platform": platform.platform(),
        "time": datetime.now().isoformat(timespec="seconds")
    })

@app.get("/healthz")
def health():
    return "ok", 200

@app.get("/env")
def env():
    # csak demo: néhány env változó
    keys = ["GREETING", "PORT"]
    return jsonify({k: os.getenv(k) for k in keys})

if __name__ == "__main__":
    port = int(os.getenv("PORT", "8080"))
    app.run(host="0.0.0.0", port=port)
