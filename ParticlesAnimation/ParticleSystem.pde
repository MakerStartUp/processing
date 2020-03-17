public class ParticleSystem{

  private ArrayList<ParticleGroup> particleGroups = new ArrayList<ParticleGroup>();
  private HashMap<String,ParticleEmitter> emitters = new HashMap();
  private int maxParticleBufferSize = 1000;
  private int nbParticles = 0;
  World world;

  public ParticleSystem(int maxParticleBufferSize) {
    this.maxParticleBufferSize = maxParticleBufferSize;
  }

  public void addEmitter(ParticleEmitter pe){
     emitters.put(pe.getName(),pe);
  }
  
  public void initialize(World w, String emitterName, int nbParticleGroup){
    this.world = w;
      for (int i=0; i < nbParticleGroup; i++) {
        ParticleGroup pg = create(emitterName);
        if(nbParticles+pg.particles.size()<maxParticleBufferSize){
          particleGroups.add(pg);        
        }else{
          println("too much particles generated");
        }
      }
  }
  
  private ParticleGroup create(String emitterName) {
    ParticleGroup pg = new ParticleGroup(
      this.world, 
      (int) random(5, 30), 
      random(0, width), random(0, height), 
      random(0, 20), 
      random(0.1, 0.9));

    pg.vel=new PVector(random(-4, 4),random(-4, 4));
    pg.lifespan = (int)random(100,1000);
    ParticleEmitter emitter=emitters.get(emitterName);
    pg.initialize(emitter);
    return pg;
  }
  
  public void draw() {
    background(0);
    for (int i=0; i<particleGroups.size(); i++) {
      ParticleGroup pg = particleGroups.get(i);
      pg.update();
      pg.draw();
      
      constrainToViewport(pg);
      
      testPGLifespan(i);
    }
  }
  
  private void constrainToViewport(ParticleGroup pg){
      if (pg.pos.x<0 || pg.pos.x>width) {
        pg.vel.x = - pg.vel.x;
      }
      if (pg.pos.y<0 || pg.pos.y>height) {
        pg.vel.y = - pg.vel.y;
      }
  }
  
  private void testPGLifespan(int i){
    if (particleGroups.get(i).isDead()) {
      particleGroups.remove(i);
    }
  }
}
