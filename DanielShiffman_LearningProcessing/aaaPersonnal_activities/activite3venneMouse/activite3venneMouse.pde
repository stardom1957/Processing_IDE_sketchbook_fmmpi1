/* 3 intersecting circles. While the mouse moves inside one of the circle
     the color of that circle is changed and intersections are taken into
     account.
*/
int centerWindowX;
int centerWindowY;
int radius = 150;
int offset = 50;
int c1x;
int c1y;
int c2x;
int c2y;
int c3x;
int c3y;


void setup() {
 size(800, 480);
 centerWindowX = int(width/2);
 centerWindowY = int(height/2);
 
 background(255);
 c1x = int(centerWindowX - offset);
 c1y = int(centerWindowY - offset);
 c2x = int(centerWindowX + offset);
 c2y = int(centerWindowY - offset);
 c3x = int(centerWindowX);
 c3y = int(centerWindowY + offset);

 drawCrosshair(c1x, c1y, 0);
 drawCrosshair(c2x, c2y, 0);
 drawCrosshair(c3x, c3y, 0);
 stroke(0);
 strokeWeight(1);
 fill(255);
 ellipse(c1x, c1y, radius, radius);
 ellipse(c2x, c2y, radius, radius);
 ellipse(c3x, c3y, radius, radius);

}

// draws crosshair see tools ... 
void drawCrosshair(int x, int y, int greyTone) {
  int gap = 3;
  int l = 7;
  stroke(greyTone);
  strokeWeight(0);
  point(x, y);
  line(x, y-gap, x, y-gap-l);
  line(x-gap, y, x-gap-l, y);
  line(x, y+gap, x, y+gap+l);
  line(x+gap, y, x+gap+l, y);
  noFill();
}

int distance(int x1, int y1, int x2, int y2) {
  return int(sqrt(sq(x2-x1) + sq(y2-y1)));
}

void draw() {
 background(255);
 drawCrosshair(mouseX, mouseY, 0);
 ellipseMode(CENTER);
 stroke(1);
 strokeWeight(1);
 fill(255);

 //check c1
 if (distance(mouseX, mouseY, c1x, c1y) < radius/2) {
   fill(255, 0, 0, 127); 
 } else {
    fill(255);
   }
 ellipse(c1x, c1y, radius, radius);

 //check c2
 if (distance(mouseX, mouseY, c2x, c2y) < radius/2) {
   fill(0, 255, 0, 127); 
 } else {
    fill(255);
   }
 ellipse(c2x, c2y, radius, radius);

 //check c3
 if (distance(mouseX, mouseY, c3x, c3y) < radius/2) {
   fill(0, 0, 255, 127); 
 } else {
    fill(255);
   }
 ellipse(c3x, c3y, radius, radius);

/*
 noFill();
 arc(float(c1x), float(c1y), float(radius), float(radius), -0.3*PI, 0.75*PI);
 arc(float(c2x), float(c2y), float(radius), float(radius), 0.4*PI, 0.9*PI);
*/
}
