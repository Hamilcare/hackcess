// TYPOGRAPHIES
PFont mixMonoReg;
PFont mixMonoXBold;

// VARIABLES FLUX DE TEXTE
int x = 10;
int y = 830;
int e = 5;

// VARIABLES POUR LE CERCLE
float angle = 0.00;
float speed = 0.04;

//VARIABLES COULEURS
color c1 = color (70, 100, 217); // couleur background
color c2 = color(231, 205, 112); // couleur flux de texte
color c3 = color(255); // couleur [HACK/CESS] + cercle

ArrayList<String> messagesPart1 = new ArrayList(); // correspond aux prénoms
ArrayList<String> messagesPart2 = new ArrayList(); // correspond aux phrases écrites


void setup() {
  size(500, 900); // taille fenêtre
  background(c1); //car sinon chargement d'un fond gris pas beau

  mixMonoReg = createFont("TheMixMono-Bold.otf", 20); //on vient charger la typo en corps 20
  mixMonoXBold = createFont("TheMixMono-XBold.otf", 23);  // idem corps 23

  noCursor(); // pas de curseur apparant dans la fenêtre

  loadMessage(); //on appelle la fonction message()
  refreshScreen(); // on appelle la fonction refreshScreen()
}

void scanIP(){
 //println("coucou"); // ce que m'aura filé Quentin 
}

void draw() {
  thread("scanIP"); // mettre nom de la fonction pour avoir un thread

  //barre du haut
  noStroke();
  fill(c1);
  rect(0, 0, width, 30);

  textFont(mixMonoReg); //on attribue cette typo au texte
  fill(c3);
  textSize(15);
  textAlign(CENTER);
  text("[HACK/CESS]", width/2, 22);


  // CERCLE QUI SIMULE CHARGEMENT
  stroke(190, 20); // ! ne marche pas si pas de contour -> pourquoi ? Je ne sais pas
  //noStroke();
  fill(c3, 20); // blanc + opacité de 100 
  float d1 = 65 + (sin(angle) * 45);
  ellipse(width/2, 42, d1/5, d1/5);
  float d2 = 65 + (sin(angle + QUARTER_PI) * 45);
  ellipse(width/2, 42, d2/5, d2/5);
  float d3 = 65 + (sin(angle + HALF_PI) * 45);
  ellipse(width/2, 42, d3/5, d3/5);
  angle += speed;
}


void loadMessage() { //fonction message()
  String[] Subjects={
    "Marie", "Lou", "Nina", "Marion", "Lisa", 
    "Anna", "Flo", "Alice", "Emma", "Louise", 
    "Lola", "Lucie", "Eva", "Rose", "Elsa", 
    "Sarah", "Alicia", "Lily", "Luna", "Alix", 
    "Lucas", "Hugo", "Tom", "Sacha", "Eliot", 
    "Jules", "Paul", "Alex", "Axel", "Ezra", 
    "Dorian", "Diego", "Charles", "Max", "Marc", 
    "Will", "Isaac", "Victor", "Sam", "Mathis"

  }; // on crée un tableau de String qui regroupe tous les prénoms

  String[] Salutations={
    "Hello world", "Hello", "Coucou", "Salut", "Hi", 
    "Salut, ça va ?", "Bonjour", "Eh oh, je suis là !"
  }; //on crée un tableau de String qui regroupe toutes les phrases pour la 1re connexion

  String[] Twitter={
    "#BackOnTwitter", "Bien le bonjour chers twittos", "@Twitter, c'est mieux qu'avant", 
    "#TeamTwitter", "#FollowBack ?", "Quels sont les derniers #TT ?", "Salut Twitter !", 
    "Mon avis tient en 140 signes.", "Quoi de neuf dans ma #TL ?", "Going on @Twitter via @hackcess", 
    "On peut se parler par #DM", "Oh, un nouveau #RT", "#FF @project_hackcess", "J'actualise en ce moment ma #TL"
  }; //on crée un tableau de String qui regroupe toutes les phrases pour la 1re connexion

  int subject = int(random(Subjects.length)); // on crée un int appelé subject qui a une valeur comprise entre 0 et la longueur du tableau
  int salutation = int(random(Salutations.length)); //idem mais avec les bonjour/hello  
  int twitter = int(random(Twitter.length));

  String messageSubject = Subjects[subject]; // on crée un messageSubject avec subject
  println(subject+ " " +messageSubject); //on imprime le message dans la console de debug au cas-où
  String messageSentence = "« "+Twitter[twitter]+" »"; // on crée un messageSentence avec twitter
  println(messageSentence);

  messagesPart1.add(messageSubject); //on divise le message en 2. Part1=le prénom
  if (messagesPart1.size()>15) { //si le nombre total d'éléments dans l'ArrayList est > à 20 éléments
    messagesPart1.remove(messagesPart1.get(0)); // on ne peut pas lui dire d'enlever le dernier, mais seulement un élement. donc on "contourne" le problème en mettant 0 car 0=1er élément du tableau en partant du haut
  }

  messagesPart2.add(messageSentence); //Part2=la phrase prononcée
  if (messagesPart2.size()>15) { //si le nombre total d'éléments dans l'ArrayList est > à 20 éléments
    messagesPart2.remove(messagesPart2.get(0)); // on ne peut pas lui dire d'enlever le dernier, mais seulement un élement. donc on "contourne" le problème en mettant 0 car 0=1er élément du tableau en partant du haut
  }
}

void refreshScreen() { // fonction refreshScreen()
  fill(c1);
  noStroke();
  rect(0, 30, width, height-30);

  int a = x; // on définit la position du message à la base en x
  int b = y; // on définit la position du message à la base en y
  int c = x+10;
  int d = b+26;

  for (int i = messagesPart1.size()-1; i >= 0; i--) { //largeur de l'ArrayList messagesPart1 correspond à (messagesPart1.size()). (taille-1) pour qu'on commence par la fin et on décrémente (i--) pour afficher le dernier message entré dans l'ArrayList 
    textAlign(LEFT);
    textFont(mixMonoXBold);
    fill(c2); // on met la couleur du texte car sinon, même couleur que le cercle (conflit)
    text(messagesPart1.get(i), a, b); //text a la valeur "messages.get(i)" et donc s'adapte au niveau du message à afficher en x et en y
    b -=70; //on change la position en b à chaque fois pour éviter que les messages s'affichent les uns sur les autres
  }
  for (int i = messagesPart2.size()-1; i >= 0; i--) { //largeur de l'ArrayList messagesPart2 correspond à (messagesPart2.size()). (taille-1) pour qu'on commence par la fin et on décrémente (i--) pour afficher le dernier message entré dans l'ArrayList 
    String currentMessage = messagesPart2.get(i);

    textAlign(LEFT);
    textSize(15);
    textFont(mixMonoReg);
    fill(c2); // on met la couleur du texte car sinon, même couleur que le cercle (conflit)
    //text(messagesPart2.get(i), c, d); //text a la valeur "messages.get(i)" et donc s'adapte au niveau du message à afficher en x et en y

    for (int j = 0; j < currentMessage.length(); j++) {
      textSize(random(15, 22));
      text(currentMessage.charAt(j), c, d); // text("Ceci est mon texte", x, y);
      // textWidth() spaces the characters out properly.
      c += textWidth(currentMessage.charAt(j));
    }
    c=x+10;
    d -=70; //on change la position en b à chaque fois pour éviter que les messages s'affichent les uns sur les autres
  }


  //barre du bas
  noStroke();
  fill(c2);
  rect(0, height-20, width, 20);
}

void mousePressed() {
  loadMessage(); // on relance la fonction à chaque fois qu'on appuie sur la souris
  refreshScreen(); // on relance la fonction à chaque fois qu'on appuie sur la souris
}