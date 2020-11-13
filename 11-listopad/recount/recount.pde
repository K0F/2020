


Slot [] slots;
int siz = 5;
int num = 8;

void setup(){
	size(320,240);

	textFont(createFont("Semplice Regular",8, false));

	slots = new Slot[4];

	slots[0] = new Slot(width-siz*num,100,num,false);
	slots[1] = new Slot(width+10+siz*num,100,num,true);
	slots[2] = new Slot(width-siz*num,200,num,false);
	slots[3] = new Slot(width+10+siz*num,200,num,true);

}

void draw(){
	background(0);

	for(int i = 0 ; i < slots.length;i++){
		slots[i].draw();

	}

}


class Slot{
	String bytes;
	int len;
	PVector pos;
	boolean reverse;

	Slot(float x,float y,int _len,boolean _reverse){
		len = _len;
		reverse = _reverse;
		pos = new PVector(x,y);
		bytes = new String("00000000");
	}
		void draw(){

			fill(255);
			for(int i = 0 ; i < bytes.length();i++){
				text(bytes.charAt(i),i*siz+pos.x,pos.y);
			}
		}

	}



