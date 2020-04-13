/* Montage géométrique
 A. ORIGINES ET CONVENTIONS DES ESPACES GÉOMÉTRIQUES UTILISÉS
     L'espace de Processing P a pour origine le coin supérieur gauche de la fenêtre de dessin, avec pour convention
     l'axe X positif vers la droite et l'axe Y positif vers le bas. L'espace géométrique O cartésien utilisé pour tous
     les calculs géométriques est centré au point O de coordonnées (0, 0) avec pour convention l'axe X positif vers
     la droite et l'axe Y positif vers le haut.
 
     L'origine de l'espace O est décallé de Ox, Oy dans l'espace P.
 
 B. TRANSFORMATIONS DE L'ESPACE GÉOMÉTRIQUE CARTÉSIEN VERS L'ESPACE DE PROCESSING
    Tous les calculs géométriques seront effectués dans l'espace cartésien O et les résultats
    seront ensuite transformés vers l'espace P pour le tracage.
    
    Un point de l'espace P est noté (xp, xp).
 
    La classe Point met en oeuvre toutes les transformations nécessaires d'un space à un autre.
   
 C. MONTAGE GÉOMÉTRIQUE DE BASE - TRIANGLE OSU ET CERCLES C1, C2 ET C3
    Soit un triangle équilatéral formé des points O, S et U. Le coté du triangle OSU est d
    et les sommets seront :
 
    Le point O, qui est aussi le centre du cercle C1 de rayon R, est l'origine du système.
     ... les points en référence à O sont notés xo, yo
    Le point S est qui est aussi le centre du cercle C2 de rayon R.
     ... les points en référence à S sont notés xs, ys
    Le point U qui est aussi le centre du cercle C3 de rayon R.
     ... les points en référence à U sont notés xu, yu
 
    Le centre géométrique T du triangle OSU.
     ... les points en référence à T sont notés xt, yt

  Version 9 :
   Implémentation de la règle des sinus pour calculer ws (w sinus)
 
*/

/* La classe Point définie un point dans les divers espaces géométriques.

   Les méthodes set permetent d'initialiser un point à partie de O ou de T, mais dans tous les
   cas, les point sont automatiquement transformés vers les autres espaces.
*/

float d = 175.0;  // côté du triangle OSU
float R = 125.0;  // rayon de C1, C2 et C3 : ATTENTION, la fonction circle(x, y, R) utilise R * 2!

class Point {
  float xp, yp; // x, y dans l'espace Processing (coin sup gauche fenêtre)
  float xo, yo; // x, y dans l'espace cartésien centré sur O (pour la géométrie)
  float xt, yt; // x, y dans l'espace cartésien centré sur T (pour la géométrie)

  // le constructeur ne fait rien
  Point () {}

  // initialisation d'un point dans l'espace O
  // et transformations vers P et T
  void seto(float x_o, float y_o) {
    xo = x_o;
    yo = y_o;
    xp = x_o + Ox;
    yp = Oy - y_o;
    xt = x_o - (d/2);
    yt = y_o + ((d/2) * tan(radians(30)));
  }

  // initialisation d'un point dans l'espace T
  // et transformations vers O et P
  void sett(float x_t, float y_t) {
    xt = x_t;
    yt = y_t;
    xo = x_t + (d/2);
    yo = y_t - ((d/2) * tan(radians(30)));
    xp = xo + Ox;
    yp = Oy - yo;
  }

}

// effectue une rotation de alpha° autour du point T
// alpha > 0 est horaire
// alpha < 0 est anti-horaire
void rotationT(Point p, float alpha) {
  x = p.xt * cos(radians(alpha)) + p.yt * sin(radians(alpha));
  y = p.yt * cos(radians(alpha)) - p.xt * sin(radians(alpha));
}

//dessiner cercle au point p de rayon r
void cercle(Point p, float r) {
 ellipseMode(CENTER);
 //stroke(1);
 //strokeWeight(0);
 //noFill();
 circle(p.xp, p.yp, r * 2); // Processing utilise le diamètre
}

void Ligne(Point p1, Point p2, int epaisseur, color c) {
  stroke(c);
  strokeWeight(epaisseur);
  line(p1.xp, p1.yp, p2.xp, p2.yp);
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

// constantes pour dessiner les intersections

byte C1C2 = 1;
byte C2C3 = 2;
byte C1C3 = 3;
float rotation = PI/3; // rotation de +ou- 120° autour 

// dessiner intersection centrale 3 cercles
float demip;
float EB;
float sinOEB;
float arcEB;
float q;
float arcOE;
void dessinerCentre(boolean on) {
  // dessiner arc EB
  //stroke(0);
  noStroke();
  strokeWeight(1);
  if (on) {
    fill((color(0, 255, 0)));
  } else {
     fill(255);
    }
  arc(O.xp, O.yp, 2*R, 2*R, abs(arcOE), abs(arcOE) + arcEB, CHORD);
  //arc(O.xp, O.yp, 2*R, 2*R, 0, abs(arcOE), CHORD);
  //println(arcOE);
  //println(arcEB);
 
  // p/r à S, tourner de -120°
  arc(S.xp, S.yp, 2*R, 2*R, PI + abs(arcOE) - rotation, PI + abs(arcOE) + arcEB - rotation, CHORD);
  // p/r à U, tourner de 120°
  arc(U.xp, U.yp, 2*R, 2*R, PI + abs(arcOE) + rotation, PI + abs(arcOE) + arcEB + rotation, CHORD);
 
  // dessiner triangle CEB
  Triangle(C, E, B);

}


// dessiner ou effacer l'intersection deux à deux
void dessinerIntersection() {
     stroke(1);
     noFill();
     cercle(O, R);
     cercle(S, R);
     cercle(U, R);

  switch(interieur) {
    case 1: // C1 seulement
     stroke(1);
     fill(192);
     cercle(O, R);
     fill(255);
     cercle(S, R);
     cercle(U, R);
    break;

    case 2: // C2 seulement
     stroke(1);
     fill(192);
     cercle(S, R);
     fill(255);
     cercle(O, R);
     cercle(U, R);
    break;
    
    case 3: // C1C2
     fill(128);
     noStroke();
     arc(O.xp, O.yp, 2*R, 2*R, -w, w, CHORD);
     arc(S.xp, S.yp, 2*R, 2*R, PI-w, PI+w, CHORD);
     stroke(1);
     fill(255);
     cercle(U, R); // pour couper
     noFill();
    break;
    
    case 4: // C3 seulement
     stroke(1);
     fill(192);
     cercle(U, R);
     fill(255);
     cercle(O, R);
     cercle(S, R);
    break;
    
    case 6: // C2C3
     fill(128);
     noStroke();
     arc(U.xp, U.yp, 2*R, 2*R, (-w - rotation), w - rotation, CHORD);
     arc(S.xp, S.yp, 2*R, 2*R, PI - w - rotation, PI + w - rotation, CHORD);
     stroke(1);
     fill(255);
     cercle(O, R); // pour couper
    break;

    case 5: // C1C3
     fill(128);
     noStroke();
     arc(O.xp, O.yp, 2*R, 2*R, -w + rotation, w + rotation, CHORD);
     arc(U.xp, U.yp, 2*R, 2*R, PI - w + rotation, PI + w + rotation, CHORD);
     fill(255);
     cercle(S, R); // pour couper
    break;
    
    case 7:
     stroke(1);
     fill(255);
     cercle(O, R);
     cercle(S, R);
     cercle(U, R);
     dessinerCentre(true);
    break;
  }
     noFill();
     stroke(1);
     //retracer les contours
     cercle(O, R);
     cercle(S, R);
     cercle(U, R);
}

// calcule la distance entre deux points dans l'espace p

float distance(Point p1, Point p2) {
  //return sqrt(sq(p2.xp - p1.xp) + sq(p2.yp - p1.yp));
  return dist(p1.xp, p1.yp, p2.xp, p2.yp);
}

// initialise interieur selon distance entre le pointeur de la souris et le
// centre de chacun des cercles

void distanceSouris() {
   if (dist(O.xp, O.yp, mouseX, mouseY) < R) { // C1
     interieur += 1;
   }

   if (dist(S.xp, S.yp, mouseX, mouseY) < R) { // C2
    interieur += 2;
   }

   if (dist(U.xp, U.yp, mouseX, mouseY) < R) { // C3
   interieur += 4; 
   }
}


//*************************************************************
//*************************************************************
//*************************************************************
//*************************************************************
// Définition de l'environnement
float centreFenetreX;
float centreFenetreY;

// Définition des espaces géométriques
float Ox, Oy; // point O, aussi origine du système pour calcul géométrique
              // voir au début de setup()
/* voir au début de programme
float d = 150.0;  // côté du triangle OSU
float R = 100.0;  // rayon de C1, C2 et C3 : ATTENTION, la fonction circle(x, y, R) utilise R * 2!
*/
Point O = new Point(); // origine, sommet O du triangle OSU et centre de C1
Point S = new Point(); // sommet S du triangle OSU et centre de C2
Point U = new Point(); // sommet U du triangle OSU et centre de C3

Point T = new Point(); // centre triangle OSU

Point A = new Point(); // 1er point corde intersection C1/C2
Point B = new Point(); // 2e point corde intersection C1/C2
Point C = new Point(); // 1er point corde intersection C2/C3
Point D = new Point(); // 2e point corde intersection C2/C3
Point E = new Point(); // 1er point corde intersection C1/C3
Point F = new Point(); // 2e point corde intersection C1/C3

//float s;               // demi circonférence du triangle OAB
//float Orad;            // angle OAB en radians
float w;               // demi arc de l'intersection C1/C2
float x, y; //pour les calculs

byte interieur; // indique l'état de la position de la souris
/*
 1 :: dans C1
 2 :: dans C2
 4 :: dans C3
 3 :: dans C1/C2
 6 :: dans C2/C3, etc
*/

void Triangle(Point a, Point b, Point c) {
  triangle(a.xp, a.yp, b.xp, b.yp, c.xp, c.yp);
}


//**************************
//**************************
void setup() {
 size(800, 480);
 centreFenetreX = width/2;
 centreFenetreY = height/2;
 // point O, origine du système
 Ox = centreFenetreX;
 Oy = centreFenetreY - 37;
 println("R= " + R + ", " + "d= " + d);
 println("Origine espace O (Ox, Oy)= (" + Ox + ", " + Oy + ")");

 // calculer les sommets du triangle équilatéral OSU
 /*
  O...S
   . .
    U
 */
 O.seto(0, 0); //sommet O
 S.seto(d, 0); //sommet S

 x = d/2;
 y = - (sqrt(0.75*sq(d)));
 U.seto(x, y); // sommet U

 x = d/2;
 y = -((d/2)*tan(radians(30)));
 T.seto(x, y); //centre de OSU
 
 //**************************************************** 
 // Montage géométrique de base
 // dessiner les points OSU et T
 // dessiner les cercles C1, C2 et C3
 // dessiner les cordes des intersections des cercles
 // des cercles deux à deux
 //****************************************************
/*
 drawCrosshair(O.xp, O.yp, 0);
 drawCrosshair(S.xp, S.yp, 0);
 drawCrosshair(U.xp, U.yp, 0);
 drawCrosshair(T.xp, T.yp, 0);
*/ 
 //dessiner cercles C1, C2 et C3 de rayon R
 cercle(O, R);
 cercle(S, R);
 cercle(U, R);

 // calculer les points A et B qui définissent la corde
 // de l'intersection C1/C2
 x = d/2;
 y = sqrt(sq(R) - sq(d/2));
 A.seto(x, y);
 color col = color(0, 255, 0); //vert
 //drawCrosshair(A.xp, A.yp, col);
 
 x = d/2;
 y = -sqrt(sq(R) - sq(d/2));
 B.seto(x, y);
 //drawCrosshair(B.xp, B.yp, col);

 // Par rotation, calculer C et D, les points qui définissent la corde
 // de l'intersection C2/C3

 // la rotation de +120° de A autour de T donne D
 rotationT(A, 120);
 D.sett(x, y);
 col = color(0 , 0, 255); // bleu
 //drawCrosshair(D.xp, D.yp, col);
 
 // la rotation de +120° de B autour de T donne C
 rotationT(B, 120);
 C.sett(x, y);
 col = color(0 , 0, 255); // bleu
 //drawCrosshair(C.xp, C.yp, col);

 // calculer E et F, les point qui définissent la corde
 // de l'intersection C1/C3
 // la rotation de -120° de A autour de T donne F

 rotationT(A, -120);
 F.sett(x, y);
 col = color(0 , 128, 255); // bleu qqc
 //drawCrosshair(F.xp, F.yp, col);
 
 // la rotation de -120° de B autour de T donne E
 rotationT(B, -120);
 E.sett(x, y);
 col = color(0 , 128, 255); // bleu qqc
 //drawCrosshair(E.xp, E.yp, col);
 
 // calcul de w, la demi longueur de l'arc de l'intersection C1/C3
 // il s'agit de l'arc A B sur le cercle C1
 // tous les autres arcs sont les mêmes
 
 w = asin(A.yo/R);
/*debug
 println("A.yo/R= " + A.yo/R);
 println("w = " + w + " radians");
 println("rotation= " + rotation + " radians");
*/
 // calcul de arcEB et q (arcEB/2), la longueur de l'arc de l'intersection C1/C2/C3
 // il s'agit de l'arc B E sur le cercle C1
 // tous les autres arcs sont les mêmes

 //println();
 EB = distance(E, B);
 //println("AB = " + EB);

 demip = 0.5 * ((2 * R) + EB); // demi périmètre triangle OAB
 //println("demip = " + demip);
 sinOEB = (2/sq(R)) * sqrt(demip * sq(demip - R) * (demip - EB));
 //println("sinOEB = " + sinOEB + " radians");

 arcEB = asin(sinOEB);
 //println("arcEB = " + arcEB + " radians");

 q = arcEB/2;
 //println("q = " + q + " radians");
 
 // calcul de l'arc arcOB de l'origine de C1 à la position de B en radians
 arcOE = asin(E.yo/R);
 
}

//****************************************
//****************************************
void draw() {
  background(255);
  interieur = 0;
 //drawCrosshair(mouseX, mouseY, 0);
/* int epaisseur = 1;
 color couleur = color(0, 120, 255);
*/
 distanceSouris(); // initialise interieur
 dessinerIntersection();
}
