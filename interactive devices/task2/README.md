# Task 2 - Stylized Abstract Design
## Hardware
The device is comprised of the Raspberry Pi, an ESP32, a breadboard, a momentary switch, a toggle switch, an analog joystick, and a 5" LCD display screen.
## Setup
The program to draw the abstract designs is titled main.py. The ESP32 should have test.ino uploaded onto it so main.py can receive input information through pyserial. The program can be run directly on the Raspberry Pi as a python script. Pyserial must be downloaded as a module. The Raspberry Pi will also need Arduino IDE set up on it to be able to detect and parse information from the ESP32.
## Controls
The program has two distinct modes: a drawing mode and a navigation mode. A user switches in between the modes by pressing the joystick button. During navigation mode, the joystick allows the user to move the mouse without drawing within the confines of the window. The pen color switches every time the user does so. 

The positive y-axis allows the user to draw lines coming out from a single point. The length of the lines is dependent on how far the joystick is pushed. The negative y-axis allows the user to draw lines on an angle dependent on the force on the joystick and the original orientation of the turtle. It mimics curvy lines. The positive x-axis allows the user to draw consistently sized circles. The negative x-axis allows the user to draw semi-circles. When directions are combined, they create new unique design shapes. I chose each of these different features, keeping in mind what could be interesting in a stylized design.

In addition, the switch allows a user to start filling shapes instead of just using the outlines and the momentary switch/button allows a user to clear the canvas and start again.
