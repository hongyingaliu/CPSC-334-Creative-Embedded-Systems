#Python GPIO library of choice is gpiozero
from gpiozero import Button
#sleep function helps eliminate contact bounce issues
from time import sleep
#module to play audio files
from pygame import mixer
mixer.init()
#load sound files
#note: files need to be 16 bit
sound1 = mixer.Sound('stars.wav')
sound2 = mixer.Sound('windbells.wav')
sound3 = mixer.Sound('childrenofthestars.wav')
#momentary button
button = Button(4)
#spst switch
switch = Button(23, bounce_time = 0.1)
switchFlag = 0 #remember if it's on or off

#joystick buttons
joy1 = Button(22)
joy2 = Button(27)
joy3 = Button(17)
yFlag = 0 #remember if y has been touched
xFlag = 0 #remember if x has been touched

while True:
	#state 1 just button pressed
	if button.is_pressed and switchFlag == 0:
		sound1.play()
		print("button is pressed")
		#print(switchFlag)
		sleep(0.1)
		button.wait_for_release()
	#state 2 button and switch on only
	elif button.is_pressed and switchFlag == 1 and yFlag == 0 and xFlag == 0:
		sound2.play()
		print("special button is pressed")
		#print(switchFlag)
		sleep(0.1)
		button.wait_for_release()
	#state 3 button and switch on and both directions on joystick toggled
	elif button.is_pressed and switchFlag == 1 and yFlag == 1 and xFlag == 1:
		sound3.play()
		print("extra special button is pressed")
		#print(yFlag)
		#print(xFlag)
		sleep(0.1)
		button.wait_for_release()
	#if joystick is pressed down, previous joystick settings are reset
	elif joy1.is_pressed:
		print("reset")
		yFlag = 0
		xFlag = 0
		sleep(0.1)
	#check for y toggle
	elif joy2.is_pressed:
		print("y is pressed")
		yFlag = 1
		sleep(0.1)
	#check for x toggle
	elif joy3.is_pressed:
		print("x is pressed")
		xFlag = 1
		sleep(0.1)
	#check to see if switch is on
	elif switch.is_pressed:
		switchFlag = 1
	#check to see if switch is off
	elif switch.is_pressed == False:
		switchFlag = 0
