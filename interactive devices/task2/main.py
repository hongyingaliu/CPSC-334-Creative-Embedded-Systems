# import relevant modules including python turtle and pyserial
import turtle
import serial
import time
import random

# GLOBAL VARIABLES
# create turtle object
greg = turtle.Turtle()
# create screen object
screen = turtle.Screen()
# screen width
width = screen.window_width()
# screen height
height = screen.window_height()
# set length of mouse travel
a = 10
# lastangle = 0

# collection of rgb values for three palettes
# split into background color and set of 6 other colors
palette_one_bg = [0, 18, 25]
palette_one = [[10, 14, 150], [233, 216, 166], [0, 95, 115], [238, 155, 0], [202, 103, 2], [155, 34, 38]]
palette_two_bg = [255, 175, 204]
palette_two = [[1, 42, 94], [205, 180, 210], [255, 200, 221], [242, 132, 130], [189, 224, 254], [162, 210, 255]]
palette_three_bg = [251, 86, 7]
palette_three = [[255, 190, 11], [131, 56, 236], [255, 0, 100], [131, 56, 236], [58, 13, 255], [34, 34, 59], [255, 250, 250]]
counter = 0


# function to read input from serial
def readFromSerial():
    # set up port connection
    ser = serial.Serial()
    ser.baudrate = 9600
    # Uncomment port depending on which device is being used
    # Mac port
    ser.port = '/dev/cu.SLAB_USBtoUART'
    # Raspi port
    #ser.port = '/dev/ttyUSB0'
    ser.open()

    # read by line
    ser_input = ser.readline()
    try:
        # decode and format
        line = ser_input.decode("utf-8")
        print(line)
        line = line[:len(line) - 1]
        format_input = line.split(" ")
    # occasional error occurs, try again if case
    except Exception:
        readFromSerial()
    ser.close()
    # wait
    time.sleep(0.1)
    # return input as list
    return format_input


# navigation functions for when pen is lifted
# sets correct direction and forward pace of 25
# move up
def up():
    greg.setheading(90)
    greg.forward(a)

# move down
def down():
    greg.setheading(270)
    greg.forward(a)

# move left
def left():
    greg.setheading(180)
    greg.forward(a)

# move right
def right():
    greg.setheading(0)
    greg.forward(a)


# function that determines forward length by variable
def forward(i):
    i = i / 4
    greg.forward(i)


# inital drawing settings
def init_settings(palette, bg):
    screen.colormode(255)
    greg.speed(0)
    greg.width(2)
    choose_color(palette, 0)
    x = bg[0]
    y = bg[1]
    z = bg[2]
    screen.bgcolor(x, y, z)

#choose the next color 
def choose_color(palette, counter):
    i = counter % 6
    color = palette[i]
    a = color[0]
    b = color[1]
    c = color[2]
    greg.color(a, b, c)


# main
def main():
    # setup everything, pen, canvas, etc.
    counter = 1
    pen_state = 1
    #screen.setup(width=1.0, height=1.0, startx=None, starty=None)
    screen.title("Your personal canvas")
    chance = random.randint(0, 2)
    if chance == 0:
        palette = palette_one
        bg = palette_one_bg
    elif chance == 1:
        palette = palette_two
        bg = palette_two_bg
    else:
        palette = palette_three
        bg = palette_three_bg
    init_settings(palette, bg)
    # screen.screensize(canvwidth=1280,canvheight=720)

    while True:
        # grab user input
        uinput = readFromSerial()
        # error where occasionally input is skipped
        if len(uinput) < 5:
            continue
        try:
            # read in all inputs: joystick, button, switch
            x = int(uinput[2])
            y = int(uinput[3])
            sw = int(uinput[1])
            button = int(uinput[0])
            switch = int(uinput[4])
        # don't just throw exception if input error occurs, try again
        except Exception:
            continue
        # check button push for restart
        if button == 0:
            screen.resetscreen()
            init_settings(palette, bg)
        # check for pen
        # if joystick button is pushed lift/putdown pen
        if sw == 0:
            if pen_state == 0:
                pen_state = 1
                greg.pendown()
                choose_color(palette_one, counter)
                # global counter
                counter += 1
            elif pen_state == 1:
                pen_state = 0
        # if pen is lifted call navigation functions
        if pen_state == 0:
            greg.penup()
            if x < 1200:
                if greg.xcor() > width - 10:
                    continue
                else:
                    right()
            if x > 1400:
                if greg.xcor() < 0 - width + 10:
                    continue
                else:
                    left()
            if y < 1300:
                if greg.ycor() < 0 - height + 10:
                    continue
                else:
                    up()
            if y > 1400:
                if greg.ycor() > height - 10:
                    continue
                else:
                    down()
            # print(greg.xcor())
            # print(greg.ycor())

        # otherwise draw
        else:
            if switch == 0:
                greg.begin_fill()
            # right draw circles
            if x < 1200:
                greg.circle(50)
            # left draw semicircles
            if x > 1400:
                greg.circle(40, 180)
            # if up draw asterisk shape
            if y < 1300:
                a = greg.xcor()
                b = greg.ycor()
                forward(abs(y))
                greg.goto(a, b)
                greg.left(20)
            # if down draw randomly determined lines and angles
            if y > 1400:
                forward(50)
                j = (y - 1400) / 3
                # lastangle = j
                # if greg.xcor() > width/2 or greg.xcor() < 0-(width/2):
                # greg.setheading(360-lastangle)
                # forward(50)
                # if greg.ycor() > height/2 or greg.ycor() < 0-(height/2):
                # greg.setheading(180-lastangle)
                # forward(50)
                greg.right(j)
            if switch == 0:
                greg.end_fill()
    # readFromSerial()
    # turtle.mainloop()
    turtle.done()


# call main
if __name__ == "__main__":
    main()
