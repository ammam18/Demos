#importing necessary dependencies
from PIL import Image
import pytesseract 
from googletrans import Translator
##set tesseract path in script
pytesseract.pytesseract.tesseract_cmd = r'C:\\Program Files\\Tesseract-OCR\\tesseract.exe'

#loading the image from the filepath
image = Image.open("C:/Users/HUMA/Documents/Python Projects/ger_test.jpeg")

#CNN GOES HERE TO DEFINE LANG PARAMETER FOR UNKNOWN IMAGES

#inputing the language
lng = input('What language is this in:\n')

#converting the image to string using tesseract
text = pytesseract.image_to_string(image, lang = lng)

#initializing translator
translator = Translator()

#running translator
translation = translator.translate(text)

print(translation)
