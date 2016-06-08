class BeckonCharacter {
  private PImage swingup;
  private PImage swingdown;
  
  private boolean is_beckon;

  private int state = 1;
  private int interval = 1;

  Quadrangle quad = new Quadrangle(4);
  
  BeckonCharacter(){
    this.swingup   = loadImage("character/t1.png");
    this.swingdown = loadImage("character/t2.png");
    
    util.loading_txt("BeckonCharacter", this.quad);
  }
  
  public void draw(){
    this.state = (frameCount%(this.interval*30) == 0)
      ? 0
      : 1;

    if (this.is_beckon) {
      PImage img = (this.state == 0)
        ? this.swingup
        : this.swingdown;     
      quad.Shape(img);
    } 
  }
}