import oscP5.*;
import netP5.*;

import java.io.RandomAccessFile;


float x, y, z;
ArrayList tail;
float sm = 10.0;
//import processing.opengl.*;


int numFrames = 29940;

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
  size(1920,1080,OPENGL);
  frameRate(rate);
noiseSeed(2020);

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

void draw() {
  background(0);
  drawTc();

  int step = 70;
  for(int y = step;y<height;y+=step)
  for(int x = step;x<width;x+=step){
fill(255,15);
  pushMatrix();
  rectMode(CENTER);
  noStroke();
  translate(x,y);
  rotate(frameCount/60.0*TWO_PI*(noise(x/1000.0,y/1000.0+frameCount/60.0)*0.1+1.0)*(-1.0));
  rect(0,0,step,step);

  popMatrix();
  }
  dump();

  if(frameCount>numFrames)
  exit();

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
