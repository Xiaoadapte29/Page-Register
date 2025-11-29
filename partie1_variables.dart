/// Partie 1 : Variables
/// Déclaration et affichage de variables Dart

void main() {
  int age = 25;
  double prix = 19.99;
  String nom = "Khawla";
  bool estActif = true;
  var ville = "Casablanca";

  List<String> fruits = ["Pomme", "Banane", "Orange"];

  Map<String, dynamic> utilisateur = {
    "nom": "Khawla",
    "age": 25,
    "ville": "Casablanca"
  };

  // Affichage
  print("Nom : $nom, Age : $age, Ville : $ville");
  print("Fruits disponibles : $fruits");
  print("Utilisateur : $utilisateur");
}
