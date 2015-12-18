void Translate() {
  int point_selected=point_selected_area+point_selected_v;

  if ( mousePressed && point_selected>= 0 ) {
    save_state=false;
    all_vertex[point_selected_area][point_selected_v].setX(mouseX);
    all_vertex[point_selected_area][point_selected_v].setY(mouseY);
  } else {
    float min_d = 10; // この値が頂点への吸着の度合いを決める

    point_selected_area = -1;
    point_selected_v=-1;

    for (int i=0; i<all_vertex.length; i++) {
      for (int j=0; j<all_vertex[i].length; j++) {
        float d = dist( mouseX, mouseY, all_vertex[i][j].getX(), all_vertex[i][j].getY());

        if ( d < min_d ) {
          min_d = d;
          point_selected_area = i;
          point_selected_v=j;
        }
      }
    }
    if ( point_selected>= 0 ) {
      noFill();
      stroke(#ffff00);
      ellipse( mouseX, mouseY, 10, 10 );
    }
  }

  if (debugMode) {
    fill(#ff0000);
    for (int i=0; i<all_vertex.length; i++) {
      for (int j=0; j<all_vertex[i].length; j++) {
        text("p"+i*10+j, all_vertex[i][j].getX()+5, all_vertex[i][j].getY()-5);
      }
    }
  }
}