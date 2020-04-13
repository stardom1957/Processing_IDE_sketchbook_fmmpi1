/**
 * Simple Read
 * 
 * Read data from the serial port and change the color of a rectangle
 * when a switch connected to a Wiring or Arduino board is pressed and released.
 * This example works with the Wiring / Arduino program that follows below.
 */


import processing.serial.*;

Serial myPort;  // Create object from Serial class
int val=0;      // Data received from the serial port

void setup() 
{
  size(200, 200);
  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[4];

  printArray(Serial.list());
  print("portName=«");
  print(portName);
  println("»");
  //myPort = new Serial(this, portName, 9600, 'N', 8, 1.0);
  myPort = new Serial(this, portName, 9600);
  fill(255); //originaly fill with white
}

void draw()
{
  if ( myPort.available() > 0) {  // If data is available,
    val = myPort.read();         // read it and store it in val
    //println("Reading myPort here");
  }
  background(255);             // Set background to white
  if (val == 66 || val == 98) {              // If the serial value correspond to b or B
    fill(0);                   // set fill to black
  }
  
  if (val == 71 || val == 103) {                       // If the serial value correspond to g or G
    fill(204);                 // set fill to light gray
  }
  rect(50, 50, 100, 100);
  //print(val); print(" ");
}
