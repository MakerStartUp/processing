class ParticleGroup {
  ArrayList<Particle> particles = new ArrayList<Particle>();
  PVector pos = new PVector(0.0, 0.0);
  PVector vel = new PVector(0.0, 0.0);
  int maxNbParticles;
  float mass;
  float friction;
  int lifespan = 1000;
  World world;
  color foregroundColor = color(random(0, 255), random(0, 255), random(0, 255));
  color fillColor = color(random(0, 255), random(0, 255), random(0, 255));

  public ParticleGroup(ParticleSystem ps,World w, int nbParticles, float x, float y, float mass, float friction) {
    world = w;
    maxNbParticles = nbParticles;
    pos.x = x;
    pos.y = y;
    int plifespan = (int)random(5, 20);
    for (int i=0; i<nbParticles; i++) {
      Particle p = createParticle(mass, friction);
      p.lifespan = plifespan;
      particles.add(p);
    }
  }

  public Particle createParticle(float mass, float friction) {
    Particle p = new Particle(pos.x, pos.y, 16, 16);
    p.mass = mass;
    p.friction=friction;
    p.acc.x=random(-2, 2);
    p.acc.y=random(-2, 2);
    p.foregroundColor = foregroundColor;
    p.fillColor = fillColor;
    return p;
  }

  public void update() {
    if (lifespan>0) {
      Particle pn = createParticle(mass, friction);
      particles.add(pn);
    }

    pos.add(vel);


    for (int i=0; i<particles.size(); i++) {
      Particle p = particles.get(i);
      if (p!=null) {
        p.update(world);
        if (particles.size()>maxNbParticles) {
          particles.remove(i);
        }
        if (p.isDead()) {
          particles.remove(i);
        }
      }
    }


    lifespan--;
    if (lifespan<=0) {
      lifespan=0;
    }
  }

  public void draw() {
    for (int i=0; i<particles.size(); i++) {
      Particle p = particles.get(i);
      if (p!=null) {
        p.display();
      }
    }
  }


  public boolean isDead() {
    return lifespan==0 && particles.size()==0;
  }
}
