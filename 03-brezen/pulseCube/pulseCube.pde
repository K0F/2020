
Cube cube;

void settings(){
  System.setProperty("jogl.disable.openglcore", "false"); 
  size(640,480,OPENGL);
}
void setup(){
  cube = new Cube(8);
}


void draw(){
  background(0);

  pushMatrix();
  translate(width/2,height/2,0);
  rotateX(millis()/1000.0*TWO_PI/10.0);
  cube.draw();
  popMatrix();

}



class Cube{
  int dimmension;
  ArrayList neurons;
  float distance;
  float hL;

  Cube(int _dimm){

    distance = 10.0;
    neurons = new ArrayList();
    hL = (dimmension * distance) / 2.0;

    for(int iii = 0; iii < dimmension ; iii++){
      for(int ii = 0; ii < dimmension ; ii++){
        for(int i = 0; i < dimmension ; i++){
          neurons.add(new Neuron(this));
        }
      }
    }// end iii
  }

  void draw(){
    int index=0;
    for(int iii = 0; iii < dimmension ; iii++){
      for(int ii = 0; ii < dimmension ; ii++){
        for(int i = 0; i < dimmension ; i++){
          pushMatrix();
          Neuron tmp = (Neuron)neurons.get(index++);
          noFill();
          stroke(255,50);
          translate(i*distance-hL,ii*distance-hL,iii*distance-hL);
          box(10);
          popMatrix();
        }
      }
    }

  }


}


class Connection{
  Cube a,b;
  float weight;

  Connection(Cube _a,Cube _b){
    weight = 0.5;
    a=_a;
    b=_b;
  }
}

class Neuron{
  Cube parent;
  ArrayList connections;

  Neuron(Cube _parent){
    connections = new ArrayList();
    parent=_parent;
  }

}
