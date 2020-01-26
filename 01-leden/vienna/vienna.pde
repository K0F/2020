float tempo = 121.35;
float divisor = 0.5;
float x,y,amx,amy;

void setup(){
  size(720,576,OPENGL);
}

void draw(){
  background(255);
  float x = sin(tempo*TWO_PI/divisor)*amx;
  float y = noise((tempo*TWO_PI/divisor)*amx,10,10);
  ellipse(x,y,137,137);  
}
