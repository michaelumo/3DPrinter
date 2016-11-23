class Decoder {
  int n = 0;
  String data;

  String getData(String oldData) {
    data = oldData;
    n = 0;
    int pFlag = 0;
    int refNum = 0;
    if (data.charAt(n) == 'G')pFlag = 1;
    else if (data.charAt(n) == 'M') {
      pFlag = 2;
    } else {
      return "0";
    }
    RefNum ref;
    ref = new RefNum();
    n = 1;
    refNum = (int)getNum(';');
    refNum = ref.getRefNum(pFlag, refNum);
    n++;
    String all = getAll(refNum);
    return all;
  }

  String getAll(int refNum) {
    String mainData;
    mainData = nf(refNum, 2);
    String sub =  getElements(); 
    mainData += nf(sub.length()/10, 1);
    mainData += sub;
    return mainData;
  }

  float getNum(char g) {
    String num = "";
    while ( n < data.length() && data.charAt(n) != g && data.charAt(n) != ' ' && data.charAt(n) != ';') {
      num += data.charAt(n);
      n++;
    }  
    return float(num);
  }

  int getChar() {
    int val = 0;

    switch (data.charAt(n)) {
    case 'G':
      val = 1;
      break;
    case 'M':
      val = 2;
      break;
    case 'X':
      val = 3;
      break;
    case 'Y':
      val = 4;
      break;
    case 'Z':
      val = 5;
      break;
    case 'E':
      val = 6;
      break;
    case 'F':
      val = 7;
      break;
    case 'S':
      val = 8;
      break;
    case 'P':
      val = 9;
      break;
    default:
      break;
    }

    return val;
  }

  String getElements() {
    String mainData = "";
    int element = 0;
    float p = 0;
    int flag = 0;
    while (n < data.length() && data.charAt(n) != ';' && data.charAt(n) != ' ') {
      element = getChar();
      n++;
      mainData += nf(element, 2);
      p = getNum(' ');
      if (p >= 0) {
        mainData += str(3);
      } else if (p < 0) {    
        mainData += str(2);
        p *= -1;
      }
      mainData += nf(p, 4, 2);
      n++;
    }
    return mainData;
  }
}