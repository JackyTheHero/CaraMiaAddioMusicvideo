//BeatDeltaDetection (aussortiert)

//Animationen
ArrayList<MultiAnimations> multiAnimList;
ArrayList<Timer> timerList;
ArrayList<IDAnimation> idAnimList;
ArrayList<Animation> animList;

//Explosion (aussortiert)

//Sammelanimationen/Multianimationen (unbenutzt)
FullscreenRechteckHinHer fRHH;
PulsatingCircles pulsCs;

//Hintergrundfarbe
color bgClr;
float timeToLerp;
int starCountHelper;

//Menü
boolean start, home, middle;
Button startButton, homeButton, middleButton;
PImage screenshot; //Zur Anzeige des Bildes, wenn Pause gedrückt wird

//Musik-Player
//http://code.compartmental.net/minim/javadoc/ddf/minim/AudioPlayer.html
import ddf.minim.*;
import ddf.minim.effects.*;
Minim minim;
AudioPlayer groove, groove1;
boolean hasStarted;

//Video-Player (unbenutzt)
//https://processing.org/reference/libraries/video/Movie.html
import processing.video.*;
Movie myMovie;

//Anzeige Fehlermeldungen
String message;
int msgTimeStart;

//Hintergrundbild (aussortiert durch Laufzeit-Probleme
PImage img;
PShader blur;
float blurIntens;

//Space Core Follower (folgt Maus)
PImage spaceCoreSheet;
int frameXnum;
int frameYnum;
float startSpriteAnim;
float endSpriteAnim;
float spriteTimer;
PImage spaceCore;

//ASCII art
PImage chell;
PImage turrets;
String ascii;
String ascii2;
float bright;
float bright2;
int asciiFade;

void setup() {
  frameRate(60);
  size(1280, 720);
  message = "";
  msgTimeStart = 0;
  
  //Selektion Hintergrundbild (aussortiert)
  //selectInput("Select an input:", "fileSelected", dataFile("n"));


  //Menü-Buttons
  startButton = new Button("start", width/10, height/10, height/10, height/10);
  homeButton = new Button("home", width-width/10, height/10, height/10, height/10);
  middleButton = new Button("middle", width/2, height/10, height/10, height/10); //momentan für Sprachauswahl zuständig (weitere Funktionen geplant)


  //Animationslisten (multiAnimList unbenutzt)
  multiAnimList = new ArrayList<MultiAnimations>();
  timerList = new ArrayList<Timer>();
  idAnimList = new ArrayList<IDAnimation>();
  animList = new ArrayList<Animation>();
  
  //Sammelanimationen (unbenutzt)
  fRHH = new FullscreenRechteckHinHer(2460, width, height);
  pulsCs = new PulsatingCircles(1230, width, height, 4);
  
  //Füllen der idAnimList (turrets)
  // 0 (eye)
  idAnimList.add(new TurretEye(width, height, "turretEye1"));
  timerList.add(new Timer(20000, idAnimList.get(0), -1, -1));

  //1 (bass)
  idAnimList.add(new TurretBody(width, height, "turretBass1"));
  timerList.add(new Timer(36000, idAnimList.get(1), -1, -1));

  //2 (piano)
  idAnimList.add(new TurretBody(width, height, "turretPiano1"));
  timerList.add(new Timer(39500, idAnimList.get(2), -1, -1));

  //3 (singer)
  idAnimList.add(new TurretSinger(width, height, "turretSinger1", "it"));
  timerList.add(new Timer(99000, idAnimList.get(3), -1, -1));

  //Füllen der animList (stars)
  //3-mal slow stars
  for (int i = 0; i < 3; i++) {
    animList.add(new Stardance(width, height));
    timerList.add(new Timer(3400, animList.get(i), -1, -1));
  }
  
  //400-mal fast stars
  for (int i = 3; i <= 403; i++) {
    animList.add(new Stardance(width, height));
    timerList.add(new Timer(1200, animList.get(i), -1, -1));
  }
  
  starCountHelper = 7;
  bgClr = #111111;

  //Audio-Player
  minim = new Minim(this);
  groove = minim.loadFile("caraMiaAddio.mp3");
  hasStarted = false;


  blurIntens = 5.f; // (unbenutzt)
  
  //Space Core Follower
  spaceCoreSheet = loadImage("spaceCoreSpreadsheetTransp.png");
  frameXnum = 0;
  frameYnum = 0;
  startSpriteAnim = 0;
  endSpriteAnim = 3000;
  spriteTimer = 0;
  spaceCore = loadImage("oneSpaceCore.png");
  
  //ASCII art
  chell = loadImage("chellBlack2.png");
  turrets = loadImage("turrets.png");
  ascii = "o";
  ascii2 = "o";
  bright = 0;
  bright2 = 0;
  asciiFade = 0;
}

void draw() {
  image(spaceCoreSheet, 0, 0); // "unsichtbares" Sheet für Space Core Follower

  background(bgClr);

  //Boolean Variablen für Status der Buttons
  start = startButton.getStatus();
  home = homeButton.getStatus();
  middle = middleButton.getStatus();

  //Hintergrundbild (unbenutzt)
  if (img != null) {
    pushStyle();
    tint(255, 128);
    image(img, 0, 0, width, height);
    filter(BLUR, blurIntens);
    popStyle();
  }

  if (home) { //Home-Bildschirm
    blurIntens = 5; // (unbenutzt)

    // turrets ASCII art
    for (int x = 0; x < turrets.width; x ++) {
      for (int y = 0; y < turrets.height; y++) {
        color c2 = turrets.get(x, y);
        bright2 = brightness(c2)+asciiFade;
        if (bright2 >= 200) {
          ascii2 = ".";
        } else if (bright2 < 200 && bright2 >= 80) {
          ascii2 = "-";
        } else if (bright2 < 80 && bright2 >= 30) {
          ascii2 = "c";
        } else if (bright2 < 30 && bright2 >= 20) {
          ascii2 = "o";
        } else if (bright2 < 20 && bright2 >= 4) {
          ascii2 = "a";
        } else if (bright2 < 4) {
          ascii2 = "w";
        }
        fill(0);
        text(ascii2, x*8, y*8);
      }
    }
    
  } else if (!start && !home) { //Pause
    pushStyle();
    image(screenshot, 0, 0);
    startButton.update();
    popStyle();
    groove.pause();
  } else if (start && !home) { //Läuft

    //Audio
    groove.play();

    //Audio-Position Ausgabe
    /*
    pushStyle();
     text(groove.position(), width-50, height-20);
     popStyle();
     */

    //bg color change
    if (groove.position() >= 0 && groove.position() <= 3100) {
      bgClr = lerpColor(#111111, #373A40, timeToLerp);
      timeToLerp = map(groove.position(), 0, 3100, 0.0, 1.0);
    }
    if (groove.position() >= 76000 && groove.position() <= 102000) {
      bgClr = lerpColor(#373A40, #DBF8FF, timeToLerp);
      timeToLerp = map(groove.position(), 76000, 102000, 0.0, 1.0);
    }
    if (groove.position() >= 130000 && groove.position() <= 135000) {
      bgClr = lerpColor(#DBF8FF, #373A40, timeToLerp);
      timeToLerp = map(groove.position(), 130000, 135000, 0.0, 1.0);
    }

    // soundlines
    /*
    pushStyle();
     stroke(255);
     for (int i = 0; i < groove.bufferSize() - 1; i++)
     {
     line(i, 50  + groove.left.get(i)*50, i+1, 50  + groove.left.get(i+1)*50);
     line(i, 150 + groove.right.get(i)*50, i+1, 150 + groove.right.get(i+1)*50);
     }
     popStyle();
     */

    //Animations Methoden
    animStart();
    animTick(); 
    animDraw();
    debugTimer(); //falls ein Start nicht registriert wurde

    // chell ASCII-art
    if (groove.position() >= 102100 && groove.position() <= 135000) {
      if (groove.position() <= 112100) {
        asciiFade = (int) map(groove.position(), 102100, 112100, 200, 0);
      }
      if (groove.position() >= 125000 && groove.position() <= 135000) {
        asciiFade = (int) map(groove.position(), 125000, 135000, 0, -200);
      }
      for (int x = 0; x < chell.width; x ++) {
        for (int y = 0; y < chell.height; y++) {
          color c1 = chell.get(x, y);
          bright = brightness(c1)+asciiFade;
          // l statt . || c statt - || e statt c und o || h statt a und w
          if (bright >= 200) {
            ascii = "l";
          } else if (bright < 200 && bright >= 150) {
            ascii = "c";
          } else if (bright < 150 && bright >= 110) {
            ascii = "e";
          } else if (bright < 110 && bright >= 50) {
            ascii = "e";
          } else if (bright < 50 && bright >= 30) {
            ascii = "h";
          } else if (bright < 30) {
            ascii = "h";
          }
          fill(0);
          text(ascii, x*8, y*8);
        }
      }
    }
  }
  
  //ab hier dauerhafte Grafiken
  
  //Buttons tauchen nur bei bestimmter Distanz auf
  if (mouseY < height/5) {
    pushStyle();
    startButton.update();
    homeButton.update();
    middleButton.update();
    popStyle();
  }


  //Fehlermeldungen, nach 5 Sekunden verschwunden
  if (message.equals("") == false && msgTimeStart == 0) {
    msgTimeStart = millis();
  }
  if (message.equals("") == false && (millis() - msgTimeStart) >= 5000) {
    message = "";
    msgTimeStart = 0;
  }
  pushStyle();
  fill(#F79B9B);
  //textAlign(LEFT);
  textAlign(CENTER);
  text(message, width/2, 200);
  popStyle();

  //Space Core Follower
  spriteTimer += 1;
  if (spriteTimer == 3000) { // Sprite Animation in 3000 millis
    spriteTimer = 0;
  }
  if (spriteTimer % 15 == 0) { // jede 15 millis ein Frame
    if (frameXnum == 5) {
      frameXnum = 0;
      frameYnum++;
    } else {
      frameXnum++;
    }
    if (frameYnum == 3) {
      frameYnum = 0;
    }
  }
  spaceCore.copy(spaceCoreSheet, 25*frameXnum, 25*frameYnum, 25, 25, 0, 0, 25, 25);
  
  pushMatrix(); // Rotation um eigene Achse
  translate(mouseX+30, mouseY+30);
  rotate(radians(map(spriteTimer, 0, 500, 0, 360)));
  translate(-12.5f, -12.5f);
  if (mouseX < width && mouseX > -30 && mouseY < height && mouseY > -30) { 
    image(spaceCore, 0, 0);
  } else {  //Core verschwindet, wenn Maus aus Bild (geht noch nicht)
    System.out.println("mouse out of reach");
  }
  popMatrix();
}



// Animationstimer werden zu bestimmten Zeiten des Songs aktiviert
void animStart() {
  if (groove.position() >= 0 && groove.position() <= 17) {
    timerList.get(0).start();
  }
  if (groove.position() >= 10500 && groove.position() <= 10517) {
    timerList.get(1).start();
    timerList.get(2).start();
  }
  if (groove.position() >= 50100 && groove.position() <= 51017) {
    timerList.get(3).start();
  }
  if (groove.position() >= 76000 && groove.position() <= 76017) {
    timerList.get(4).start();
  }
  if (groove.position() >= 77200 && groove.position() <= 77217) {
    timerList.get(5).start();
  }
  if (groove.position() >= 78400 && groove.position() <= 78417) {
    timerList.get(6).start();
  }
  //7-47
  if (groove.position() >= 78600 && groove.position() % 1200 < 20 && starCountHelper <= 403) {
    timerList.get(starCountHelper).start();
    starCountHelper++;
  }
}

//Animationstimer "ticken", wenn der Song läuft
void animTick() {
  if (groove.isPlaying()) {
    /*
    if(groove.position() >= 1000 && groove.position() <= 3000){
     blurIntens = map(groove.position(), 0, 2000, 5, 0);
     }
     */

    for (int i = 0; i < multiAnimList.size(); i++) {
      multiAnimList.get(i).tick();
    }
    for (int i = 0; i < timerList.size(); i++) {
      timerList.get(i).tick();
    }
  }
}

//Animationen werden gemalt, wenn Timer schon läuft
void animDraw() {
  for (int i = 0; i < multiAnimList.size(); i++) {
    if (multiAnimList.get(i).isRunning()) {
      multiAnimList.get(i).drawAll();
    }
  }
  for (int i = 0; i < idAnimList.size(); i++) {
    if (timerList.get(i).isRunning()) {
      idAnimList.get(i).draw();
    }
  }
  for (int i = 0; i < animList.size(); i++) {
    if (timerList.get(i+4).isRunning()) {
      animList.get(i).draw();
    }
  }
}

//Animationstimer werden pausiert
void animPause() {
  for (int i = 0; i < multiAnimList.size(); i++) {
    multiAnimList.get(i).pause();
  }
  for (int i = 0; i < timerList.size(); i++) {
    timerList.get(i).pause();
  }
}

//Animationstimer laufen nach animPause() weiter
void animContinue() {
  for (int i = 0; i < multiAnimList.size(); i++) {
    if (multiAnimList.get(i).hasStarted()) {
      multiAnimList.get(i).start();
    }
  }
  for (int i = 0; i < timerList.size(); i++) {
    if (timerList.get(i).hasStarted()) {
      timerList.get(i).start();
    }
  }
}

//Animationstimer werden resettet
void animReset() {
  for (int i = 0; i < multiAnimList.size(); i++) {
    multiAnimList.get(i).reset();
  }
  for (int i = 0; i < timerList.size(); i++) {
    timerList.get(i).reset();
  }
}

//unbenutzte Methode
void movieEvent(Movie m) {
  m.read();
}

//Animationstimer werden kurz nach offiziellem Start noch einmal kontrolliert 
void debugTimer() {
  if (!timerList.get(0).isRunning() && groove.position() > 30 && groove.position() < 200) {
    timerList.get(0).reset();
    timerList.get(0).start();
  }
  if (!timerList.get(1).isRunning() && groove.position() > 10520 && groove.position() < 10700) {
    timerList.get(1).reset();
    timerList.get(1).start();
  }
  if (!timerList.get(2).isRunning() && groove.position() > 10520 && groove.position() < 10700) {
    timerList.get(2).reset();
    timerList.get(2).start();
  }
  if (!timerList.get(3).isRunning() && groove.position() > 50020 && groove.position() < 50200) {
    timerList.get(3).reset();
    timerList.get(3).start();
  }
  if (!timerList.get(4).isRunning() && groove.position() > 76020 && groove.position() < 76200) {
    timerList.get(4).reset();
    timerList.get(4).start();
  }
  if (!timerList.get(5).isRunning() && groove.position() > 77220 && groove.position() < 77400) {
    timerList.get(5).reset();
    timerList.get(5).start();
  }
  if (!timerList.get(6).isRunning() && groove.position() > 78420 && groove.position() < 78600) {
    timerList.get(6).reset();
    timerList.get(6).start();
  }

  if (starCountHelper <= 403) {
    if (!timerList.get(starCountHelper).isRunning() && groove.position() >= 78620 && groove.position() % 1200 < 20) {
      timerList.get(starCountHelper).start();
      starCountHelper++;
    }
  }
}

//aktiviert Funktionen der Buttons
void mousePressed() {
  System.out.println(groove.position());
  if (startButton.checkCollision()) {
    if (!start && home) { //Starten
      homeButton.setStatus(false);
      groove.play();
      //myMovie.play();
    } else if (start) { //Pausieren
      animPause();
      screenshot = copy();
      groove.pause();
    } else if (!start && !home) { //Fortsetzen
      groove.play();
      //myMovie.play();
      animContinue();
    }
  }

  if (homeButton.checkCollision()) {
    if (!home) { //Home aufrufen
      startButton.setStatus(false);
      groove.rewind();
      groove.pause();
      animPause();
    } else if (!start && home) { //sind schon im Home-Menü, keine Aktion
      homeButton.setStatus(true);
      message = "You are already in the home-menu";
      System.out.println("Home-Button in Home gedrückt");
    }
  }

  if (middleButton.checkCollision()) {
    if (home) {
      //selectInput("Select an image:", "fileSelected");
    }
    
    //Sprachauswahl des Singers
    if (!timerList.get(3).hasStarted) {
      message = "Singer has not started yet";
      System.out.println("Singer has not started yet");
    } else if (idAnimList.get(3).getLanguage() == "it") {
      System.out.println("English is now selected");
      idAnimList.get(3).setLanguage("eng");
    } else if (idAnimList.get(3).getLanguage() == "eng") {
      System.out.println("German is now selected");
      idAnimList.get(3).setLanguage("ger");
    } else if (idAnimList.get(3).getLanguage() == "ger") {
      System.out.println("Italian is now selected");
      idAnimList.get(3).setLanguage("it");
    }
  }
}

//ASCII-art Helligkeit durch Mausziehen veränderbar 
void mouseDragged() {
  if (mouseX < width/2) {
    asciiFade += 5;
  } else {
    asciiFade -= 5;
  }
}

//momentan unbenutzt
void fileSelected(File selection) {
  /*
  if(selection == null){
   message = "Window was closed or the user hit cancel.";
   System.out.println("Window was closed or the user hit cancel.");
   } else {
   message = "User selected " + selection.getAbsolutePath();
   System.out.println("User selected " + selection.getAbsolutePath());
   }
   */
  if (selection.exists()) {
    img = loadImage(selection.getAbsolutePath());
  }
}

//momentan unbenutzt
void folderSelected(File selection) {
  if (selection == null) {
    message = "Window was closed or the user hit cancel.";
    System.out.println("Window was closed or the user hit cancel.");
  } else {
    message = "User selected " + selection.getAbsolutePath();
    System.out.println("User selected " + selection.getAbsolutePath());
  }
}
