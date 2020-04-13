/* Montage géométrique
 A. ESPACE GÉOMÉTRIQUE CARTÉSIEN ET DE PROCESSING
 L'espace cartésien est centré à (0, 0) avec l'axe X positif vers la droit et l'axe Y positif
 vers le haut. L'espace de Processing a aussi l'axe X positif vers la droit, mais l'axe Y est positif
 vers le bas.
 
 B. MÉTHODE DE CALCUL
 Tous les calculs géométriques seront effectués dans l'espace cartésien centré aux point O
 (0, 0) (qui devriendra (Ox, Oy) dans Processing). Les points géométriques obtenus seront convertis
 avant tracage dans Processing selon la formule dans C.
 
 C. FORMULES DE CONVERSION DE L'ESPACE CARTÉSIEN VERS L'ESPACE DE PROCESSING
 Soit O (Ox, Oy) les coordonnées «réeles» de O dans Processing, le point cartésien (x, y) sera convertit dans l'espace
 de Processing avec la fonction suivante :
 
  P(x, y) = (x + Ox, -(y + Oy)). Ce point sera noté (x, y)O (référence au point O).
  
 D. MONTAGE GÉOMÉTRIQUE DE BASE DANS L'ESPACE CARTÉSIEN - TRIANGLE OSU ET CERCLES C1, C2 ET C3
 Soit un triangle équilatéral formé des points O, S et U. Le coté du triangle OSU est d
 et les sommets seront :
 
 Le point O (0, 0)O, le centre du cercle C1 de rayon R; l'origine du système.
 Le point S (d/2, 0)O, le centre du cercle C2 de rayon R.
 Le point U (d/2, -sqrt(0.75d^2))O, le centre du cercle C3 de rayon R.
 
 Le centre T du triangle OSU sera (d/2, -(d/2)tan(30))O.
 
*/

// la classe PP (P Processing) définie un point x, y cartésien dans l'espace de processing

class Point {
  float xp, yp; // x, y dans l'espace Processing (coin sup gauche fenêtre)
  float xc, yc; // x, y dans l'espace cartésien centré sur O (pour la géométrie)
  float xt, yt; // x, y dans l'espace cartésien centré sur T (pour la géométrie)
  Point () {
    xc = 0; // espace cartésien origine O
    yc = 0;
    xp = 0; // espace Processing
    yp = 0;
    xt = 0; // espace cartésien origine T
    yt = 0;
  }
  void setc(float xcart, float ycart) {
    xc = xcart;
    yc = ycart;
    xp = xcart + Ox;
    yp = Oy - ycart;
    xt = xcart - (d/2);
    yt = ycart + ((d/2) * tan(radians(30)));
  }
  void sett(float x_t, float y_t) {
    xt = x_t;
    yt = y_t;
    xc = x_t + (d/2);
    yc = y_t - ((d/2) * tan(radians(30)));
    xp = xc + Ox;
    yp = Oy - yc;
  }

}

//effectue une rotation d'angle +ou- alpha autour du point T
void rotationT(Point p, float alpha) {
  x = p.xt * cos(radians(alpha)) + p.yt * sin(radians(alpha));
  y = p.yt * cos(radians(alpha)) - p.xt * sin(radians(alpha));
}

//dessiner cercle au point p de rayon r
void cercle(Point p, float r) {
 ellipseMode(CENTER);
 stroke(1);
 strokeWeight(0);
 noFill();
 circle(p.xp, p.yp, r * 2); // Processing utilise le diamètre
}


// draws crosshair see tools ... 
void drawCrosshair(float x, float y, color c) {
  int gap = 3; // provide separation from center pixel
  int l = 7;   // lenght
  strokeWeight(1);
  stroke(c);
  point(x, y);
  line(x, y-gap, x, y-gap-l);
  line(x-gap, y, x-gap-l, y);
  line(x, y+gap, x, y+gap+l);
  line(x+gap, y, x+gap+l, y);
  noFill();
  noStroke();
}

// calcule la distance entre deux points dans l'espace p

float distance(Point p1, Point p2) {
  return sqrt(sq(p2.xp - p1.xp) + sq(p2.yp - p1.yp));
}

//*************************************************************
//*************************************************************
//*************************************************************
//*************************************************************
// Définition de l'environnement
float centreFenetreX;
float centreFenetreY;
float Ox, Oy; // point O, origine du système

float d = 150.0; // côté de OSU
float R = 100.0;    // rayon de C1, C2 et C3 : ATTENTION, circle utilise R * 2!!!

Point O = new Point();    // origine et sommet O
Point S = new Point();    //sommet S
Point U = new Point();    // sommet U
Point T = new Point();    // centre triamgle OSU
Point X1Y1 = new Point(); // 1er point corde intersection C1/C2
Point X2Y2 = new Point(); // 2e point corde intersection C1/C2
Point X3Y3 = new Point(); // 1er point corde intersection C2/C3
Point X4Y4 = new Point(); // 2e point corde intersection C2/C3
Point X5Y5 = new Point(); // 1er point corde intersection C1/C3
Point X6Y6 = new Point(); // 2e point corde intersection C1/C3
 
float x, y; //pour les calculs

void setup() {
 size(800, 480);
 centreFenetreX = width/2;
 centreFenetreY = height/2;
 Ox = centreFenetreX;
 Oy = centreFenetreY - 37; // point O, origine du système

 // sommets du triangle OSU
 /*
  O...S
   . .
    U
 */
 O.setc(0, 0);      // origine et sommet O
 S.setc(d, 0); //sommet S

 x = d/2;
 y = - (sqrt(0.75*sq(d)));
 U.setc(x, y); // sommet U

 x = d/2;
 y = -((d/2)*tan(radians(30)));
 T.setc(x, y);
 
 background(255);
 //************************************ 
 // Montage géométrique de base
 // dessiner les points OSU et T
 // dessiner les cordes des intersections
 // des cercles deux à deux
 //***********************************

 drawCrosshair(O.xp, O.yp, 0);
 drawCrosshair(S.xp, S.yp, 0);
 drawCrosshair(U.xp, U.yp, 0);
 drawCrosshair(T.xp, T.yp, 0);
 
 //dessiner cercles C1, C2 et C3 de rayon R
 cercle(O, R);
 cercle(S, R);
 cercle(U, R);

 // calculer la corde de l'intersection C1/C2
 // (x1, x1) et (x2, y2)
 println("R= " + R + ", " + "d= " + d);
 println("(Ox, Oy)= (" + Ox + ", " + Oy + ")");
 x = d/2;
 y = sqrt(sq(R) - sq(d/2));
 X1Y1.setc(x, y);
 color col = color(0, 255, 0); //vert
 drawCrosshair(X1Y1.xp, X1Y1.yp, col);
 
 x = d/2;
 y = -sqrt(sq(R) - sq(d/2));
 X2Y2.setc(x, y);
 drawCrosshair(X2Y2.xp, X2Y2.yp, col);

 // calculer la corde de l'intersection C2/C3
 // X3Y3, X4Y4
 // la rotation de +120° de X1Y1 donne X4Y4
 // la rotation de +120° de X2Y2 donne X3Y3
 
 rotationT(X1Y1, 120);
 X4Y4.sett(x, y);
 col = color(0 , 0, 255); // bleu
 drawCrosshair(X4Y4.xp, X4Y4.yp, col);
 
 rotationT(X2Y2, 120);
 X3Y3.sett(x, y);
 col = color(0 , 0, 255); // bleu
 drawCrosshair(X3Y3.xp, X3Y3.yp, col);

 // calculer la corde de l'intersection C1/C3
 // X5Y5, X6Y6
 // la rotation de -120° de X1Y1 donne X6Y6
 // la rotation de -120° de X2Y2 donne X5Y5

 rotationT(X1Y1, -120);
 X6Y6.sett(x, y);
 col = color(0 , 128, 255); // bleu qqc
 drawCrosshair(X6Y6.xp, X6Y6.yp, col);
 
 rotationT(X2Y2, -120);
 X5Y5.sett(x, y);
 col = color(0 , 128, 255); // bleu qqc
 drawCrosshair(X5Y5.xp, X5Y5.yp, col);

}

//****************************************
//****************************************
void draw() {
 //background(255);
 //drawCrosshair(mouseX, mouseY, 0);
 //tracer la corde de l'intersection C1/C2
 color col1 = color(0, 255, 0); //vert
 stroke(col1);
 strokeWeight(1);
 line(X1Y1.xp, X1Y1.yp, X2Y2.xp, X2Y2.yp);

 //tracer la corde de l'intersection C2/C3
 col1 = color(0, 0, 255); // bleu
 stroke(col1);
 strokeWeight(1);
 line(X3Y3.xp, X3Y3.yp, X4Y4.xp, X4Y4.yp);

 //tracer la corde de l'intersection C1/C3
 col1 = color(0, 120, 255); // bleu qqc
 stroke(col1);
 strokeWeight(1);
 line(X5Y5.xp, X5Y5.yp, X6Y6.xp, X6Y6.yp);
}
