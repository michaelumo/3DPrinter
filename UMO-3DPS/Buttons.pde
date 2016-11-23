class Buttons {

  void displayButtonName(int buttonId) {
    String buttonName = getButton(buttonId);
    //stroke(255);
    textAlign(LEFT);
    textSize(13);
    fill(255);
    text(buttonName, 190, 20);
  }

  String getButton(int buttonId) {
    String buttonName = "";
    switch(buttonId) {
    case 1:
      buttonName = "Printer";
      break;
    case 2:
      buttonName = "Open File";
      break;
    case 3:
      buttonName = "Start";
      break;
    case 4:
      buttonName = "Stop";
      break;
    case 5:
      buttonName = "Reset All";
      break;
    case 6:
      buttonName = "Help";
      break;
    default:
      buttonName = "";
      break;
    }
    return buttonName;
  }
}