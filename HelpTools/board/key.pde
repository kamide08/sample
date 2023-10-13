void keyReleased(){
  /*
  概要
  キーを押しても1回しか反応しないようにキーが離されたらkeycheckを0にする
  */
  keycheck = 0;
}

void keyPress() {
  /*
  概要
  キーが押されたらそのキーに合わせて処理をする
  */
  if (key == '7') {
    motion = 1;
  } else if (key == '8') {
    motion = 2;
  } else if (key == '9') {
    motion = 3;
  } else if (key == '0') {
    motion = 0;
  } else if (key == 'q') {
    direction = 1;
  } else if (key == 'w') {
    direction = 2;
  } else if (key == 'e') {
    direction = 3;
  } else if (key == 'd' || key == '4') {
    direction = 4;
  } else if (key == 'c' || key == '5') {
    direction = 5;
  } else if (key == 'x'|| key == '6') {
    direction = 6;
  } else if (key == 'z'|| key == '7') {
    direction = 7;
  } else if (key == 'a'|| key == '8') {
    direction = 8;
  } else if (key == 'y') {
    me = 1;
    paint();
  } else if (key == 'u') {
    me = 2;
    paint();
  } else if (key == '0'){
    motion = 0;
    direction = 0;
  } else if (key == '1'){
    if (motion == -1){
      motion = 1;
    } else {
      direction = 1;
    }
  }  else if (key == '2'){
    if (motion == -1){
      motion = 2;
    } else {
      direction = 2;
    }
  } else if (key == '3'){
    if (motion == -1){
      motion = 3;
    } else {
      direction = 3;
    }
  } else if (keyCode == ENTER){
    faile();
  }else if (keyCode == UP){
    for (int i = 0 ; i < craftsmannum ; i ++){
      println("craftsmanAX[" + i + "] = " + craftsmanAX[i]);
      println("craftsmanAY[" + i + "] = " + craftsmanAY[i]);
      println("craftsmanBX[" + i + "] = " + craftsmanBX[i]);
      println("craftsmanBY[" + i + "] = " + craftsmanBY[i]);
    }
  }
  
  
  keycheck = 1;
  motioncheck();   //向きと動きがどちらも決定されたかを判断する
}

void motioncheck() {
  /*
  行動と方向が指定されていたらmove関数を実行し、職人を動かす
  */
  if ((motion != -1 && direction != -1) || motion == 0)move();  //職人を動かす
}

void keyPressed(){
   if (key == 's')start = 1;
}
