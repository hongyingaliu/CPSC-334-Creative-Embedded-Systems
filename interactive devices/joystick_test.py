#full usage of joystick can only be achieved with analog to digital convertor
from gpiozero import Button
button1 = Button(22)
button2 = Button(27)
button3 = Button(17)

while True:
  if button1.is_pressed:
    print(“sw is pressed")
    #wait for release or else it will keep going
    button1.wait_for_release()      
  elif button2.is_pressed:
    print(“y is pressed")
    button2.wait_for_release() 
	elif button3.is_pressed:
	  print(“x is pressed”)
    button3.wait_for_release() 

          
