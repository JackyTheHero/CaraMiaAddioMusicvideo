

class TurretSinger implements IDAnimation {
  float x;
  float y;
  color clr;
  String name;
  String[] text;
  String output;
  int w;
  int h;
  float scaleX;
  float scaleY;
  float globalTime;
  String language;
  
  public TurretSinger(int w, int h, String turretName, String l) {
    this.w = w;
    this.h = h;
    this.language = l;
    prep(turretName);
  }

  public void draw() {
    pushStyle();
    fill(clr);
    scale(scaleX,scaleY);
    textSize(50);
    textAlign(CENTER);
    text(output,x,y);
    popStyle();
  }

  void prep(String turretName) {
    this.name = turretName;
    if (name.equals("turretSinger1")) {
      x = w/2;
      y = h/2;
      clr = #FFEDED;
      output = "";
      scaleX = 1.0;
      scaleY = 1.0;
      setLanguage("it");
    }
  }

  String getName() {
    return this.name;
  }
  
  public void setLanguage(String lang){
    this.language = lang;
    switch(lang){
      case "it":
        text = loadStrings("caraMiaAddioLyricsIT.txt");
        break;
      case "eng":
        text = loadStrings("caraMiaAddioLyricsENG.txt");
        break;
      case "ger":
        text = loadStrings("caraMiaAddioLyricsGER.txt");
        break;
    }
  }
  
  public String getLanguage(){
    return this.language;
  }

  void update(float time, float mintime, float maxtime, float min, float max) {
    globalTime = time + 51000;
    if (name.equals("turretSinger1")) {
      if(globalTime >= 50000 && globalTime < 51100){
        output = "";
      }
      if (globalTime >= 51100 && globalTime < 53200){
         output = text[0];
      }
      if (globalTime >= 53200 && globalTime < 55400) {
         output = text[1];
      }
      if (globalTime >= 55400 && globalTime < 57800) {
         output = text[2];
      }
      if (globalTime >= 57800 && globalTime < 59600) {
         output = text[3];
      }
      if (globalTime >= 59600 && globalTime < 61900) {
         output = text[4];
      }
      if (globalTime >= 61900 && globalTime < 64300) {
         output = text[5];
      }
      if (globalTime >= 64300 && globalTime < 69100) {
         output = text[6];
      }
      if (globalTime >= 69100 && globalTime < 72600) {
         output = text[7];
      }
      if (globalTime >= 72600 && globalTime < 76600) {
         output = text[8];
      }
      if (globalTime >= 76600 && globalTime < 80700) {
         output = text[9];
      }
      if (globalTime >= 80700 && globalTime < 85400) {
         output = text[10];
      }
      if (globalTime >= 85400 && globalTime < 87900) {
         output = text[11];
      }
      if (globalTime >= 87900 && globalTime < 90100) {
         output = text[12];
      }
      if (globalTime >= 90100 && globalTime < 92500) {
         output = text[13];
      }
      if (globalTime >= 92500 && globalTime < 95600) {
         output = text[14];
      }
      if (globalTime >= 95600 && globalTime < 102100) {
         output = text[15];
      }
      if (globalTime >= 102100 && globalTime < 135000) {
        output = "";
      }
      if (globalTime >= 135000 && globalTime < 135300) {
        output = text[16];
      }
      if (globalTime >= 135000 && globalTime < 137200) {
        output = text[16];
      }
      if (globalTime >= 137200 && globalTime < 139500) {
        output = text[17];
      }
      if (globalTime >= 139500 && globalTime < 142500) {
        output = text[18];
      }
      if(globalTime >= 142500 && globalTime < 150000){
        output = text[19];
      }
      if (time == 99000){
        output = "";
      }
    }
  }

  public float getX() {
    return x;
  }

  public float getY() {
    return y;
  }

  public float getW() {
    return w;
  }

  public float getH() {
    return h;
  }
}
