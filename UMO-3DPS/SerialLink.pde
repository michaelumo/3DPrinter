class SerialLink {
  void addData(String data) {
    for(int i = 1; i < (height/2-60)/10; i++){
        SerialData[i-1] = SerialData[i];
    }
    SerialData[(height/2-60)/10-1] = data;
  }
}