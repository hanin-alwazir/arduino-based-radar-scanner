import processing.serial.*;
import java.awt.event.KeyEvent;
import java.io.IOException;

Serial myPort;
String angle="";
String distance="";
String data="";
float pixsDistance;
int iAngle, iDistance;
int index1=0;

void setup() {
  size(1200, 700);
  smooth();
  myPort = new Serial(this, "COM10", 9600); 
  myPort.bufferUntil('.'); 
}

void draw() {
  fill(98,245,31);
  noStroke();
  fill(0,4); 
  rect(0, 0, width, height-height*0.065); 
  
  drawRadar(); 
  drawLine();
  drawObject();
  drawText();
}

void serialEvent(Serial myPort) {
  data = myPort.readStringUntil('.');
  if(data != null) {
    data = trim(data);
    index1 = data.indexOf(",");
    if(index1 > 0) {
      angle = data.substring(0, index1);
      distance = data.substring(index1+1, data.length());
      iAngle = int(angle);
      iDistance = int(distance);
    }
  }
}

void drawRadar() {
  pushMatrix();
  translate(width/2, height-height*0.074);
  noFill();
  strokeWeight(2);
  stroke(98,245,31);
  // رسم أقواس نصف الدائرة (180 درجة)
  arc(0,0,(width-width*0.1),(width-width*0.1),PI,TWO_PI);
  arc(0,0,(width-width*0.3),(width-width*0.3),PI,TWO_PI);
  arc(0,0,(width-width*0.5),(width-width*0.5),PI,TWO_PI);
  arc(0,0,(width-width*0.7),(width-width*0.7),PI,TWO_PI);
  // رسم خطوط الزوايا
  line(-width/2,0,width/2,0);
  line(0,0,(width/2)*cos(radians(30)),-(width/2)*sin(radians(30)));
  line(0,0,(width/2)*cos(radians(60)),-(width/2)*sin(radians(60)));
  line(0,0,(width/2)*cos(radians(90)),-(width/2)*sin(radians(90)));
  line(0,0,(width/2)*cos(radians(120)),-(width/2)*sin(radians(120)));
  line(0,0,(width/2)*cos(radians(150)),-(width/2)*sin(radians(150)));
  popMatrix();
}

void drawLine() {
  pushMatrix();
  strokeWeight(9);
  stroke(30,250,60);
  translate(width/2,height-height*0.074);
  line(0,0,(height-height*0.12)*cos(radians(iAngle)),-(height-height*0.12)*sin(radians(iAngle)));
  popMatrix();
}

void drawObject() {
  pushMatrix();
  translate(width/2,height-height*0.074);
  strokeWeight(9);
  stroke(255,10,10); 
  pixsDistance = iDistance*((height-height*0.166)*0.025); 
  if(iDistance < 40) {
    point(pixsDistance*cos(radians(iAngle)), -pixsDistance*sin(radians(iAngle)));
  }
  popMatrix();
}

void drawText() {
  pushMatrix();
  fill(0,0,0);
  noStroke();
  rect(0, height-height*0.065, width, height);
  fill(98,245,31);
  textSize(25);
  text("Angle: " + iAngle + " °", width-width*0.48, height-height*0.027);
  text("Distance: " + iDistance + " cm", width-width*0.26, height-height*0.027);
  popMatrix();
}
