#importing necessary dependencies
from PIL import Image
import pytesseract 
##set tesseract path in script
pytesseract.pytesseract.tesseract_cmd = r'C:\\Program Files\\Tesseract-OCR\\tesseract.exe'

#loading the image from the filepath
image = Image.open("C:/Users/HUMA/Documents/Python Projects/chinese_test.gif")


#converting the image to string using tesseract
text = pytesseract.image_to_string(image)
print(text)
