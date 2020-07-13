
int siz = 5;
int bits = 512;
Neuron [] neurons;
float side;
float res = 10.0;

void setup(){
	size(320,240,P2D);
	//fullScreen();
	neurons = new Neuron[bits];

	float x = 0;
	float y = 0;
	side = sqrt((float)bits);
	//println(side);
	for(int i = 0 ; i < bits;i++){
		float detune = noise(i/res);
		neurons[i] = new Neuron(
				121.35 + detune,
 				detune,
				//i*siz+width/2.0-(bits*siz/2.0),
				//height/2.0-siz/2.0
				x,
				y
				);

		if(x > side*siz){
			x=0;
			y+=siz;
		};

		x+=siz;
	}
}


void draw(){
	background(0);
	pushMatrix();
	translate(width/2-side/2,height/2-side/2);	
	for(int i = 0 ; i < bits;i++){
		neurons[i].draw();
	}	
	popMatrix();
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
