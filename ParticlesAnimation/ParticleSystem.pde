public class ParticleSystem{

  ArrayList<ParticleGroup> particleGroups = new ArrayList<ParticleGroup>();
  Particle[] particles = new Particle[1000];
  
  World world = new World();
  int nbpg = 40;

  public ParticleSystem() {
    for (int i=0; i < nbpg; i++) {
      ParticleGroup pg = createPG();
      particleGroups.add(pg);
    }
  }
  
  private ParticleGroup createPG() {
    ParticleGroup pg = new ParticleGroup(
      this,
      world, 
      (int) random(5, 30), 
      random(0, width), random(0, height), 
      random(0, 20), 
      random(0.1, 0.9));
    pg.vel.x=random(-4, 4);
    pg.vel.y=random(-4, 4);
    pg.lifespan = (int)random(100,1000);
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
