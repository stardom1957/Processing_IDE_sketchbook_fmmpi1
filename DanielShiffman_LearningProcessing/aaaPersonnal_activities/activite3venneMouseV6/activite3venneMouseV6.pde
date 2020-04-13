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
  float xo, yo; // x, y dans l'espace cartésien centré sur O (pour la géométrie)
  float xs, ys; // x, y dans l'espace cartésien centré sur S (pour la géométrie)
  float xu, yu; // x, y dans l'espace cartésien centré sur U (pour la géométrie)
  float xt, yt; // x, y dans l'espace cartésien centré sur T (pour la géométrie)

  Point () {
    //coordonnées :
    xo = 0;  // espace cartésien origine O
    yo = 0;
    xs = 0; // espace cartésien origine S
    ys = 0;
    xu = 0; // espace cartésien origine U
    yu = 0;
    xp = 0; // espace Processing
    yp = 0;
    xt = 0; // espace cartésien origine T
    yt = 0;
  }
 
  // init d'un point en référence à O 
  void seto(float x_o, float y_o) {
    xo = x_o;
    yo = y_o;
    xp = x_o + Ox;
    yp = Oy - y_o;
    xt = x_o - (d/2);
    yt = y_o + ((d/2) * tan(radians(30)));
  }

  // init d'un point en référence à S 
  void sets(float x_s, float y_s) {
  }

  // init d'un point en référence à U 
  void setu(float x_st, float y_s) {
  }


  // init d'un point en référence à T 
  void sett(float x_t, float y_t) {
    xt = x_t;
    yt = y_t;
    xo = x_t + (d/2);
    yo = y_t - ((d/2) * tan(radians(30)));
    xp = xo + Ox;
    yp = Oy - xo;
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
Point A = new Point(); // 1er point corde intersection C1/C2
Point B = new Point(); // 2e point corde intersection C1/C2
Point C = new Point(); // 1er point corde intersection C2/C3
Point D = new Point(); // 2e point corde intersection C2/C3
Point E = new Point(); // 1er point corde intersection C1/C3
Point F = new Point(); // 2e point corde intersection C1/C3
 
float x, y; //pour les calculs

void setup() {
 size(800, 480);
 centreFenetreX = width/2;
 centreFenetreY = height/2;
 Ox = centreFenetreX + 55;
 Oy = centreFenetreY - 55; // point O, origine du système

 // sommets du triangle OSU
 /*
  O...S
   . .
    U
 */
 O.seto(0, 0);      // origine et sommet O
 S.seto(d, 0); //sommet S

 x = d/2;
 y = - (sqrt(0.75*sq(d)));
 U.seto(x, y); // sommet U

 x = d/2;
 y = -((d/2)*tan(radians(30)));
 T.seto(x, y);
 
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
 A.seto(x, y);
 color col = color(0, 255, 0); //vert
 drawCrosshair(A.xp, A.yp, col);
 
 x = d/2;
 y = -sqrt(sq(R) - sq(d/2));
 B.seto(x, y);
 drawCrosshair(B.xp, B.yp, col);

 // calculer la corde de l'intersection C2/C3
 // C, D
 // la rotation de +120° de A autour de T donne D
 
 rotationT(A, 120);
 D.sett(x, y);
 col = color(0 , 0, 255); // bleu
 drawCrosshair(D.xp, D.yp, col);

 // la rotation de +120° de B autour de T donne C
 rotationT(B, 120);
 C.sett(x, y);
 col = color(0 , 0, 255); // bleu
 drawCrosshair(C.xp, C.yp, col);

 // calculer la corde de l'intersection C1/C3
 // E, F
 // la rotation de -120° de A donne F
 // la rotation de -120° de B donne E

 rotationT(A, -120);
 F.sett(x, y);
 col = color(0 , 128, 255); // bleu qqc
 drawCrosshair(F.xp, F.yp, col);
 
 rotationT(B, -120);
 E.sett(x, y);
 col = color(0 , 128, 255); // bleu qqc
 drawCrosshair(E.xp, E.yp, col);

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
 line(A.xp, A.yp, B.xp, B.yp);

 //tracer la corde de l'intersection C2/C3
 col1 = color(0, 0, 255); // bleu
 stroke(col1);
 strokeWeight(1);
 line(C.xp, C.yp, D.xp, D.yp);

 //tracer la corde de l'intersection C1/C3
 col1 = color(0, 120, 255); // bleu qqc
 stroke(col1);
 strokeWeight(1);
 line(E.xp, E.yp, F.xp, F.yp);
}
