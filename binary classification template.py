import keras
import numpy
from keras.datasets import imdb

#loading data
training_data = imdb.load_data('')
validation_data = imdb.load_data('')

#initializing model
model = Sequential()

##1st layer
model.add(Convolution2D(32, 3, 3 input_shape = (img_width, img_height, 3)))
model.add(Activation('relu'))
model.add(MaxPooling2D(pool_size = (2,2)))

##2nd layer
model.add(Convolution2D(32, 3, 3))
model.add(Activation('relu'))
model.add(MaxPooling2D(pool_size = (2,2)))

##3rd layer
model.add(Convolution2D(32, 3, 3))
model.add(Activation('relu'))
model.add(MaxPooling2D(pool_size = (2,2)))

##4th layer
model.add(Convolution2D(32, 3, 3))
model.add(Activation('relu'))
model.add(MaxPooling2D(pool_size = (2,2)))

#dropout for overfitting
##Flattening layers
model.add(Flatten())
##initializing fully connected layer
model.add(Dense(64))
##apply relu to fully connected layer
model.add(Activation('relu'))
##dropout
model.add(Dropout(0.5))
##initializing another fully connected layer. output = n dim layer (where n is number of classes)
model.add(Dense(1))
##apply sigmoid, convert data to probs for each class
model.add(Activation('sigmoid'))

#defining loss function and optimization, bin cross ent is the preferred loss function for binary classifications, rmsprop does gradient decent, accuracy since classification problem
model.compile(loss = 'binary_crossentropy', 
	optimizer = 'rmsprop',
	metrics = 'accuracy')

#training the model
model.fit_generator(
	training_data, 
	samples_per_epoch = 2048, 
	nb_epoch = 30, 
	validation_data = validation_data, 
	nb_val_samples = 832)
#save model weights to reuse later
model.save_weights('')

#testing the model
img = image.load_img('', target_size = (224, 224))
prediction = model.predict(img)
print prediction
