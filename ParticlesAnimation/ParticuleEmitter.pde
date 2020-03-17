interface ParticleEmitter{
  public void initialize(World w);
  public Particle emit(ParticleGroup pg);
  public String getName();
}


class DefaultParticleEmitter implements ParticleEmitter{
  
  World world = null;
  
  DefaultParticleEmitter(){
    super();
  }
  
  public void initialize(World w){
    this.world = w;
  }
  
  public String getName(){
    return "default";
  }
  
  public Particle emit(ParticleGroup pg){
    float r = random(2,16);
    Particle p = new Particle(pg.pos.x, pg.pos.y, r, r);
    p.mass = pg.mass;
    p.friction = pg.friction;
    p.acc.x = random(-2, 2);
    p.acc.y = random(-2, 2);
    p.foregroundColor = pg.foregroundColor;
    p.fillColor = pg.fillColor;
    p.lifespan = (int)random(0,1000);
    p.type = ParticleType.ELLIPSE;
    return p;
  }
  
}
