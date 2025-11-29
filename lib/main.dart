import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Register Page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 58, 127, 183)),
      ),
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Exercice 2 :
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isPasswordObscure = true;
  bool _isConfirmPasswordObscure = true;

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName est requis.';
    }
    return null;
  }

  void _handleRegistration() {
    if (_formKey.currentState!.validate()) {
      // Exercice 3.2 : 
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Inscription réussie !'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );

      print('Nom: ${_nomController.text}');
      print('Email: ${_emailController.text}');
    } else {
       // Afficher un message si la validation échoue
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veuillez corriger les erreurs dans le formulaire.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    // Exercice 4.3 :
    final double defaultPadding = 24.0;
    final double sectionSpacing = 30.0;
    final double fieldSpacing = 15.0;

    return Scaffold(
      // Exercice 1 : AppBar
      appBar: AppBar(
        // Exercice 4.2 :
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Inscription',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true, // Exercice 1 :
        iconTheme: IconThemeData(color: Colors.white), 
      ),

      // Exercice 1 : Corps avec SingleChildScrollView pour éviter le débordement
      body: SingleChildScrollView(
        // Exercice 1 : Padding autour du contenu (Exercice 4.3)
        padding: EdgeInsets.all(defaultPadding),
        
        // Bonus 1 : Form pour la validation
        child: Form(
          key: _formKey,
          
          // Exercice 1 : Column pour organiser les éléments verticalement
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              // Exercice 4.1 : Logo/Image en haut
              Padding(
                // Exercice 4.3 : Marge en haut du logo
                padding: EdgeInsets.only(top: 20.0, bottom: sectionSpacing),
                child: Icon(
                  Icons.person_add, // Exemple d'icône
                  size: 90, // Taille 80-100
                  color: Theme.of(context).primaryColor, // Exercice 4.1 : Couleur bleue
                ),
              ),

              //  Exercice 2 : Champs de formulaire (Utilisation de TextFormField pour Bonus 1) 

              // 1. Nom complet
              _buildTextFormField(
                controller: _nomController,
                icon: Icons.person,
                labelText: "Nom complet",
                hintText: "Entrez votre nom complet",
                validator: (value) => _validateRequired(value, "Le Nom complet"),
              ),
              SizedBox(height: fieldSpacing), // Exercice 2 : Espacement

              // 2. Email
              _buildTextFormField(
                controller: _emailController,
                icon: Icons.email,
                labelText: "Email",
                hintText: "exemple@email.com",
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  final requiredError = _validateRequired(value, "L'Email");
                  if (requiredError != null) return requiredError;
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
                    return 'Entrez un email valide.';
                  }
                  return null;
                },
              ),
              SizedBox(height: fieldSpacing),

              // 3. Téléphone
              _buildTextFormField(
                controller: _phoneController,
                icon: Icons.phone,
                labelText: "Téléphone",
                hintText: "+212 6XX XXX XXX",
                keyboardType: TextInputType.phone,
                validator: (value) {
                   final requiredError = _validateRequired(value, "Le Téléphone");
                   if (requiredError != null) return requiredError;
                   if (value!.length < 10) {
                     return 'Le numéro de téléphone est trop court.';
                   }
                   return null;
                },
              ),
              SizedBox(height: fieldSpacing),

              // 4. Mot de passe
              _buildPasswordFormField(
                controller: _passwordController,
                labelText: "Mot de passe",
                hintText: "Minimum 8 caractères",
                icon: Icons.lock,
                isObscure: _isPasswordObscure,
                toggleObscure: () {
                  setState(() {
                    _isPasswordObscure = !_isPasswordObscure;
                  });
                },
                validator: (value) {
                  final requiredError = _validateRequired(value, "Le Mot de passe");
                  if (requiredError != null) return requiredError;
                  if (value!.length < 8) {
                    return 'Le mot de passe doit contenir au moins 8 caractères.';
                  }
                  return null;
                },
              ),
              SizedBox(height: fieldSpacing),

              // 5. Confirmer mot de passe
              _buildPasswordFormField(
                controller: _confirmPasswordController,
                labelText: "Confirmer le mot de passe",
                hintText: "Retapez votre mot de passe",
                icon: Icons.lock_outline,
                isObscure: _isConfirmPasswordObscure,
                toggleObscure: () {
                  setState(() {
                    _isConfirmPasswordObscure = !_isConfirmPasswordObscure;
                  });
                },
                validator: (value) {
                  final requiredError = _validateRequired(value, "La Confirmation du mot de passe");
                  if (requiredError != null) return requiredError;
                  if (value != _passwordController.text) {
                    return 'Les mots de passe ne correspondent pas.';
                  }
                  return null;
                },
              ),

              SizedBox(height: sectionSpacing), // Espacement avant les boutons

              // Exercice 3 : Boutons et interactions 

              // 1. Bouton principal d’inscription
              // (Utilisé dans un SizedBox pour prendre toute la largeur et définir la hauteur)
              SizedBox(
                height: 50, // Exercice 3.1 : Hauteur
                child: ElevatedButton(
                  // Exercice 4.5 : Style personnalisé du bouton
                  style: ElevatedButton.styleFrom(
                    // Exercice 4.2 : Couleur cohérente (bleu/indigo)
                    backgroundColor: Theme.of(context).primaryColor, 
                    // Exercice 4.5 : Padding interne
                    padding: EdgeInsets.symmetric(vertical: 10), 
                    // Exercice 4.5 & 3.1 : Définir la forme (borderRadius: 10 pixels)
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5, // Bonus 3 : Ombre légère
                  ),
                  onPressed: _handleRegistration, // Exercice 3.2 : Action du bouton
                  child: const Text(
                    'S\'inscrire',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: fieldSpacing),

              // 3. Bouton secondaire
              TextButton(
                onPressed: () {
                  // Exercice 3.3 : Afficher un message dans la console
                  print("Action : Redirection vers la page de connexion...");
                },
                child: Text(
                  'Déjà inscrit ? Se connecter',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget utilitaire pour les champs de texte standard
  Widget _buildTextFormField({
    required TextEditingController controller,
    required IconData icon,
    required String labelText,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator, // Bonus 1
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(icon, color: Theme.of(context).primaryColor),
        // Exercice 4.4 : Fond léger
        filled: true,
        fillColor: Colors.grey[100], 
        // Exercice 2 & 4.4 : Border radius sur les TextField
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none, 
        ),
        // Style de bordure quand le champ est focalisé
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor, 
            width: 2.0,
          ),
        ),
      ),
    );
  }

  // Widget utilitaire pour les champs de mot de passe (avec toggle)
  Widget _buildPasswordFormField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required IconData icon,
    required bool isObscure,
    required VoidCallback toggleObscure,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure, // Exercice 2 (et Bonus 2)
      validator: validator, // Bonus 1
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(icon, color: Theme.of(context).primaryColor),
        // Exercice 4.4 : Fond léger
        filled: true,
        fillColor: Colors.grey[100], 
        // Exercice 2 & 4.4 : Border radius sur les TextField
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor, 
            width: 2.0,
          ),
        ),
        // Bonus 2 : Afficher / Cacher le mot de passe
        suffixIcon: IconButton(
          icon: Icon(
            isObscure ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: toggleObscure,
        ),
      ),
    );
  }


  @override
  void dispose() {
    // Exercice 1 : N'oubliez pas de disposer les controllers
    _nomController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}