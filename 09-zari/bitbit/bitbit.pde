
BitBit bit;
int num = 13;
int siz = 6;
float tempo = 121.36/60.0;

void setup(){
	size(320,240);
	bit = new BitBit(num,0);
	textFont(createFont("Semplice Regular",8,false));
}


void draw(){
	background(0);

	pushMatrix();
	translate(width/2-(siz*num)/2.0,height/2-siz/2);	
	bit.draw();
	popMatrix();



}



class BitBit{
	int no;	
	int id;
	float slots[];
	char mem[][];

	BitBit(int _no,int _id){
		no= _no;
		id=_id;
		slots = new float[no];
		mem = new char[10][no];
	}

	void compute(){
		for(int i = 0 ; i < no;i++){
			slots[i] = (sin(millis()/1000.0*tempo*TWO_PI*noise(i+millis()/100.123/tempo))+1.0)/2.0;
		}
	}

	void draw(){
		for(int i = 0 ; i < no;i++){
			stroke(255);
			fill(255,slots[i]*255.0);
			rect(i*siz-1,0,siz,siz);
			fill(255);
			char ch = (char)(int)(slots[i]*64+64);
			mem[frameCount%(mem.length-1)][i] = ch;
			text(ch,i*siz,siz*2+4);
		}
		drawMem();
		compute();

	}

	void drawMem(){
		for(int c = 0 ; c < 10;c++){
			for(int i = 0 ; i < no;i++){
				text(mem[c][i],i*siz,siz*2+4+(c*(siz+2)+2));		

			}
		}	

	}
}
