void setup() {
 size(800, 480);
 background(255);
}
// draws crosshair see tools ... 
void drawCrosshair(int x, int y, int greyTone) {
  int gap = 3;
  int l = 7;
  stroke(greyTone);
  point(x, y);
  line(x, y-gap, x, y-gap-l);
  line(x-gap, y, x-gap-l, y);
  line(x, y+gap, x, y+gap+l);
  line(x+gap, y, x+gap+l, y);
  noFill();
}

void draw() {
  //background(255);
  ellipseMode(CENTER);
  rectMode(CORNER);
  //1-3
  stroke(0);
  int cpx = 10;
  int cpy = 10;
  drawCrosshair(cpx, cpy, 0);
  fill(155);
  rect(cpx, cpy, 15, 35);
  
  noFill();
  cpx = 35;
  cpy = 35;
  int pSize = 35;
  drawCrosshair(cpx, cpy, 0);
  ellipse(cpx, cpy, pSize, pSize);
  
  //1-4 checker pattern
  cpx = 60;
  cpy = 20;
  pSize = 35;
  drawCrosshair(cpx, cpy, 0);
  fill(0);
  rect(cpx, cpy, pSize, pSize);
  fill(255);
  rect(cpx+pSize, cpy, pSize, pSize);
  rect(cpx, cpy+pSize, pSize, pSize);
  fill(127);
  rect(cpx+pSize, cpy+pSize, pSize, pSize);
  
  //1-4, 1-5 checker pattern in color and transparency
  cpx = 145;
  cpy = 20;
  pSize = 35;
  drawCrosshair(cpx, cpy, 0);
  fill(255, 0, 0);
  rect(cpx, cpy, pSize, pSize);
  fill(0, 255, 0);
  rect(cpx+pSize, cpy, pSize, pSize);
  fill(0, 0, 255);
  rect(cpx, cpy+pSize, pSize, pSize);
  fill(0, 0, 0);
  rect(cpx+pSize, cpy+pSize, pSize, pSize);
  
  cpx = 225;
  cpy = 20;
  pSize = 35;
  drawCrosshair(cpx, cpy, 0);
  fill(127, 0, 0);
  rect(cpx, cpy, pSize, pSize);
  fill(0, 127, 0);
  rect(cpx+pSize, cpy, pSize, pSize);
  fill(0, 0, 127);
  rect(cpx, cpy+pSize, pSize, pSize);
  fill(127, 127, 127);
  rect(cpx+pSize, cpy+pSize, pSize, pSize);
  
  //intersecting circles with different transparency
  cpx = 420;
  cpy = 100;
  pSize = 100;
  float or = 2.4; // offset ration provides overlap
  fill(255, 0, 0); // CENTER red 100%
  ellipse(cpx, cpy, pSize, pSize);
  fill(0, 255, 0, 127); // green 50%
  ellipse(cpx-pSize/or, cpy-pSize/or, pSize, pSize);
  fill(0, 0, 255, 127); // blue 50%
  ellipse(cpx+pSize/or, cpy-pSize/or, pSize, pSize);
  fill(255, 255, 142, 127); // yellowish 50%
  ellipse(cpx-pSize/or, cpy+pSize/or, pSize, pSize);
  fill(255, 142, 244, 127); // pinkish 50%
  ellipse(cpx+pSize/or, cpy+pSize/or, pSize, pSize);

  drawCrosshair(cpx, cpy, 255);
 
 //1-5 zoog!
 ellipseMode(CENTER);
 rectMode(CENTER);
 int zoogOriginX = 575;
 int zoogOriginY = 110;
 drawCrosshair(zoogOriginX, zoogOriginY, 0);
 stroke(0);
 fill(150);
 rect(zoogOriginX, zoogOriginY, 20, 100);
 fill(255);
 ellipse(zoogOriginX, zoogOriginY-30, 60, 60);
 fill(0);
 ellipse(zoogOriginX-18, zoogOriginY-30, 16, 32);
 ellipse(zoogOriginX+18, zoogOriginY-30, 16, 32);
 stroke(0);
 //drawCrosshair(zoogOriginX-10, zoogOriginY+50, 0);
 line(zoogOriginX-10, zoogOriginY+50, zoogOriginX-20, zoogOriginY+60);
 //drawCrosshair(zoogOriginX+10, zoogOriginY+50, 0);
 line(zoogOriginX+10, zoogOriginY+50, zoogOriginX+20, zoogOriginY+60);

}
