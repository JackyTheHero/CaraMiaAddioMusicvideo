public class TurretBody implements IDAnimation {
  float x;
  float y;
  float b;
  float h;
  color clr;
  float timeGlobal;
  float timingCounter;

  String name;
  int canvasW;
  int canvasH;
  boolean switcher;

  float timeStart;
  float timeEnd;

  public TurretBody(int w, int h, String name) {
    this.canvasW = w;
    this.canvasH = h;
    this.timingCounter = 0;
    prep(name);
    this.switcher = false;
    this.timeStart = 0;
    this.timeEnd = 0;
  }

  void prep(String name) {
    this.name = name;
    if (name.equals("turretBass1")) {
      y = canvasH-canvasH/4;
      b = 300;
      h = 70;
      clr = #F7F6F0;
    }
    if (name.equals("turretPiano1")) {
      y = canvasH;
      x = canvasW/2;
      b = 70;
      h = 300;
      clr = #F7F6F0;
      timingCounter = 10500;
    }
  }

  void draw() {
    pushStyle();
    noStroke();
    rectMode(CENTER);
    fill(clr);
    rect(x, y, b, h);
    popStyle();
  }

  String getName() {
    return this.name;
  }
  
  String getLanguage(){return "";}
  void setLanguage(String l){}

  void update(float time, float mintime, float maxtime, float min, float max) {
    if (name.equals("turretBass1")) {
      /*
      10.500 langsam rein, unten
       11.100 langsam rein, oben
       11.800 position erreicht, unten
       12.200 oben
       12.900 unten
       13.600 oben
       14.000 unten
       14.700 oben
       15.500 unten
       16.300 oben, bissl höher davor Pause
       16.700 unten, wieder zurück
       17.300 oben
       17.900 unten
       18.500 oben
       19.100 unten
       19.700 bissl tiefer als oben, beide Seiten
       20.000 unten
       20.900 bissl tiefer als oben, beide Seiten
       21.500 unten
       22.100 bissl tiefer als oben, beide Seiten
       22.700 unten
       23.200 bissl tiefer als oben, beide Seiten
       23.800 unten
       24.400 bissl tiefer als oben, beide Seiten
       immer 600 bis 43000 (oder 46.500)
       36000
       */
      timeEnd = time;
      if (time != 36000 && (time % 600 < 200)) {
        if (timeEnd - timeStart >= 400) {
          timeStart = time;
          switcher = !switcher;
          if (!switcher) {
            y = canvasH-canvasH/4;
          } else {
            y = canvasH/4;
          }
        }
      }
      if (time >= 30000 && time != 36000) {
        this.h = map(time, 30000, 36000, 70, 130);
        this.b = map(time, 30000, 36000, 300, 360);
        this.x = map(time, 30000, 36000, 0, -400);
      }
    }

    if (name.equals("turretPiano1")) {
      //Notenidee: Noten in Array speichern und jede 300 millis weiterschalten
      timeGlobal = time + 10500;
      // eine Note: 600
      // halbe Note: 300
      //Takt 1
      if (timeGlobal > 10500 && timeGlobal <= 11100) this.h = 100; // 1, n
      if (timeGlobal > 11100 && timeGlobal <= 11700) this.h = 200; // 2, n
      if (timeGlobal > 11700 && timeGlobal <= 12300) this.h = 300; // 3, n
      if (timeGlobal > 12300 && timeGlobal <= 12600) this.h = 200; // 2, k
      if (timeGlobal > 12600 && timeGlobal <= 12900) this.h = 100; // 1, k
      //Takt 2
      if (timeGlobal > 12900 && timeGlobal <= 13200) this.h = 400; // 4, k
      if (timeGlobal > 13200 && timeGlobal <= 13500) this.h = 300; // 3, k
      if (timeGlobal > 13500 && timeGlobal <= 14100) this.h = 200; // 2, n
      if (timeGlobal > 14100 && timeGlobal <= 14700) this.h = 100; // 1, n
      if (timeGlobal > 14700 && timeGlobal <= 15000) this.h = 200; // 2, k
      if (timeGlobal > 15000 && timeGlobal <= 15300) this.h = 300; // 3, k
      //Takt 3
      if (timeGlobal > 15300 && timeGlobal <= 15600) this.h = 300; // 3, k (n im sheet)
      if (timeGlobal > 15600 && timeGlobal <= 16200) this.h = 400; // 4, n
      if (timeGlobal > 16200 && timeGlobal <= 17100) this.h = 300; // 3, kn (l im sheet)
      if (timeGlobal > 17100 && timeGlobal <= 17700) this.h = 200; // 2, n
      //Takt 4
      if (timeGlobal > 17700 && timeGlobal <= 18900) this.h = 300; // 3, l
      if (timeGlobal > 18900 && timeGlobal <= 19200) this.h = 200; // 2, k
      if (timeGlobal > 19200 && timeGlobal <= 19500) this.h = 300; // 3, k
      if (timeGlobal > 19500 && timeGlobal <= 20100) this.h = 400; // 4, n
      //Takt 5
      if (timeGlobal > 20300 && timeGlobal <= 20600) this.h = 300; // 3, k
      if (timeGlobal > 20600 && timeGlobal <= 20800) this.h = 200; // 2, k
      if (timeGlobal > 20800 && timeGlobal <= 20900) this.h = 0; // gleiche Note, 100
      if (timeGlobal > 20900 && timeGlobal <= 21400) this.h = 200; // 2, n - 100
      if (timeGlobal > 21400 && timeGlobal <= 20500) this.h = 0; // gleiche Note, 100
      if (timeGlobal > 21500 && timeGlobal <= 22000) this.h = 200; // 2, n - 100
      if (timeGlobal > 22000 && timeGlobal <= 22300) this.h = 300; // 3, k
      if (timeGlobal > 22300 && timeGlobal <= 22600) this.h = 200; // 2, k
      //Takt 6
      if (timeGlobal > 22600 && timeGlobal <= 22900) this.h = 100; // 1, k
      if (timeGlobal > 22900 && timeGlobal <= 23200) this.h = 200; // 2, k
      if (timeGlobal > 23200 && timeGlobal <= 23800) this.h = 300; // 3, n
      if (timeGlobal > 23800 && timeGlobal <= 24400) this.h = 500; // 5, n
      if (timeGlobal > 24400 && timeGlobal <= 24700) this.h = 400; // 4, k
      if (timeGlobal > 24700 && timeGlobal <= 25000) this.h = 300; // 3, k
      //Takt 7
      if (timeGlobal > 25000 && timeGlobal <= 25600) this.h = 400; // 4, n
      if (timeGlobal > 25600 && timeGlobal <= 26200) this.h = 300; // 3, n
      if (timeGlobal > 26200 && timeGlobal <= 26800) this.h = 200; // 2, n
      if (timeGlobal > 26800 && timeGlobal <= 27400) this.h = 300; // 3, n
      //Takt 8
      if (timeGlobal > 27400 && timeGlobal <= 28600) this.h = 300; // 3, l
      if (timeGlobal > 28600 && timeGlobal <= 28900) this.h = 400; // 4, k
      if (timeGlobal > 28900 && timeGlobal <= 29200) this.h = 300; // 3, k
      if (timeGlobal > 29200 && timeGlobal <= 29500) this.h = 200; // 2, k
      if (timeGlobal > 29500 && timeGlobal <= 29800) this.h = 300; // 3, k
      //Takt 9
      if (timeGlobal > 29800 && timeGlobal <= 30400) this.h = 300; // 3, n
      if (timeGlobal > 30400 && timeGlobal <= 31000) this.h = 200; // 2, n
      if (timeGlobal > 31000 && timeGlobal <= 31600) this.h = 100; // 1, n
      if (timeGlobal > 31600 && timeGlobal <= 32200) this.h = 200; // 2, n
      //Takt 10
      if (timeGlobal > 32200 && timeGlobal <= 32800) this.h = 600; // 6, n
      if (timeGlobal > 32800 && timeGlobal <= 33100) this.h = 500; // 5, k
      if (timeGlobal > 33100 && timeGlobal <= 33400) this.h = 400; // 4, k
      if (timeGlobal > 33400 && timeGlobal <= 33700) this.h = 300; // 3, k
      if (timeGlobal > 33700 && timeGlobal <= 34000) this.h = 200; // 2, k
      if (timeGlobal > 34000 && timeGlobal <= 34300) this.h = 300; // 3, k
      if (timeGlobal > 34300 && timeGlobal <= 34600) this.h = 400; // 4, k
      //Takt 11
      if (timeGlobal > 34300 && timeGlobal <= 34900) this.h = 400; // 4, n
      if (timeGlobal > 34900 && timeGlobal <= 35800) this.h = 300; // 3, kn
      if (timeGlobal > 35800 && timeGlobal <= 36100) this.h = 500; // 5, k
      if (timeGlobal > 36100 && timeGlobal <= 36400) this.h = 500; // 5, k
      //Takt 12
      if (timeGlobal > 36400 && timeGlobal <= 37000) this.h = 500; // 5, n
      if (timeGlobal > 37000 && timeGlobal <= 37600) this.h = 400; // 4, n
      if (timeGlobal > 38200 && timeGlobal <= 38800) this.h = 300; // 3, n
      if (timeGlobal > 38800 && timeGlobal <= 39400) this.h = 400; // 4, n
      //Takt 13
      if (timeGlobal > 39400 && timeGlobal <= 40000) this.h = 300; // 3, n
      if (timeGlobal > 40000 && timeGlobal <= 41200) this.h = 200; // 2, l
      if (timeGlobal > 41200 && timeGlobal <= 41800) this.h = 300; // 3, n
      
      //Takt 14
      if (timeGlobal > 41200 && timeGlobal <= 41800) this.h = 400; // 4, n
      if (timeGlobal > 41800 && timeGlobal <= 42100) this.h = 300; // 3, k
      if (timeGlobal > 42100 && timeGlobal <= 42400) this.h = 200; // 2, k
      if (timeGlobal > 42400 && timeGlobal <= 42850) this.h = 300; // 3, k gk
      if (timeGlobal > 42850 && timeGlobal <= 43300) this.h = 400; // 4, k gk
      if (timeGlobal > 43300 && timeGlobal <= 43600) this.h = 500; // 5, k
      //Takt 15
      if (timeGlobal > 43600 && timeGlobal <= 44200) this.h = 500; // 5, n
      if (timeGlobal > 44200 && timeGlobal <= 44800) this.h = 400; // 4, n
      if (timeGlobal > 44800 && timeGlobal <= 45400) this.h = 300; // 3, n
      if (timeGlobal > 45400 && timeGlobal <= 45700) this.h = 200; // 2, k
      if (timeGlobal > 45700 && timeGlobal <= 46000) this.h = 300; // 3, k
      //Takt 16
      if (timeGlobal > 46000 && timeGlobal <= 47200) this.h = 300; // 3, l
      if (timeGlobal > 47200 && timeGlobal <= 47800) this.h = 200; // 2, n
      if (timeGlobal > 47800 && timeGlobal <= 48400) this.h = 100; // 1, n
      
      if(timeGlobal > 48400 && timeGlobal <= 50000) this.h = map(time, 48400-10500, 50000-10500,100,0);
      if (time >= 30000 && time <= 36000) {
        this.y = map(time, 30000, 36000, canvasH, canvasH/2);
      }
    }
  }
}
