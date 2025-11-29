/// Partie 2 : Fonctions

void main() {
  direBonjour("Khawla");

  int somme = addition(5, 7);
  print("Addition : $somme");

  double aire = calculerAireCercle(3);
  print("Aire du cercle : $aire");
}

// Fonction pour dire bonjour
void direBonjour(String nom) {
  print("Bonjour $nom !");
}

// Fonction d'addition
int addition(int a, int b) {
  return a + b;
}

// Fonction pour calculer l'aire d'un cercle
double calculerAireCercle(double rayon) {
  const double pi = 3.14;
  return pi * rayon * rayon;
}
