class ParticleGroup {
  ArrayList<Particle> particles = new ArrayList<Particle>();
  PVector pos = new PVector(0.0, 0.0);
  PVector vel = new PVector(0.0, 0.0);
  PVector acc = new PVector(0.0, 0.0);
  int maxNbParticles;
  float mass;
  float friction;
  int lifespan = 1000;
  World world;
  color foregroundColor = color(random(0, 255), random(0, 255), random(0, 255));
  color fillColor = color(random(0, 255), random(0, 255), random(0, 255));
  
  public ParticleEmitter emitter;

  public ParticleGroup(World w, int nbParticles, float x, float y, float mass, float friction) {
    this.world = w;
    this.maxNbParticles = nbParticles;
    this.pos=new PVector( x, y);
    this.mass = mass;
    this.friction = friction;
  }

  public void initialize(ParticleEmitter e){
    emitter = e;        
    for (int i=0; i<maxNbParticles; i++) {
      Particle p = emit();
      particles.add(p);
    }
  }

  public Particle emit() {
    return emitter.emit(this);
  }

  public void update() {
    if (lifespan>0) {
      Particle pn = emit();
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
