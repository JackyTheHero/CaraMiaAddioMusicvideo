interface Animation {
  //time: abgelaufene Zeit
  //mintime: Startzeit
  //maxtime: Endzeit
  //min: Startwert von Animation
  //max: Endwert von Animation
  void draw();
  void update(float time, float mintime, float maxtime, float min, float max);
}
