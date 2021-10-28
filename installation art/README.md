# Task 2 - Shrine of Modernity
'Shrine of Modernity' is an installation that primarily focuses on aural experience.  
## Hardware
The system is comprised of an ESP32, a breadboard, a bluetooth speaker, 4 photoresistors, 1 piezoelectric sensor, 1 capacitive sensor, and a mac laptop connected by wifi. 
## Setup / Wifi
The ESP32 will deliver sensory information on boot. Both the python script and Supercollider composition will also run on boot if included into Mac's automation system. 

sensor_input.ino receives information from the sensors/sensor pins in Arduino. Arduino must have the CapSense library installed as well as the Wifi library included to work. Through Arduino's wifi client, sensor_input.ino sends the sensor data remotely to another device. In Python, wifi_test.py parses the info received from Arduino and passes on the content to SuperCollider using pythonosc's udp client. In SuperCollider, installation_art.scd uses the incoming stream of data to trigger OSC functions that control the synths.
## Controls
Piezoelectric sensor - makes gong sound upon vibration (i.e knocking, tapping, etc.)
Capacitive sensor - plays sound only when box is lifted (ideally)

