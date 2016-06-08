class GrowUpCharacter {
  private int IMG_NUM = 10;//キャラの成長段階数
  private PImage[] img = new PImage[IMG_NUM];//キャラの画像
  
  private Quadrangle quad = new Quadrangle(4);

  private int state = 0;

  GrowUpCharacter() {
    for (int i=0; i<IMG_NUM; i++)
      img[i]=loadImage("character/"+i+".png");
      
    util.loading_txt("GrowUpCharacter", this.quad);
  }

  public void draw() {
    //characterState=min(keyingCount/GROATH_SPEED, CHARACTER_NUM-1);
    
    quad.Shape(this.img[this.state]);
  }
}