class RefNum {
  int getRefNum(int pFlag, int val) {
    int refNum = 0;
    switch (pFlag) {
    case 1:
      switch (val) {
      case 0:
        refNum = 1;
        break;
      case 1:
        refNum = 1;
        break;
      case 21:
        refNum = 2;
        break;
      case 28:
        refNum = 3;
        break;
      case 90:
        refNum = 4;
        break;
      case 91:
        refNum = 5;
        break;
      case 92:
        refNum = 6;
        break;
      }
      break;
    case 2:
      switch (val) {
      case 0:
        refNum = 7;
        break;
      case 1:
        refNum = 8;
        break;
      case 18:
        refNum = 9;
        break;
      case 82:
        refNum = 10;
        break;
      case 83:
        refNum = 11;
        break;
      case 84:
        refNum = 12;
        break;
      case 92:
        refNum = 13;
        break;
      case 104:
        refNum = 14;
        break;
      case 105:
        refNum = 15;
        break;
      case 106:
        refNum = 16;
        break;
      case 107:
        refNum = 17;
        break;
      case 109:
        refNum = 18;
        break;
      case 112:
        refNum = 19;
        break;
      case 114:
        refNum = 20;
        break;
      case 115:
        refNum = 21;
        break;
      case 116:
        refNum = 22;
        break;
      case 117:
        refNum = 23;
        break;
      case 135:
        refNum = 24;
        break;
      case 143:
        refNum = 25;
        break;
      case 201:
        refNum = 26;
        break;
      case 206:
        refNum = 27;
        break;
      case 208:
        refNum = 28;
        break;
      case 300:
        refNum = 29;
        break;
      case 301:
        refNum = 30;
        break;
      case 350:
        refNum = 31;
        break;
      case 400:
        refNum = 32;
        break;
      case 404:
        refNum = 33;
        break;
      }
      break;
    }
    return refNum;
  }
}