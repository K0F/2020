
int siz = 10;
int bits = 24;
Neuron [] neurons;

void setup(){
	size(640,480,P2D);
	neurons = new Neuron[bits];

	for(int i = 0 ; i < bits;i++){
		neurons[i] = new Neuron(
				110+(i),
				i/(bits+0.0),
				i*siz+width/2.0-(bits*siz/2.0),
				height/2.0-siz/2.0
				);
	}
}


void draw(){

	background(0);
	for(int i = 0 ; i < bits;i++){
		neurons[i].draw();
	}	

}


class Neuron{
	float time;
	float tempo;
	float phase;
	PVector pos;

	Neuron(float _tempo,float _phase,float _x,float _y){
		tempo = _tempo / 120.0;
		phase = _phase * PI * 2.0;
		pos=new PVector(_x,_y);

	}

	void draw(){
		advance();
		rect(pos.x,pos.y,siz,siz);

	}

	void advance(){
		time = (millis()/1000.0 * PI * 2.0 )*tempo+phase;
		fill(((sin(time)+1.0)/2.0)*255);

	}

}
