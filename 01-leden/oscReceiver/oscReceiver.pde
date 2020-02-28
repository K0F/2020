import oscP5.*;
import netP5.*;

import java.io.RandomAccessFile;


OscP5 oscP5;
float x, y, z;
ArrayList tail;
float sm = 10.0;
//import processing.opengl.*;

RandomAccessFile pipe;
byte raw[];
String tc;
PShader glsl;
int rate = 25;
int fr,seconds,minutes,hours;

int cnt = 0;

PFont ftc,txt;

int X[],Y[];

int c=0;

//ArrayList zaznamy;

void setup() {
  size(1024,576,OPENGL);
  oscP5 = new OscP5(this, 57120);
  frameRate(rate);
  tail = new ArrayList();


  raw = new byte[width*height*3];

 // zaznamy = ArrayList();

  try {
    Process b = new ProcessBuilder( "rm", sketchPath("")+"/raw.rgb" ).start();
    b.waitFor();
    pipe = new RandomAccessFile( sketchPath("")+"/raw.rgb", "rwd" );
  }
  catch(Exception e) {
    println("error opening pipe: "+e);
  }
  ftc=createFont("Semplice Regular",8,false);
  txt=createFont("Linux Libertine O",16,true);

  textFont(ftc);
  textAlign(CENTER);

  frameRate(rate);
  rectMode(CENTER);

}
/*
void record(){

  zaznamy.add(new Recording(zaznamy.size()));

}
*/
void draw() {
  //rect(x*(-1.0)*100.0+width/2, y*100.0+height/2, z, z);
  background(0);
  drawTc();
  translate(width/2,height/2);

  for(int i = 0 ; i < tail.size();i++){
    PVector tmp = (PVector)tail.get(i);
    pushMatrix();
    pushStyle();
    noFill();
    stroke(255,25);
    rotateY(tmp.x/4.0 * (-1.0));
    rotateX(tmp.y/4.0 * (-1.0));
    //box(tmp.z/20.0*i+2);
    box((tmp.z/200.0+1)*i+2);
    popStyle();
    popMatrix();
  }
  dump();
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.addrPattern().equals("/accelerometer")) {
    x += (theOscMessage.get(0).floatValue()-x)/sm;
    y += (theOscMessage.get(1).floatValue()-y)/sm;
    z += (theOscMessage.get(2).floatValue()-z)/sm;
    tail.add(new PVector(x,y,z));
/*
    if(zaznamy.size()>0)
      for(int i = 0 ; i < zaznamy.size();i++){
        Recording tmp = (Recording)zaznamy.get(i);
        if(tmp.isRecording)
          tmp.add(x,y,z);
      }
*/

    if(tail.size()>300)
      tail.remove(0);
  }
}


void dump() {
  loadPixels();
  for (int i = 0 ; i < pixels.length;i++) {
    raw[i*3]= (byte)(pixels[i] >> 16 & 0xFF);
    raw[i*3+1]= (byte)(pixels[i] >> 8 & 0xFF);
    raw[i*3+2]= (byte)(pixels[i] & 0xFF);
  }
  try {
    pipe.write(raw);
  }
  catch (Exception e) {
    e.printStackTrace();
  }
}

void drawTc(){

  fr++;

  if(fr>rate-1){
    fr=0;
    seconds++;
  }

  if(seconds>59){
    seconds=0;
    minutes++;
  }

  if(hours>23){
    hours=0;
  }


  tc = nf(hours,2)+":"+nf(minutes,2)+":"+nf(seconds,2)+":"+nf(fr,2);
  fill(0);
  noStroke();
  rect(width/2,35,90,20);
  fill(255);
  textFont(ftc);
  textAlign(LEFT);
  text(tc,width/2-16,40);

}

void exit() {
  try {
    pipe.close();
  }
  catch (Exception e) {
    // TODO Auto-generated catch block
    e.printStackTrace();
  }
  super.exit();
}
