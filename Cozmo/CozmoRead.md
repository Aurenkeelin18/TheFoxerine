![](04_Documentation/Images/cozmoppt.png)
![Watch this intro from Cozmo](https://user-images.githubusercontent.com/68656802/116004638-41730a80-a5c9-11eb-9c07-291fdd2ff7bb.mp4)
<br>

# Plan


![](04_Documentation/Images/plan.png)
<br>

# Sampling Strategy
<br>
![](04_Documentation/Images/samplingstrategy.png)
<br>
![See the sampling](https://user-images.githubusercontent.com/68656802/116004638-41730a80-a5c9-11eb-9c07-291fdd2ff7bb.mp4)
<br>
#  Image Preparation and Selection
![](04_Documentation/Images/imageselection.png)

# Model and Metrics
The model was  trained on 4,646 images and validated with 2,795 images. The model is optimized by root mean square propagation (rmsprop)with a categorical cross-entropy loss function, amd a batch size of 30. The model without call backs reached an accuracy of 83% after 100 epochs while the model with the “ best callbacks” reached an accuracy of 77% after 100 epochs. The accuracy and loss curves suggest that the validation images are not representative and that both training and validation images should be shuffled. Additional images would be beneficial as well.
![](04_Documentation/Images/metrics.png)

# Model Application
![](04_Documentation/Images/modelapplication.png)
![See how well Cozmo identifes letters](https://user-images.githubusercontent.com/68656802/116005682-b5afad00-a5cd-11eb-836b-49caee2c7c8a.png)

# Conclusion

