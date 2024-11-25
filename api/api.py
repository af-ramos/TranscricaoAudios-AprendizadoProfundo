from flask import Flask, request, send_file
from models import EasyOCRService, TesseractService, Text2Speech

app = Flask(__name__)

@app.route('/')
def home():
    return "Hello, Flask!"

@app.route('/transcribe', methods = ['POST'])
def transcribe():
    file = request.files['file']
    file.save(f'api/img/{file.filename}')

    model = request.form.get('model')

    if model == '1':
        textService = EasyOCRService()
    if model == '2':
        textService = TesseractService()

    text = textService.translate(f'api/img/{file.filename}')

    audioService = Text2Speech()
    audio = audioService.translate(text)

    return ''
    
    # return send_file("teste.m4a", mimetype="audio/m4a", as_attachment=True)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, debug=True)