class Telop {
  private Polygon poly = new Polygon(14);
  
  private int PERMIT_IMG_NUM  = 8;//テロップの種類
  private int PROHIB_IMG_NUM  = 3;//NGテロップの種類
  private int TELOP_MOVE      = -2400;//テロップの初期位置からのずれ
  private int TELOP_SPEED     = 5;//テロップの流れる速さ
  private int[] APEX_INTERVAL = {
    0, 630, 900, 1200, 1450, 1600
  };
  
  private PImage[] permit_img = new PImage[PERMIT_IMG_NUM];//使える時間帯のテロップ画像
  private PImage[] prohib_img = new PImage[PROHIB_IMG_NUM];//使えない時間帯のテロップ画像
  private PImage[] use_telop;//流すテロップ
  private PImage logo;

  private boolean[] is_display;

  private int move=0;
  private int telop_speed = 1;//テロップが動く間隔｜(frameCount%telopspeed==0)

  void setup_Telop() {
    for (int i=0; i<PERMIT_IMG_NUM; i++) {
      permit_img[i] = loadImage("telop/"+i+".png");
    }
    for (int i=0; i<PROHIB_IMG_NUM; i++) {
      prohib_img[i] = loadImage("telop/NGtelop/"+i+".png");
    }

    logo = loadImage("telop/logo.png");

    is_display = new boolean[PERMIT_IMG_NUM + PROHIB_IMG_NUM];
    is_display[0] = true;
    
    util.loading_txt("GrowUpCharacter", this.poly);
  }

  public void draw() {  
    for (int i=0; i<use_telop.length; i++) {
      if (is_display[i]) {
        beginShape();
          texture(use_telop[i]);          
          for(int j=0; j<=6; j++)
            vertex(poly.get_apex(0).get_X()   , poly.get_apex(0).get_Y()  , move+APEX_INTERVAL[i]  , 0);
          for(int j=0; j<=6; j++)
            vertex(poly.get_apex(7+j).get_X() , poly.get_apex(7+j).get_Y(), move+APEX_INTERVAL[6-j], use_telop[i].height);
        endShape(CLOSE);

        if (move >- TELOP_MOVE) {
          move = TELOP_MOVE;
          is_display[i] = false;

          if (i+1 == use_telop.length){
            is_display[0] = true;
          } else {
            is_display[i+1] = true;
          }
        }

        if (frameCount % telop_speed == 0) {
          if (is_debugmode) {
            if (keyPressed)      move -= TELOP_SPEED;
            if (!(mousePressed)) move += TELOP_SPEED;
          }
          move += TELOP_SPEED;
        }
      }
    }
  }
}