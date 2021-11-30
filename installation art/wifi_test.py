#import relevant libraries including osc
import argparse
import socket
from pythonosc import udp_client
from pythonosc import osc_message_builder
import time

#set up right port
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind(('172.29.21.84', 8090))
s.listen(0)
#sc_client = udp_client.SimpleUDPClient('172.29.21.84', 57121)

while True:
    client, addr = s.accept()
    sc_content = 0

    while True:
        #decode received info from wifi client
        content = (client.recv(1024)).decode("utf-8")
        #if nothing was sent don't continue
        if len(content) == 0:
            break
        else:
            sc_content = content
            print(sc_content)
    #print("closing connection")
    client.close()
    
    #split sensors into list
    all_input = sc_content.split(" ")
    #assign each data number to the correct sensor
    l1 = all_input[0]   #bottom
    l2 = all_input[1]   #right
    l3 = all_input[2]   #left
    l4 = all_input[3]   #middle
    p1 = all_input[4]   #piezo
    c1 = all_input[5]   #capacitive touch
    
    #check for capacitive touch, else don't do anything
    if int(c1) > 50:
        continue
    else:
        #sent data to SC with tags
        parser = argparse.ArgumentParser()
        parser.add_argument("--ip", default="172.29.21.84",
                            help="The ip of the OSC server")

        parser.add_argument("--port", type=int, default=57120,
                            help="The port the OSC server is listening on")
        args = parser.parse_args()
        sc_client = udp_client.SimpleUDPClient(args.ip, args.port)
        sc_client.send_message("/light1", int(l1))
        sc_client.send_message("/light2", int(l2))
        sc_client.send_message("/light3", int(l3))
        sc_client.send_message("/light4", int(l4))
        sc_client.send_message("/piezo", int(p1))
        sc_client.send_message("/cap", int(c1))
