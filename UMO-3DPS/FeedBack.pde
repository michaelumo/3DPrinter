class FeedBack {
  int n = 0;
  void decodeData(String data) {
    n = 2;
    updateGraph(int(getVal(data, ',')));
    for (int i = 1; i < 10; i++) {
      values[i] = int(getVal(data, ','));
    }
  }

  void updateGraph(int data) {
    for (int i = 1; i<width/2-20; i++) {
      numbers[i-1] = numbers[i];
    }
    numbers[width/2-20-1]=data;
    values[0] = data;
    //sLink.addData(str(data));
  }

  float getVal(String data, char sign) {
    String val = "";
    while (n < data.length() && data.charAt(n) != sign) {
      val += data.charAt(n);
      n++;
    }
    n++;
    return float(val);
  }
}