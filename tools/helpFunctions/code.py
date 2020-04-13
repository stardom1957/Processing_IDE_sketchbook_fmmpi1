'''
La classe Point définie un point dans l'espace géométrique cartésien tradidionnel O.

   Les méthodes set permettent de transformer un point vers l'espace géométrique de Processing (p)
   dont tous les axes sont positifs et l'axe Y est inversé.
# origin of cartesian space
// draws crosshair 

def drawCrosshair(float x, float y, color c):
  gap = 3 # provide separation from center pixel
  l = 7;  # lenght
  strokeWeight(1)
  stroke(c)
  point(x, y)
  line(x, y-gap, x, y-gap-l)
  line(x-gap, y, x-gap-l, y)
  line(x, y+gap, x, y+gap+l)
  line(x+gap, y, x+gap+l, y)
  noStroke()

    col = color(255, 0, 0)
    p = Point(0, 0)
    drawCrosshair(p, col)
    println("(p.xo, p.yo)= ({}, {})".format(p.xo, p.yo))
    println("(p.xp, p.yp)= ({}, {})".format(p.xp, p.yp))
    
    p.seto(75, 75)
    println("(p.xo, p.yo)= ({}, {})".format(p.xo, p.yo))
    println("(p.xp, p.yp)= ({}, {})".format(p.xp, p.yp))
    drawCrosshair(p, color(0, 0, 255))
    noFill()
    stroke(color(0, 0, 255))
    strokeWeight(5)
    circle(p.xp, p.yp, 40)
    
    p.seto(0, 10)
    drawCrosshair(p, color(0, 255, 255))
     
    p.seto(10, 0)
    drawCrosshair(p, color(192, 255, 255))


'''
