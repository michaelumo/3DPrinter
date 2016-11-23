import java.awt.event.KeyEvent;
import javax.swing.JOptionPane;
import processing.serial.*;
import java.awt.Dimension;
import processing.awt.PSurfaceAWT.SmoothCanvas;
import javax.swing.JFrame;

PImage Printer;
PImage File;
PImage Reset;
PImage Settings;
PImage Help;
PImage rightArrow;
PImage leftArrow;
String printerName = "";
String buttonName = "";
String portName = null;
String error = "";
String solution = "";
String customGcode = "";
String[] lines;
String[] SerialData;
String[] valueName;
boolean streaming = false;
boolean errorFlag = false;
boolean custom = false;
boolean startPrint = false;
boolean cursor = false;
int darkGreen = #2C572B;
int lightGreen = #8CC690;
int errorColor = #7BF07C;
int[] values;
CustomGcode customG;
Decoder dec;
Layout layout;
FeedBack feedBack;
SerialLink sLink;
Dimension minimumSize = new Dimension(300, 400);
int line = 0;
Serial port = null;
int[] numbers;
int rFlag = 0;

void setup() { 
  Printer = loadImage("printer.png");
  File = loadImage("file.png");
  Reset = loadImage("reset.png");
  Settings = loadImage("settings.png");
  Help = loadImage("help.png");
  rightArrow = loadImage("right.png");
  leftArrow = loadImage("left.png");
  textSize(12);
  size(500, 600);
  SmoothCanvas sc = (SmoothCanvas) getSurface().getNative();
  JFrame jf = (JFrame) sc.getFrame();
  Dimension d = new Dimension(300, 400);
  jf.setMinimumSize(d);
  getSurface().setResizable(true);
  numbers = new int[1000];
  dec = new Decoder();
  layout = new Layout();
  feedBack = new FeedBack();
  sLink = new SerialLink();
  customG = new CustomGcode();
  valueName = new String[10];
  valueName[0] = "Tmp";
  valueName[1] = "Kp";
  valueName[2] = "Ki";
  valueName[3] = "Kd";
  valueName[4] = "PosX";
  valueName[5] = "PosY";
  valueName[6] = "PosZ";
  valueName[7] = "SwX";
  valueName[8] = "SwY";
  valueName[9] = "SwZ";
  values = new int[10];
  SerialData = new String[1000];
  for (int i = 0; i < 1000; i++) {
    SerialData[i] = " ";
    if (i < 10) values[i] = 0;
  }
}

void draw() {

  background(255);
  layout.layOut();
  layout.settingLayer();
  layout.mainLayer();
  layout.downLayer();
  layout.note();
}

void selectSerialPort()
{
  String connect = (String) JOptionPane.showInputDialog(frame, 
    "Select the serial port that corresponds to your Arduino board.", 
    "Select serial port", 
    JOptionPane.QUESTION_MESSAGE, 
    null, 
    Serial.list(), 
    0);
  if (connect != null) {
    portName = connect;
  }
}

void openSerialPort()
{
  if (portName == null) return;
  port = new Serial(this, portName, 115200);

  port.bufferUntil('\n');
}

void fileSelected(File selection) {
  if (selection == null) {
    sLink.addData("Window was closed or the user hit cancel.");
  } else {
    sLink.addData("User selected " + selection.getAbsolutePath());
    lines = loadStrings(selection.getAbsolutePath());
    sLink.addData("there are " + lines.length + " lines");
    stream();
  }
}



void mouseClicked() {
  //Serial port
  if (layout.clickedCover(5, 4, 26, 26)) {
    if (portName == null) {
      errorFlag = false;
      selectSerialPort();
      openSerialPort();
    } else {
      errorFlag = true;
      error = "error: open port";
      solution = "Solution: Reset the software";
    }
  }
  //Files
  if (layout.clickedCover(35, 4, 56, 24)) {
    if (lines == null || portName == null) {
      errorFlag = false;
      sLink.addData("Loading file...");
      selectInput("Select a file to process:", "fileSelected");
    } else if (portName != null) {
      errorFlag = true;
      error = "error: open port";
      solution = "Solution: Reset the software";
    }
  }
  //Start
  if (layout.clickedCover(65, 4, 86, 26)) {
    if (portName != null && lines != null) {
      errorFlag = false;
      streaming = true;
      port.write("ok?\n");
      sLink.addData("ok?\n");
      startPrint = true;
    } else if (portName == null) {
      errorFlag = true;
      error = "error: port is null";
      solution = "Solution: Please select your printer";
    } else if (lines == null) {
      errorFlag = true;
      error = "error: file is null";
      solution = "Solution: Please select your file";
    }
  }
  //Pause
  if (layout.clickedCover(95, 4, 116, 26)) {
    if (portName != null && lines != null) {
      errorFlag = false;
      streaming = false;
      sLink.addData("Pause\n");
    } else if (portName == null) {
      errorFlag = true;
      error = "error: port is null";
      solution = "Solution: Please select your printer";
    } else if (lines == null) {
      errorFlag = true;
      error = "error: file is null";
      solution = "Solution: Please select your file";
    }
  }
  //Reset
  if (layout.clickedCover(125, 4, 145, 24)) {
    if (!streaming && portName != null) {
      errorFlag = false;
      initUMO();
      sLink.addData("Reset\n");
    } else {
      errorFlag = true;
      error = "error: streaming";
      solution = "Solution: Please stop the printer first by the STOP button";
    }
  }
  //Left axis button
  if (layout.clickedCover(int(width/2/3/3/2)+5, height/8+5, int(width/2/3/3/2)+43, height/8+43)) {
    if (portName != null) {
    } else {
      errorFlag = true;
      error = "error: port is null";
      solution = "Solution: Please select your printer";
    }
  }
  //Right axis button
  if (layout.clickedCover(int(width/3/3*1.8)+5, height/8+5, int(width/3/3*1.8)+43, height/8+43)) {
    fill(lightGreen);
    ellipse(width/3/3*1.8+24, height/8+24, 47, 47);
    if (portName != null) {
    } else {
      errorFlag = true;
      error = "error: port is null";
      solution = "Solution: Please select your printer";
    }
  }
  //Custom Gcode box
  if (layout.clickedCover(20, height-55, 220, height-35)) {
    customGcode = "";
    cursor = true;
  } else {
    cursor = false;
  }
}

void initUMO() {
  port.clear();
  port.write("reset!\n");
  lines = null;
  port.stop();
  portName = null;
  line = 0;
}

void keyPressed() {
  if (cursor) {
    if (keyCode == BACKSPACE) {
      if (customGcode.length() > 0) {
        customGcode = customGcode.substring(0, customGcode.length()-1);
      }
    } else if (keyCode == DELETE) {
      customGcode = "";
    } else if (keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT) {
      customGcode += key;
    }
  }
}

void stream() {
  while (lines != null && rFlag != 0) {
    while (line < lines.length && !lines[line].equals("") && rFlag != 0) { 
      String some = dec.getData(lines[line]);
      if (some != "0") {
        sLink.addData(some);
        port.write(some+"\n");
        rFlag = 0;
        break;
      } else {
        if (line < lines.length)line++;
      }
    }
    if (rFlag == 0)break;
    line++;
  }
}


void serialEvent(Serial p)
{
  String s = p.readStringUntil('\n');
  String data = s.trim();
  sLink.addData(data);

  if (data.startsWith("ok") && streaming || (data.startsWith("ok") && startPrint && !streaming && !custom)) {
    streaming = true;
    feedBack.decodeData(data);
    rFlag = 1;
    line++;
    stream();
  } else if (data.startsWith("ok") && startPrint && !streaming && custom) {
    feedBack.decodeData(data);
    custom = false;
    port.write(customGcode+'\n');
  }
  if (data.startsWith("no")) {
    feedBack.decodeData(data);
  }
  if (s.trim().startsWith("error")) rFlag = 0;
}
