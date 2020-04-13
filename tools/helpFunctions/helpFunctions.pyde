class Point:
  """Defines a point in the cartesian space (o) and transforms it in the Processing (P) space for drawing"""
  # the constructor initializes the point in the O space and P space
  def __init__(self, x=0, y=0):
    # in O space
    self.xo = x
    self.yo = y
    # in P space
    self.xp = self.xo + Ox
    self.yp = Oy - self.yo
    #self.yp = self.yo + Oy
  
  # resets the point in the O space and transform into P space
  def seto(self, x_o, y_o):
    #in Processing space
    self.xo = x_o
    self.yo = y_o
    self.xp = x_o + Ox
    self.yp = Oy - y_o

def drawCrosshair(p, col=0):
  """ Draws a crosshair around a single pixel in P space as a marker as necessary"""
  gap = 3 # provides separation from center pixel to crosshair
  l = 7;  # lenght
  strokeWeight(1)
  stroke(col)
  point(p.xp, p.yp)
  line(p.xp, p.yp - gap, p.xp, p.yp - gap - l)
  line(p.xp - gap, p.yp, p.xp - gap - l, p.yp)
  line(p.xp, p.yp + gap, p.xp, p.yp + gap + l)
  line(p.xp + gap, p.yp, p.xp + gap + l, p.yp)
  noStroke()

def setup():
    size(800, 640) # same as Nextion 5" HMI
    background(255)
    global Ox
    global Oy
    Ox = width/2
    Oy = height/2

def draw():
    stroke(1)
    strokeWeight(1)
    p1 = Point(-40, 0)
    p2 = Point()
    p3 = Point(40, 0)
    rectMode(CORNERS)
    drawCrosshair(p2, 0)
    fill(192)
    #arcCenter = PI + HALF_PI
    rad = radians(1) # on degrees in radians
    beam = 10 # beam of arc in degrees
    r = 150   # radius or (range) of beam
    
    dir = 320
    arc(p1.xp, p1.yp, r, r, ((dir-90) * rad) - (beam * rad / 2), ((dir-90) * rad) + (beam * rad /2))
    dir = 0
    arc(p2.xp, p2.yp, r, r, ((dir-90) * rad) - (beam * rad / 2), ((dir-90) * rad) + (beam * rad /2))
    dir = 40
    arc(p3.xp, p3.yp, r, r, ((dir-90) * rad) - (beam * rad / 2), ((dir-90) * rad) + (beam * rad /2))
    stroke(0)
    line(p1.xp, p1.yp, p3.xp, p3.yp)
