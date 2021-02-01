import os, io
from google.cloud import vision
# from google.cloud.vision_v1 import types

# <class '_io.BufferedReader'>
# <class 'bytes'>
def recognize(content):
    os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = r'text recognition\MP-Project-5039d0814b97.json'
    client = vision.ImageAnnotatorClient()
    print(type(content))
    image = vision.Image(content=content)
    print(type(image))
    response = client.document_text_detection(image=image)
    print(response)

    docText = response.full_text_annotation.text
    print(docText)
    return docText
    # return ""