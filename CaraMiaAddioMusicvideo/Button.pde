public class Button {
  //verschiedene Zustände mit einem int, falls mehr als 2
  private boolean aktiviert;
  private color clr;
  private int xPos;
  private int yPos;
  private int myWidth;
  private int myHeight;
  private String buttonType;

  public Button(String bT, int x, int y, int w, int h) {
    this.xPos = x;
    this.yPos = y;
    this.myWidth = w;
    this.myHeight = h;
    this.buttonType = bT;
    if (bT == "home") {
      this.aktiviert = true;
    } else {
      this.aktiviert = false;
    }
    this.clr = 0;
  }

  private void refreshColour() {
    if (aktiviert) {
      this.clr = #2DB24A; //grün
    } else {
      this.clr = #B22D2D; //rot
    }
  }

  public void update() {
    refreshColour();
    if (buttonType == "start") {
      startUpdate();
    }
    if (buttonType == "home") {
      homeUpdate();
    }
    if (buttonType == "middle") {
      middleUpdate();
    }
  }

  private void startUpdate() { //oder stattdessen Bild bei Konstruktor übergeben --> vielleicht besser, wegen dem data-Ordner
    pushStyle();
    fill(clr);
    rectMode(CENTER);
    rect(xPos, yPos, myWidth, myHeight);
    popStyle();
  }

  private void homeUpdate() {
    pushStyle();
    fill(clr);
    ellipse(xPos, yPos, myWidth, myHeight);
    popStyle();
  }

  private void middleUpdate() {
    pushStyle();
    fill(clr);
    rectMode(CENTER);
    rect(xPos, yPos, myWidth, myHeight);
    popStyle();
  }

  public boolean getStatus() {
    return aktiviert;
  }
  
  public void setStatus(boolean newStatus){
    aktiviert = newStatus;
  }

  public boolean checkCollision() {
    //Quadrant 1
    if (mouseX >= this.xPos && mouseX < (this.xPos+this.myWidth) && mouseY <= this.yPos && mouseY > (this.yPos-this.myWidth)) {
      aktiviert = !aktiviert;
      return true;
    }
    //Quadrant 2
    if (mouseX >= this.xPos && mouseX < (this.xPos+this.myWidth) && mouseY >= this.yPos && mouseY < (this.yPos+this.myWidth)) {
      aktiviert = !aktiviert;
      return true;
    }
    //Quadrant 3
    if (mouseX <= this.xPos && mouseX > (this.xPos-this.myWidth) && mouseY >= this.yPos && mouseY < (this.yPos+this.myWidth)) {
      aktiviert = !aktiviert;
      return true;
    }
    //Quadrant 4
    if (mouseX <= this.xPos && mouseX > (this.xPos-this.myWidth) && mouseY <= this.yPos && mouseY > (this.yPos-this.myWidth)) {
      aktiviert = !aktiviert;
      return true;
    }
    return false;
  }
}
