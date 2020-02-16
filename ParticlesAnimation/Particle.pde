class Particle {
  PVector loc  = new PVector(0, 0);
  PVector vel  = new PVector(0, 0);
  PVector acc  = new PVector(0, 0);
  float friction = 3.91;
  float mass = 84;

  ParticleType type;

  PVector size = new PVector(0, 0);

  int lifespan = 100;

  color foregroundColor = color(255, 255, 128);
  color fillColor = color(255, 255, 128);

  public Particle() {
    loc  = new PVector(0, 0);
    vel  = new PVector(0, 0);
    acc  = new PVector(0, 0);
    friction = 3.91;
    mass = 84;
    type=ParticleType.ELLIPSE;
  }

  public Particle(PVector loc, PVector size) {
    this();
    this.loc = loc;
    this.size = size;
  }

  public Particle(float x, float y, float w, float h) {
    this(new PVector(x, y), new PVector(w, h));
  }

  public void display() {
    switch(type) {
    case POINT:
      stroke(foregroundColor);
      fill(fillColor);
      point(loc.x, loc.y);
      break;
    case ELLIPSE:
      stroke(foregroundColor);
      fill(fillColor);
      ellipse(loc.x, loc.y, size.x, size.y);
      break;
    case RECT:
      stroke(foregroundColor);
      fill(fillColor);
      rect(loc.x, loc.y, size.x, size.y);
      break;
    case IMAGE:
      break;
    }
  }

  public void update(World world) {
    acc.add(world.gravity.mult(mass).mult(friction));
    vel.add(acc).mult(0.2);
    loc.add(vel);
    lifespan--;
    if (lifespan<0) {
      lifespan=0;
    }
    fillColor -= 5*lifespan;
    foregroundColor -= 10*lifespan;
  }

  public boolean isDead() {
    return lifespan==0;
  }
}
