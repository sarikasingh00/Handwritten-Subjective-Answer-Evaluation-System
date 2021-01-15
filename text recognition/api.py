import flask
from flask import request, jsonify
import io
from PIL import Image
import text_recognition

app = flask.Flask(__name__)
app.config["DEBUG"] = True


@app.route('/', methods = ['GET', 'POST']) 
def home():
    if(request.method == 'POST'):
        received_image = Image.open(request.files['img'])
        # print(type(received_image))
        buffer = io.BytesIO()
        received_image.save(buffer, format='JPEG')
        byte_image = buffer.getvalue()
        # print(type(byte_im))
        return jsonify({'text': text_recognition.recognize(byte_image)}) 

app.run()