int nbpg = 40;

ParticleSystem ps;

public void setup () {
  size(800, 560);
  ps = new ParticleSystem(1000);
  ps.addEmitter(new DefaultParticleEmitter());
  ps.initialize(new World(),"default",50);
}

public void draw() {
  background(0);
  ps.draw();
}
