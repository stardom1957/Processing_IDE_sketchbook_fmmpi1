/*
 println("(X1Y1.xp, X1Y1.yp)= (" + X1Y1.xp + ", " + X1Y1.yp + ")");
 println("(X1Y1.xc, X1Y1.yc)= (" + X1Y1.xc + ", " + X1Y1.yc + ")");

 Point n = new Point();
 n.set(d/2, 0);
 drawCrosshair(n.xt, n.yt, 0);

 Point n = new Point();
 n.set(10, 0);
 println("(n.xt, n.yt)= (" + n.xt + ", " + n.yt + ")");




 //check c1
 byte insideRange = 0;
 if (distanceSouris(O) < R) {
   insideRange += 1;
 }
 //check c2
 if (distanceSouris(S) < R) {
   insideRange += 2;
 }
 //check c3
 if (distance(U) <R) {
   insideRange += 4; 
 }
 
 switch(insideRange) {
  case 1:
   drawC1(true);  // remplie c1
   drawC2(false); // efface c2
   drawC3(false); // efface c3
   break;

  case 2:
   drawC2(true);
   drawC1(false);
   drawC3(false);
   break;

  case 3: // c1 and c2 colored and c3 cleared
   drawC1(true);
   drawC2(true);
   drawC3(false);
   break;

  case 4:
   drawC3(true);
   drawC1(false);
   drawC2(false);
   break;
   
  case 5: // c1 and c3 colored and c2 cleared
   drawC3(true);
   drawC1(true);
   drawC2(false);
   break;
   
  case 6: // c2 and c3 colored and c1 cleared
   drawC3(true);
   drawC2(true);
   drawC1(false);
   break;

  case 7: // all cs cleard, only center is colored
   //for now clear all 3 ciciles and draw crosshair
   drawC3(false);
   drawC2(false);
   drawC1(false);
   stroke(0);
   strokeWeight(1);
   noFill();
   circle(c1x, c1y, radius);
   circle(c2x, c2y, radius);
   circle(c3x, c3y, radius);
   drawCrosshair(centerWindowX, centerWindowY-12, 0);
   break;

 } 
*/
