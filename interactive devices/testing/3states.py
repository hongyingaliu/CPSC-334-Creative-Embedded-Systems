#implementation of 3 states without any output
from gpiozero import Button
#sleep function helps eliminate contact bounce issues
from time import sleep
#momentary button
button = Button(4)
#spst switch
switch = Button(23, bounce_time = 0.1)
switchFlag = 0 #remember if it's on or off

#joystick buttons
joy1 = Button(22)
joy2 = Button(27)
joy3 = Button(17)
yFlag = 0
xFlag = 0

while True:
	#state 1
	if button.is_pressed and switchFlag == 0:
		print("button is pressed")
		print(switchFlag)
		sleep(0.1)
		button.wait_for_release()
	#state 2
	elif button.is_pressed and switchFlag == 1 and yFlag == 0 and xFlag == 0:
		print("special button is pressed")
		print(switchFlag)
		sleep(0.1)
		button.wait_for_release()
	#state 3
	elif button.is_pressed and switchFlag == 1 and yFlag == 1 and xFlag == 1:
		print("extra special button is pressed")
		print(yFlag)
		print(xFlag)
		sleep(0.1)
		button.wait_for_release()
	elif joy1.is_pressed:
		print("SW is pressed")
		yFlag = 0
		xFlag = 0
		sleep(0.1)
	elif joy2.is_pressed:
		print("y is pressed")
		yFlag = 1
		sleep(0.1)
	elif joy3.is_pressed:
		print("x is pressed")
		xFlag = 1
		sleep(0.1)
	elif switch.is_pressed:
		switchFlag = 1
	elif switch.is_pressed == False:
		switchFlag = 0
