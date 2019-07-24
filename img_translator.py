#importing necessary dependencies
from PIL import Image
import pytesseract 
from googletrans import Translator
from langdetect import detect 
from pycountry import languages

##set tesseract path in script
pytesseract.pytesseract.tesseract_cmd = r'C:\\Program Files\\Tesseract-OCR\\tesseract.exe'

#loading the image from the filepath
image = Image.open("C:/Users/HUMA/Documents/Python Projects/img_test_french.jpeg")

#first ask to see if they know the language
inp = input("What language is the picture in? Input 'eng' if you do not know. ")

#initial extraction: extracting text from img lang = eng
text_1 = pytesseract.image_to_string(image, lang = inp)

#language detection
lng = detect(text_1)

#iso639-1 to iso639-2 convert
lng_detected = languages.get(alpha_2=lng)

#converting the image to string using tesseract
text = pytesseract.image_to_string(image, lang = lng_detected.alpha_3)

#initializing translator
translator = Translator()

#running translator
translation = translator.translate(text)

print(translation)
