#tests button and swtich together, creates two states
from gpiozero import Button
from time import sleep
button = Button(4)

switch = Button(23, bounce_time = 0.1)
switchFlag = 0

while True:
	if button.is_pressed and switchFlag == 0:
		print("button is pressed")
		print(switchFlag)
		sleep(0.1)
		button.wait_for_release()
	elif button.is_pressed and switchFlag == 1:
		print("special button is pressed")
		print(switchFlag)
		sleep(0.1)
		button.wait_for_release()
	elif switch.is_pressed:
		switchFlag = 1
	elif switch.is_pressed == False:
		switchFlag = 0
