class Timer {
  float startTime;
  float currentTime;
  float lastTime;
  float MAX_Time;
  boolean isRunning = false;
  boolean hasStarted = false;

  boolean isPaused = false;
  float pauseStart = 0.;
  float pauseEnd = 0.;


  Animation a;
  float minValue;
  float maxValue;

  public Timer(float max) { // in millisekunden
    MAX_Time = max;
  }

  public Timer(float max, Animation a, float minValue, float maxValue) { // in millisekunden
    MAX_Time = max; //Länge des Timers
    this.a = a; //Objekt, das animiert wird
    this.minValue = minValue; //Anfangsvariable für Objekt
    this.maxValue = maxValue; //Endvariable für Objekt
  }

  public void reset() {
    isRunning = false;
    hasStarted = false;
    startTime = millis();
    currentTime = startTime;
    lastTime = startTime;
  }

  public void start() {
    if(isPaused){
      pauseEnd = millis();
      //System.out.println("Pausenzeit: " + (pauseEnd-pauseStart));
      startTime += pauseEnd - pauseStart;
      isPaused = false;
    }else{
      reset();
      hasStarted = true;
    }
    isRunning = true;
  }
  
  public void pause() {
    pauseStart = millis();
    isRunning = false;
    isPaused = true;
  }

  public void stop() {
    isRunning = false;
  }

  public float tick() {
    if (isRunning) {
      currentTime = millis();
      isRunning = (currentTime - startTime) < MAX_Time;

      animate(currentTime - startTime);
      return (currentTime - startTime);
    } else {
      animate(MAX_Time);
      return MAX_Time;
    }
  }

  public float delta() {
    if (isRunning) {
      lastTime = currentTime;
      currentTime = millis();

      return (currentTime - lastTime);
    } else {
      return 0;
    }
  }

  public void animate(float time) {
    if (a != null) {
      a.update(time, 0, MAX_Time, minValue, maxValue);
    }
  }

  public boolean isRunning() {
    return isRunning;
  }

  public boolean hasStarted() {
    return hasStarted;
  }
}
