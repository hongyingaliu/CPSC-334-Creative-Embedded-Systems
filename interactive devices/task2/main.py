import serial
import turtle
import time

greg = turtle.Turtle()
screen = turtle.Screen()

def readFromSerial():
    ser = serial.Serial()
    ser.baudrate = 9600
    ser.port = '/dev/cu.SLAB_USBtoUART'
    ser.open()

    ser_input = ser.readline()
    line = ser_input.decode("utf-8")
    print(line)
    line = line[:len(line)-1]
    format_input = line.split(" ")
    ser.close()
    time.sleep(0.1)
    return format_input

def up():
    greg.setheading(90)
    greg.forward(50)

def down():
    greg.setheading(270)
    greg.forward(50)

def left():
    greg.setheading(180)
    greg.forward(50)

def right():
    greg.setheading(0)
    greg.forward(50)

def main():
    greg.speed(0)
    greg.width(3)

    while True:
        uinput = readFromSerial()
        if len(uinput) < 4:
            continue
        x = int(uinput[2])
        y = int(uinput[3])

        if x < 1200:
            right()
        if x > 1300:
            left()
        if y < 1300:
            up()
        if y > 1400:
            down()
    #readFromSerial()
    #turtle.mainloop()
    turtle.done()

if __name__ == "__main__":
    main()
