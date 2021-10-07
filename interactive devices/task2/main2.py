import turtle
import serial
import time

greg = turtle.Turtle()
screen = turtle.Screen()
buttonState = 0


def readFromSerial():
    ser = serial.Serial()
    ser.baudrate = 9600
    #ser.port = '/dev/cu.SLAB_USBtoUART'
    ser.port = '/dev/ttyUSB0'
    ser.open()

    ser_input = ser.readline()
    try:
        line = ser_input.decode("utf-8")
        print(line)
        line = line[:len(line)-1]
        format_input = line.split(" ")
    except Exception:
        readFromSerial()
    ser.close()
    time.sleep(0.1)
    return format_input

def up():
    greg.setheading(90)
    greg.forward(25)

def down():
    greg.setheading(270)
    greg.forward(25)

def left():
    greg.setheading(180)
    greg.forward(25)

def right():
    greg.setheading(0)
    greg.forward(25)

def forward(i):
    i = i/4
    greg.forward(i)

def init_settings():
    greg.speed(0)
    greg.width(3)


def main():
    pen_state = 1
    init_settings()

    while True:
        uinput = readFromSerial()
        if len(uinput) < 4:
            continue
        try:
            x = int(uinput[2])
            y = int(uinput[3])
            sw = int(uinput[1])
            button = int(uinput[0])
        except Exception:
            continue
        #check for restart
        if button == 0:
            screen.resetscreen()
            init_settings()
        #check for pen
        if sw == 0:
            if pen_state == 0:
                pen_state = 1
                greg.pendown()
            elif pen_state == 1:
                pen_state = 0

        if pen_state == 0:
            greg.penup()
            if x < 1200:
                right()
            if x > 1300:
                left()
            if y < 1300:
                up()
            if y > 1400:
                down()
        else:
            if x < 1200:
                greg.circle(100)
            if x > 1300:
                greg.circle(50, 180)
            if y < 1300:
                a = greg.xcor()
                b = greg.ycor()
                forward(abs(y))
                greg.goto(a,b)
                greg.left(50)

            if y > 1400:
                forward(200)
                greg.right((y-1400)/3)
    #readFromSerial()
    #turtle.mainloop()
    turtle.done()

if __name__ == "__main__":
    main()
