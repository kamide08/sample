void paint () {
  /*
  概要
   職人が行動し終えた時に描く処理
   */
  background(255);
  textSize(20);
  fill(0);
  text("ターン数", 20, 20);
  text(turn, 100, 20);
  text("城の数", 20, 50);
  text(castlenum, 100, 50);
  text("池の数", 20, 80);
  text(pondnum, 100, 80);
  text("職人の数", 20, 110);
  text(craftsmannum, 100, 110);
  text("自分", 20, 140);
  if (me == 1) {
    text("マリオ", 100, 140);
  } else {
    text("クリボー", 100, 140);
  }

  text("操作方法", 1150, 50);
  text("H  :  滞在", 1120, 80);
  text("J  :  移動", 1120, 110);
  text("K  :  建築", 1120, 140);
  text("L  :  解体", 1120, 170);
  text("方向", 1170, 230);
  text("E  :  ↖", 1120, 260);
  text("R  :  ↑", 1120, 290);
  text("T  :  ↗", 1120, 320);
  text("G  :   →", 1120, 350);
  text("B  :  ↘", 1120, 380);
  text("V  :  ↓", 1120, 410);
  text("C :  ↙", 1120, 440);
  text("D  :  ←", 1120, 470);

  text("のターン", 1150, 650);
}


void paintdraw() {
  /*
  概要
   常時、描く処理
   */
  fill(255);
  noStroke();
  rect(200, 10, 30 * vertical, 30 * vertical);
  for (int i = 0; i < vertical; i ++ ) {
    for ( int j = 0; j < beside; j ++ ) {
      if (wall[i][j] == 1) {
        fill(255, 0, 0);
        rect(200 + (i) * 30, 10 + (j) * 30, 30, 30);
      } else if (wall[i][j] == 2) {
        fill(0, 0, 255);
        rect(200 + (i) * 30, 10 + (j) * 30, 30, 30);
      } else if (tem_wall[i][j] == 1) {
        fill(255, 0, 0);
        rect(200 + (i) * 30, 10 + (j) * 30, 30, 30);
      } else if (tem_wall[i][j] == 2) {
        fill(0, 0, 255);
        rect(200 + (i) * 30, 10 + (j) * 30, 30, 30);
      }
    }
  }

  stroke(1);
  for (int i = 200; i <= 200 + beside * 30; i += 30 ) {
    line(i, 10, i, 10 + vertical * 30);
  }
  for (int j = 10; j <= 10 + vertical * 30; j += 30 ) {
    line(200, j, 200 + beside * 30, j);
  }

  for (int i = 0; i < castlenum; i ++ ) {
    image(castlepi, castleX[i], castleY[i]);
  }

  for (int i = 0; i < craftsmannum; i ++ ) {
    if (me == 1){
      image(craftsB, craftsmanBX[i], craftsmanBY[i]);
      textSize(30);
      fill(0);
      text(i + 1,  craftsmanAX[i] + 5, craftsmanAY[i] + 28);
    }else {
      image(craftsA, craftsmanAX[i], craftsmanAY[i]);
      textSize(30);
      fill(0);
      text(i + 1,  craftsmanBX[i] + 5, craftsmanBY[i] + 28);
    }
  }

  fill(0, 0, 255);
  noStroke();
  for (int i = 0; i < pondnum; i ++) {
    ellipse(pondX[i] + 15, pondY[i] + 15, 30, 30);
  }
  if (turnmotion >= 20){
    image(craftsku, 1150, 500);
  } else {
    image(craftsma, 1150, 500);
  }

  if (suport == 1) {
    for (int i = 0; i < vertical; i++ ) {
      for (int j = 0; j < vertical; j ++) {
        if (suport_di[i][j] == 1) {
          fill(255, 100, 0, 150);
          rect(200 + i * 30, 10 + j * 30, suport_size, suport_size );
        } else if (suport_di[i][j] == 2) {
          fill(0, 200, 255, 150);
          rect(200 + i * 30, 10 + j * 30, suport_size, suport_size );
        }
      }
    }
    if (suport_check == false) {
      suport_size --;
      suport_check = true;
    } else {
      suport_check = false;
    }
    if (suport_size <= -1)suport_size = 30;
  }
  
  

  noStroke();
  number = turnmotion - int(turnmotion / 10) * 10;
  if (turnmotion >= 20) {
    if(me == 1){
      image(craftsB, craftsmanBX[number], craftsmanBY[number]);
    }else {
      textSize(30);
      fill(0);
      text(number + 1,  craftsmanBX[number] + 5, craftsmanBY[number] + 28);
    }
    fill(255, 255, 0, fill);
    ellipse(craftsmanBX[number] +15, craftsmanBY[number] + 15, 30, 30);
  } else {
    if (me == 2){
      image(craftsA, craftsmanAX[number], craftsmanAY[number]);
    } else {
      textSize(30);
      fill(0);
      text(number + 1,  craftsmanAX[number] + 5, craftsmanAY[number] + 28);
    }
    fill(255, 255, 0, fill);
    ellipse(craftsmanAX[number] +15, craftsmanAY[number] + 15, 30, 30);
  }
  fill += 2;

  if (fill >= 255)fill = 0;
}
