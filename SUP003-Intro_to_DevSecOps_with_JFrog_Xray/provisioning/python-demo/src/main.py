from flask import Flask
import yaml
import requests

app = Flask(__name__)

@app.route("/")

def index():
    with open('config.yaml') as f:
        data = yaml.safe_load(f)
        #data = yaml.load(f, Loader=yaml.FullLoader)

        username = data['username']

    r = requests.get("https://api.agify.io/?name=" + username).json()

    return "Congratulations " + username + " , it's a web app! By the way, are you " + str(r['age']) + " years old ?"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080, debug=True)

