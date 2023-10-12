void move () {
  /*
  motionとdirectionに基づき職人を動かす
  */
  number = turnmotion - int(turnmotion / 10) * 10;
  if (turnmotion < 20 ) {
    if (motion == 1) {
      if (direction == 1) {
        craftsmanAX[number] -= 30;
        craftsmanAY[number] -= 30;
      } else if (direction == 2) {
        craftsmanAY[number] -= 30;
      } else if (direction == 3) {
        craftsmanAX[number] += 30;
        craftsmanAY[number] -= 30;
      } else if (direction == 4) {
        craftsmanAX[number] += 30;
      } else if (direction == 5) {
        craftsmanAX[number] += 30;
        craftsmanAY[number] += 30;
      } else if (direction == 6) {
        craftsmanAY[number] += 30;
      } else if (direction == 7) {
        craftsmanAX[number] -= 30;
        craftsmanAY[number] += 30;
      } else if (direction == 8) {
        craftsmanAX[number] -= 30;
      }
    } else if (motion == 2 ) {
      int oriX = (craftsmanAX[number] - 200)  / 30 ;
      int oriY = (craftsmanAY[number] - 5) / 30 ;
      if (direction == 2) {
        wall[oriX][oriY -1] = 1;
      } else if (direction == 4) {
        wall[oriX + 1][oriY] = 1;
      } else if (direction == 6) {
        wall[oriX][oriY + 1] = 1;
      } else if (direction == 8) {
        wall[oriX - 1][oriY] = 1;
      }
    } else if (motion == 3 ) {
      int oriX = (craftsmanAX[number] - 200)  / 30 ;
      int oriY = (craftsmanAY[number] - 5) / 30 ;
      if (direction == 2) {
        wall[oriX][oriY -1] = 0;
      } else if (direction == 4) {
        wall[oriX + 1][oriY] = 0;
      } else if (direction == 6) {
        wall[oriX][oriY + 1] = 0;
      } else if (direction == 8) {
        wall[oriX - 1][oriY] = 0;
      }
    }
  } else {
    if (motion == 1) {
      if (direction == 1) {
        craftsmanBX[number] -= 30;
        craftsmanBY[number] -= 30;
      } else if (direction == 2) {
        craftsmanBY[number] -= 30;
      } else if (direction == 3) {
        craftsmanBX[number] += 30;
        craftsmanBY[number] -= 30;
      } else if (direction == 4) {
        craftsmanBX[number] += 30;
      } else if (direction == 5) {
        craftsmanBX[number] += 30;
        craftsmanBY[number] += 30;
      } else if (direction == 6) {
        craftsmanBY[number] += 30;
      } else if (direction == 7) {
        craftsmanBX[number] -= 30;
        craftsmanBY[number] += 30;
      } else if (direction == 8) {
        craftsmanBX[number] -= 30;
      }
    } else if (motion == 2 ) {
      int oriX = (craftsmanBX[number] - 202)  / 30 ;
      int oriY = (craftsmanBY[number] - 7) / 30 ;
      if (direction == 2) {
        wall[oriX][oriY -1] = 2;
      } else if (direction == 4) {
        wall[oriX + 1][oriY] = 2;
      } else if (direction == 6) {
        wall[oriX][oriY + 1] = 2;
      } else if (direction == 8) {
        wall[oriX - 1][oriY] = 2;
      }
    }else if (motion == 3 ) {
      int oriX = (craftsmanBX[number] - 202)  / 30 ;
      int oriY = (craftsmanBY[number] - 7) / 30 ;
      if (direction == 2) {
        wall[oriX][oriY -1] = 0;
      } else if (direction == 4) {
        wall[oriX + 1][oriY] = 0;
      } else if (direction == 6) {
        wall[oriX][oriY + 1] = 0;
      } else if (direction == 8) {
        wall[oriX - 1][oriY] = 0;
      }
    }
  }
  moveend(); //最後の処理を行う
  paint();
}

void moveend() {
  /*
  職人を動かした後の処理をする
  */
  direction = -1;
  motion = -1;
  turnmotion ++;
  if (turnmotion >= 10 + craftsmannum && turnmotion <= 19) {
    turnmotion = 20;
    suport_tool();
  } else if (turnmotion >= 20 + craftsmannum ) {
    turnmotion = 10;
    turn ++;
    if (suport == 1)suport_tool();
  }
}
