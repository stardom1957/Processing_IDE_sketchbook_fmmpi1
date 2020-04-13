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
  float x_pp, y_pp; // x, y dans Processing (Processing point)
  float x_cart, y_cart; // x, y dans l'espace cartésien
  Point () { // x, y dans l'espace cartésien
    x_cart = 0;
    y_cart = 0;
    x_pp = 0;
    y_pp = 0;
  }
  void set(float xcart, float ycart) {
    x_cart = xcart; //coord cartésiennes
    y_cart = ycart;
    x_pp   = xcart + Ox; // coordonnée Processing
    y_pp   = Oy - ycart;
  }

}

//dessiner cercle au point c de rayon R
void cercle(Point p, float rayon) {
 ellipseMode(CENTER);
 stroke(1);
 strokeWeight(0);
 noFill();
 circle(p.x_pp, p.y_pp, rayon * 2); // Processing utilise le diamètre
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

// calcule la distance entre deux points pp

float distance(Point p1, Point p2) {
  return sqrt(sq(p2.x_pp - p1.x_pp) + sq(p2.y_pp - p1.y_pp));
}

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
 
float x, y; //pour les calculs

void setup() {
 size(800, 480);
 centreFenetreX = width/2;
 centreFenetreY = height/2;
 Ox = centreFenetreX;
 Oy = centreFenetreY; // point O, origine du système

 // sommets du triangle OSU
 /*
  O...S
   . .
    U
 */
 O.set(0, 0);      // origine et sommet O
 S.set(d, 0); //sommet S

 x = d/2;
 y = - (sqrt(0.75*sq(d)));
 U.set(x, y); // sommet U

 x = d/2;
 y = -((d/2)*tan(radians(30)));
 T.set(x, y);
 
 background(255);
 //************************************ 
 // Montage géométrique de base
 // dessiner les points OSU et T
 // dessiner les cordes des intersections
 // des cercles deux à deux
 //***********************************

 drawCrosshair(O.x_pp, O.y_pp, 0);
 drawCrosshair(S.x_pp, S.y_pp, 0);
 drawCrosshair(U.x_pp, U.y_pp, 0);
 drawCrosshair(T.x_pp, T.y_pp, 0);
 
 //dessiner cercles C1, C2 et C3 de rayon R
 cercle(O, R);
 cercle(S, R);
 cercle(U, R);

 // calculer la corde de l'intersection C1/C2
 // (x1, x1) et (x2, y2)
 println("R= " + R + ", " + "d= " + d);
 println("                  (Ox, Oy)= (" + Ox + ", " + Oy + ")");
 x = d/2;
 y = sqrt(sq(R) - sq(d/2));
 X1Y1.set(x, y);
 color col = color(0, 255, 0); //vert
 drawCrosshair(X1Y1.x_pp, X1Y1.y_pp, col);
 println("    (X1Y1.x_pp, X1Y1.y_pp)= (" + X1Y1.x_pp + ", " + X1Y1.y_pp + ")");
 println("(X1Y1.x_cart, X1Y1.y_cart)= (" + X1Y1.x_cart + ", " + X1Y1.y_cart + ")");
 
 x = d/2;
 y = -sqrt(sq(R) - sq(d/2));
 X2Y2.set(x, y);
 drawCrosshair(X2Y2.x_pp, X2Y2.y_pp, col);
 

}

void draw() {
 //background(255);
 //drawCrosshair(mouseX, mouseY, 0);
 //tracer la corde de l'intersection C1/C2
 color col1 = color(0, 255, 0); //vert
 stroke(col1);
 strokeWeight(1);
 line(X1Y1.x_pp, X1Y1.y_pp, X2Y2.x_pp, X2Y2.y_pp);
 
}
