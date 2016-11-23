class CustomGcode {

  void sendGcode(String gcode) {
    customGcode = gcode;
    if (!custom) {
      streaming = false;
      custom = true;
    }
  }
}