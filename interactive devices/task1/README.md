## Task 1
Task1.py is a program that utilizes a Raspberry Pi setup with a breadboard and a momentary button, spst switch, and analog joystick which are connected to the correct pins specified in the program. 

There are 3 modes that each play a different sound when the button is clicked. 
1. If only the button has been pressed, sound 1 will play. 
2. If the button has been pressed and the switch is on and the joystick has not been touched/is reset, sound 2 will play.
3. If the button has been pressed and the switch is on and the joystick has been toggle both right and up, sound 3 will play. 
Pressing down on the joystick will reset the joystick so it will be as if it has not been toggled. 

GPIO Pins:
Momentary button - GPIO 4
SPST switch - 23
SW - 22
VRX - 17
VRY - 27
