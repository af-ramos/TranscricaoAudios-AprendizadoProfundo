import cv2
import easyocr
import pytesseract
import torch
from TTS.api import TTS

class EasyOCRService():
    def translate(self, image_path: str):
        img = cv2.imread(image_path)

        reader = easyocr.Reader(['pt'], gpu = True)
        results = reader.readtext(img)

        words = ', '.join(item[1] for item in results)

        return words

class TesseractService():
    def translate(self, image_path: str):
        img = cv2.imread(image_path)
        grayImg = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        
        pytesseract.pytesseract.tesseract_cmd = r'C:\\Program Files\\Tesseract-OCR\\tesseract.exe'
        results = pytesseract.image_to_string(grayImg, lang = 'por')

        return results

class Text2Speech():
    def translate(self, text: str):
        device = "cuda" if torch.cuda.is_available() else "cpu"

        tts = TTS(model_name="tts_models/multilingual/multi-dataset/your_tts").to(device)
        tts.tts_to_file(text, speaker_wav = "api/cloning/audio.wav", language = "pt-br", file_path = "api/audio/output.wav")