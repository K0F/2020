
//import processing.opengl.*;
import java.io.RandomAccessFile;

RandomAccessFile pipe;
byte raw[];
String tc;
PShader glsl;
int rate = 60;
int fr,seconds,minutes,hours;

int cnt =0 ;

PFont ftc,txt;

int X[],Y[];


void setup() {
  size(720,576);
  smooth();

  raw = new byte[width*height*3];

  try {
    Process b = new ProcessBuilder( "rm", sketchPath("")+"/raw.rgb" ).start();
    b.waitFor();
    pipe = new RandomAccessFile( sketchPath("")+"/raw.rgb", "rwd" );
  }
  catch(Exception e) {
    println("error opening pipe: "+e);
  }
  ftc=createFont("Fira Mono Bold",10,false);
  txt=createFont("Linux Libertine O",16,true);

  textFont(ftc);
  textAlign(CENTER);

  frameRate(rate);
  rectMode(CENTER);

  for(int i = 0 ; i < width;i++){
    stroke( map(i, 0,width,0,255) );
    line(i,0,i,height);
  }
  fill(0);
  noStroke();

  glsl = loadShader("one.glsl");
  X=new int[width];
  Y=new int[height];
}

void keyPressed(){
  if(key==' '){
    glsl = loadShader("one.glsl");
  }
  if(key=='q')
    exit();
}
void draw() {

  background(0);
  noStroke();

  for(int i = 200 ; i > 1;i--){
    //float alpha = (sin((frameCount+log(i+1))/60.0*TWO_PI/200.0)+1.0)*127.0;
    float r = (sin((frameCount+i)/60.0*TWO_PI*(90*(log(i+1)/120000.012)) )+1.0) * 200.0 + 2;
    float x = sin((frameCount+i)/60.0*TWO_PI*((121.3*(log(i+1)/120000.01))))*(width/2-r)+width/2;
    fill(i%2==0?252:3);
    ellipse(x,height/2,r,r);
  }

  /*
     loadPixels();
     cnt++;

     for (int i = 0 ; i < pixels.length ; i++) {
     int x = i % width;
     int y = i / width;
     int xx = (x+X[(cnt+x)%X.length]+width-1) % width;
     int yy = (y+Y[(cnt+y)%Y.length]+height-1) % height;

     pixels[i] += color( brightness(pixels[i]) - brightness(pixels[yy*width+xx]) );
     pixels[i] += (int)random(-1,1);
     }
     updatePixels();


  // tint(255,5);
  //  image(g,4,4,width-8,height-8);
  // filter(DILATE);
  //filter(BLUR);

  //fill(0,5);
  //ellipse(width/2, height/2, 350, 350);
   */

  drawTc();
  textFont(txt);
  text("RT: "+millis()/1000.0+"s",width/2,height-37);
  dump();
}

/*
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

   if(minutes>59){
   minutes=0;
   hours++; 
   }

   if(hours>23){
   hours=0; 
   }


   tc = nf(hours,2)+":"+nf(minutes,2)+":"+nf(seconds,2)+":"+nf(fr,2);
   fill(0);
   noStroke();
   rect(width/2,35,80,20);
   fill(255);
   text(tc,width/2,40);

   }
 */
int c=0;

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
  text(tc,width/2,40);

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

