void keyPressed() {
  switch(key) {
  case'a':
    h=60;
    drawCrystal(h-21);
    println(true);
    break;

  case's':
    writing_all_txt();
    save_state=true;
    break;
  }
}