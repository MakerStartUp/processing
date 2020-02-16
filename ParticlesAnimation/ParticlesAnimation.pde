int nbpg = 40;

ParticleSystem ps;

public void setup () {
  size(720, 480);
  ps = new ParticleSystem();
}


public void draw() {
  background(0);
  ps.draw();
}
