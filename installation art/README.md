# Task 2 - Shrine of Modernity
'Shrine of Modernity' is an installation that primarily focuses on aural experience. It's also a shrine.
## Hardware
The system is comprised of an ESP32, a breadboard, a bluetooth speaker, 4 photoresistors, 1 piezoelectric sensor, 1 capacitive sensor, and a mac laptop connected by wifi. 
## Programs
Programs are written in Arduino, Python, and Supercollider
## Setup / Wifi
The ESP32 will deliver sensory information on boot. Both the python script and Supercollider composition will also run on boot if included into Mac's automation system. 

sensor_input.ino receives information from the sensors/sensor pins in Arduino. Arduino must have the CapSense library installed as well as the Wifi library included to work. Through Arduino's wifi client, sensor_input.ino sends the sensor data remotely to another device. In Python, wifi_test.py parses the info received from Arduino and passes on the content to SuperCollider using pythonosc's udp client. In SuperCollider, installation_art.scd uses the incoming stream of data to trigger OSC functions that control the synths.
## Controls
Piezoelectric sensor - makes gong sound upon vibration (i.e knocking, tapping, etc.)
Capacitive sensor - plays sound only when box is lifted (ideally)
Photo-resistor on the left (facing) - controls the frequency, which changes the pitch, of just a simple straightforward ambient sound. 
Photo-resistor in the middle - controls the same sound as previous but its amplitude. 
Photo-resistor on the right (facing) -  controls the frequency of the knocking synth, but instead of affecting the pitch, changing the frequency changes the rate of the knocking as well. 
Photo-resistor on the bottom - controls the playing of a synth that plays bird noises.

