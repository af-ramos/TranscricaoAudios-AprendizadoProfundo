from flask import Flask, request, send_file
from models import EasyOCRService, TesseractService

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
        service = EasyOCRService()
    if model == '2':
        service = TesseractService()

    text = service.translate(f'api/img/{file.filename}')

    print(text)
    return ''
    
    # return send_file("teste.m4a", mimetype="audio/m4a", as_attachment=True)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, debug=True)