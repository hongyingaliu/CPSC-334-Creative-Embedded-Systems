import argparse
import socket
from pythonosc import udp_client
from pythonosc import osc_message_builder
import time

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind(('172.29.21.84', 8090))
s.listen(0)
#sc_client = udp_client.SimpleUDPClient('172.29.21.84', 57121)

while True:
    client, addr = s.accept()
    sc_content = 0

    while True:
        content = (client.recv(1024)).decode("utf-8")

        if len(content) == 0:
            break
        else:
            sc_content = content
            print(sc_content)
    #print("closing connection")
    client.close()

    all_input = sc_content.split(" ")
    l1 = all_input[0]   #bottom
    l2 = all_input[1]   #right
    l3 = all_input[2]   #left
    l4 = all_input[3]   #
    p1 = all_input[4]   #piezo
    c1 = all_input[5]   #capacitive touch

    if int(c1) > 50:
        continue
    else:
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
