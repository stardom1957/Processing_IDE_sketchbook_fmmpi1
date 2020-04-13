/*
 KVA serial message processing.
 Syntax is :
  topic=message
  topic: topîc or subject name for ex. cdfState
  =: separator
  message: message contents
  
  topics:
   name: irFrontCdsState (byte containing front ir collision detection sensors state)
   type: byte
   parse values:
    irFrontCdsState LSB 0 = right collision detect sensor, value 1
    irFrontCdsState LSB 1 = center collision detect sensor, value 2
    irFrontCdsState LSB 2 = left collision detect sensor, value 4
    
*/

/*
 KVA serial message processing.
 A. MESSAGE SYNTAX
    Syntax is : "topic[stc]message(type)", where
     topic is the message subject
     [stc] is the system time code
     message is the message contents
     (type) is the type of the message:
      i integer
      f float
      t text
      b byte
      d word 16-bit
      w word 32-bit

  B. MESSAGES PROCESSING
     All messages are sent/received as Strings concerted from the original
     data types by the sender. The (type) provided can be used for data
     conversions if used other than for display, i.e. calculations. See
     paragraph C.
     
  C. TOPIC PROCESSING
     Each topic will have it's own function for processing.
*/

// Example by Tom Igoe 
 
import processing.serial.*; 
Serial myPort;    // The serial port
PFont myFont;     // The display font
String inString = null;  // Input string from serial port
int lf = 10;      // ASCII linefeed
int rc = char('\n');

// param for srawing squares representing cd sensors
int xOri = 78;
int yOri = 75;
int xSpacing = 90;
int squareSize = 55;

void processSensorDataNode(String msg) {
 if (msg != null) {
  text("received: " + msg, 10, 15);
  // extract topic from msg (content from begining to = sign)
  String[] strMsgTable = split(msg, "=");
  String strTopic    = strMsgTable[0];
  String strMsgValue = strMsgTable[1];
  text("topic: " + strTopic, 34, 33);
  text(  "msg: " + strMsgValue, 40, 51);
    
  //draw 3 squares representing the collision detect sensors
  //according to topic cdsState's value
  
  stroke(204, 102, 0); //orange if sensor is triggered
  fill(204, 102, 0);
  //fill(128);
  square(xOri, yOri, squareSize);
  square(xOri + xSpacing, yOri, squareSize);
  square(xOri + (2 * xSpacing), yOri, squareSize);
 }
  else {
    text("received: notting!", 10, 15);
  }
}

void setup() { 
  size(400,200); 
  // You'll need to make this font with the Create Font Tool 
  myFont = loadFont("ProcessingSansPro-Regular-18.vlw"); 
  textFont(myFont, 18); 
  // List all the available serial ports: 
  printArray(Serial.list()); 
  // I know that the first port in the serial list on my mac 
  // is always my  Keyspan adaptor, so I open Serial.list()[0]. 
  // Open whatever port is the one you're using. 
  myPort = new Serial(this, Serial.list()[4], 9600); 
  myPort.bufferUntil(rc); 
} 
 
void draw() { 
  background(0);
  //draw 3 squares representing the collision detect sensors states
  //grey = off
  stroke(204, 102, 0);
  //fill(204, 102, 0);
  fill(128); //grey sensor not trigered
  square(xOri, yOri, squareSize); // right sensor
  square(xOri + xSpacing, yOri, squareSize); // centet sensor
  square(xOri + (2 * xSpacing), yOri, squareSize); // left sensor

  // process data received by sensors
  processSensorDataNode(inString);
} 
 
void serialEvent(Serial p) { 
  inString = p.readString();
} 
