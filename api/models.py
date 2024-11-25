import cv2
import easyocr
import pytesseract
import torch

class EasyOCRService():
    def translate(self, image_path: str):
        img = cv2.imread(image_path)

        reader = easyocr.Reader(['pt'], gpu = True)
        results = reader.readtext(img)

        return results

class TesseractService():
    def translate(self, image_path: str):
        img = cv2.imread(image_path)
        grayImg = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        
        pytesseract.pytesseract.tesseract_cmd = r'C:\\Program Files\\Tesseract-OCR\\tesseract.exe'

        results = pytesseract.image_to_string(grayImg, lang = 'por')
        return results
