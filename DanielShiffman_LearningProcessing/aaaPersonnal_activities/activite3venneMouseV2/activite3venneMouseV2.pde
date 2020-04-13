/* 3 intersecting circles. While the mouse moves inside one of the circle
     the color of that circle is changed and intersections are taken into
     account.
*/
int centerWindowX;
int centerWindowY;
int radius = 150;
int offset = 50;
boolean insideC1;
int c1x;
int c1y;
boolean insideC2;
int c2x;
int c2y;
boolean insideC3;
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
 circle(c1x, c1y, radius);
 circle(c2x, c2y, radius);
 circle(c3x, c3y, radius);

}

// draws crosshair see tools ... 
void drawCrosshair(float x, float y, color c) {
  int gap = 3; // provide separation from center pixel
  int l = 7;   // lenght
  strokeWeight(0);
  stroke(c);
  point(x, y);
  line(x, y-gap, x, y-gap-l);
  line(x-gap, y, x-gap-l, y);
  line(x, y+gap, x, y+gap+l);
  line(x+gap, y, x+gap+l, y);
  noFill();
  noStroke();
}

float distance(float x1, float y1, float x2, float y2) {
  return sqrt(sq(x2-x1) + sq(y2-y1));
}

void drawC1(boolean inside ) {
 if (inside) {
   fill(255, 0, 0, 127);
 } else {
   fill(255);
   }
 circle(c1x, c1y, radius);
}

void drawC2(boolean inside) {
 if (inside) {
   fill(0, 255, 0, 127); 
 } else {
    fill(255);
   }
 circle(c2x, c2y, radius);
}

void drawC3(boolean inside) {
   if (inside) {
     fill(0, 0, 255, 127); 
   } else {
      fill(255);
     }
   circle(c3x, c3y, radius);
}

void draw() {
 //background(255);
 //drawCrosshair(mouseX, mouseY, 0);
 ellipseMode(CENTER);
 stroke(1);
 strokeWeight(1);
 //fill(255);

 //check c1
 if (distance(mouseX, mouseY, c1x, c1y) < radius/2) {
   insideC1 = true;
 } else {
   insideC1= false; 
   }

 //check c2
 if (distance(mouseX, mouseY, c2x, c2y) < radius/2) {
   insideC2 = true;
 } else {
   insideC2 = false; 
   }

 //check c3
 if (distance(mouseX, mouseY, c3x, c3y) < radius/2) {
   insideC3 = true; 
 } else {
    insideC3 = false;
   }

 drawC1(insideC1);
 drawC2(insideC2);
 drawC3(insideC3);


 noFill();
 arc(float(c1x), float(c1y), float(radius), float(radius), -0.3*PI, 0.75*PI);
 arc(float(c2x), float(c2y), float(radius), float(radius), 0.4*PI, 0.9*PI);
 //drawCrosshair(150, 250, 0);

 float beginX = 30;
 float beginY = 20;
 float   endX = 30;
 float   endY = 80;
 float control1X = 200;
 float control1Y = 50;
 float control2X = 200;
 float control2Y = 50;
 
 drawCrosshair(beginX, beginY, 0);
 drawCrosshair(control1X, control1Y, 0);
 stroke(0, 255, 0);
 line(beginX, beginY, control1X, control1Y);
 drawCrosshair(control2X, control2Y, 0);
 stroke(0, 255, 0);
 line(endX, endY, control2X, control2Y);
 drawCrosshair(endX, endY, 0);
// drawCrosshair(60, 25, 0);

 //line(80, 0, 80, 80);
 stroke(0);
 fill(127, 145, 68);
 noFill();
 beginShape();
 vertex(beginX, beginY);
 bezierVertex(control1X, control1Y, control2X, control2Y, endX, endY);
 //bezierVertex(50, 80, 60, 25, 30, 20);
 endShape();
 
 //test arc
 // first prepare a circle
 color color1 = color(45, 224, 23);
 float c4x = 150;
 float c4y = 200;
 float c4Radius = 150;
 drawCrosshair(c4x, c4y, color1);
 stroke(0);
 noFill();
 circle(c4x, c4y, c4Radius);
 
 //draw arcs
 stroke(color1);
 strokeWeight(3);

 noFill();
 arc(c4x, c4y, c4Radius, c4Radius, 0, HALF_PI);

 fill(127);
 arc(c4x, c4y, c4Radius, c4Radius, HALF_PI, PI);

 fill(192);
 arc(c4x, c4y, c4Radius, c4Radius, PI, PI + HALF_PI);

 fill(0);
 arc(c4x, c4y, c4Radius, c4Radius, PI + HALF_PI, TWO_PI);

 // this time all with CHORD parameter
 c4y = 360;
 
 drawCrosshair(c4x, c4y, color1);
 stroke(0);
 noFill();
 circle(c4x, c4y, c4Radius);
 
 //draw arcs
 stroke(color1);
 strokeWeight(3);

 noFill();
 arc(c4x, c4y, c4Radius, c4Radius, 0, HALF_PI, CHORD);

 fill(127);
 arc(c4x, c4y, c4Radius, c4Radius, HALF_PI, PI, CHORD);

 fill(192);
 arc(c4x, c4y, c4Radius, c4Radius, PI, PI + HALF_PI, CHORD);

 fill(0);
 arc(c4x, c4y, c4Radius, c4Radius, PI + HALF_PI, TWO_PI, CHORD);
 
}
