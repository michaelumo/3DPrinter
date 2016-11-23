class Layout {
  Buttons button;
  int mouseCover(int x1, int y1, int x2, int y2, int pColor, int sColor, int buttonId) {
    button = new Buttons();
    if (mouseX >= x1 && mouseY >= y1 && mouseX <= x2 && mouseY <= y2) {
      button.displayButtonName(buttonId);
      return sColor;
    } else return pColor;
  }

  boolean clickedCover(int x1, int y1, int x2, int y2) {
    if (mouseX >= x1 && mouseY >= y1 && mouseX <= x2 && mouseY <= y2) {
      return true;
    } else return false;
  }

  void layOut() {
    stroke(darkGreen);
    fill(darkGreen);
    rect(0, 0, width, 30);
    stroke(lightGreen);
    fill(lightGreen);
    rect(0, 30, width, 30);

    fill(lightGreen);
    rect(0, height-60, width, 30);
    stroke(darkGreen);
    fill(darkGreen);
    rect(0, height-30, width, 30);
    stroke(lightGreen);
  }

  String settingLayer() {
    String buttonName = "";
    stroke(lightGreen);

    //Print
    fill(mouseCover(5, 4, 26, 26, lightGreen, 255, 1));
    rect(5, 4, 20, 21);
    image(Printer, 5, 5);

    //File
    fill(mouseCover(35, 4, 56, 24, lightGreen, 255, 2));
    rect(35, 4, 20, 21);
    image(File, 35, 5);

    //Play
    fill(mouseCover(65, 4, 86, 26, lightGreen, 255, 3));
    rect(65, 4, 20, 20);
    fill(darkGreen);
    triangle(70, 8, 70, 20, 82, 14);

    //Puase
    fill(mouseCover(95, 4, 116, 26, lightGreen, 255, 4));
    rect(95, 4, 20, 20);
    fill(darkGreen);
    rect(99, 8, 12, 12);

    //Reset
    fill(mouseCover(125, 4, 145, 24, lightGreen, 255, 5));
    rect(125, 4, 20, 20);
    image(Reset, 125, 5);

    //Help
    fill(mouseCover(155, 4, 176, 24, lightGreen, 255, 6));
    rect(155, 4, 21, 20);
    image(Help, 156, 5);

    //Settings
    fill(mouseCover(width-30, 4, width-10, 24, lightGreen, 255, 0));
    rect(width-30, 4, 20, 20);
    image(Settings, width-29, 5);

    return buttonName;
  }

  void mainLayer() {
    //Deviding lines
    stroke(lightGreen);
    fill(lightGreen);
    line(width/2, 60, width/2, height-60);
    line(0, (height-120)/2+60, width, (height-120)/2+60);

    //Graph
    stroke(0);
    fill(255, 0);
    line(width/2+10, (height-120)/2+70, width/2+10, height-70);
    line(width/2+10, height-70, width-10, height-70);
    beginShape();
    for (int i = 0; i<width/2-20; i++) {
      vertex((width/2+10+i), height-70-numbers[i]*(1.5));
    }
    endShape();

    //Serial link
    textSize(10);
    stroke(0);
    textAlign(LEFT);
    fill(0);
    for (int i = 0; i<(height/2-60)/10; i++) {
      text(SerialData[i], 5, height/2+(height/2-60)-10*i);
    }

    //FeedBacks lines
    stroke(lightGreen);
    fill(darkGreen);
    for (int i = 0; i < 10; i++) {
      rect(width/3, ((height/2-60)/10*i)+60, (width/2-width/3)/3, (height/2-60)/10);
    }

    stroke(darkGreen);
    fill(lightGreen);
    line(width/3, 60, width/3, height/2);
    for (int i = 0; i < 10; i++) {
      rect((width/2-width/3)/3+width/3, ((height/2-60)/10*i)+60, (width/2-width/3)/3*2, (height/2-60)/10);
    }

    stroke(255);
    fill(255);
    textSize(12);
    textAlign(CENTER, CENTER);
    for (int i = 0; i < 10; i++) {
      text(valueName[i], (width/2-width/3)/6+width/3, ((height/2-60)/20*(i+1))+60+(height/2-60)/20*i);
    }

    //FeedBack values
    stroke(0);
    fill(0);
    textSize(12);
    textAlign(CENTER, CENTER);
    for (int i = 0; i < 10; i++) {
      text(values[i], ((width/2-width/3)/3)*2+width/3, ((height/2-60)/20*(i+1))+60+(height/2-60)/20*i);
    }

    //Moving arrow axes
    stroke(lightGreen);
    //right
    fill(mouseCover(int(width/9*1.8)+5, height/8+5, int(width/9*1.8)+43, height/8+43, lightGreen, 255, 0));
    ellipse(width/9*1.8+24, height/8+24, 47, 47);
    //left
    fill(mouseCover(int(width/36)+5, height/8+5, int(width/36)+43, height/8+43, lightGreen, 255, 0));
    ellipse(width/36+24, height/8+24, 47, 47);
    image(rightArrow, width/9*1.8, height/8);
    image(leftArrow, width/36, height/8);
  }

  void downLayer() {
    //CustomGcode box
    stroke(255);
    fill(255);
    rect(20, height-55, 200, 20);
    //send button
    stroke(darkGreen);
    fill(mouseCover(230, height-55, 270, height-35, darkGreen, lightGreen, 0));
    rect(230, height-55, 40, 20);
    stroke(255);
    fill(255);
    textSize(12);
    textAlign(CENTER, CENTER);
    text("Send", 250, height-45);
    //Cursor
    if (cursor) {
      stroke(0);
      fill(0);
      line(25+textWidth(customGcode), height-52, 25+textWidth(customGcode), height-38);
    }
    //Custom Gcode text
    stroke(0);
    fill(0);
    textSize(12);
    textAlign(LEFT, CENTER);
    text(customGcode, 25, height-45);
  }

  void note() {
    if (errorFlag) {
      textAlign(LEFT);
      stroke(#F51616);
      fill(#F51616);
      ellipse(8, height-15, 6, 6);
      stroke(255);
      fill(255);
      textSize(12);
      text(error, 15, height-11);
      text(solution, 150, height-11);
    }
  }
}