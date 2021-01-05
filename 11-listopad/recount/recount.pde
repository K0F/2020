

Slot [] slots;
int siz = 5;
int num = 8;

void setup(){
	size(320,240);

	textFont(createFont("Semplice Regular",8,false));

	slots = new Slot[4];

	slots[0] = new Slot(width/2.0-(siz*num),100,num,false);
	slots[1] = new Slot(width/2.0,100,num,true);
	slots[2] = new Slot(width/2.0-(siz*num),110,num,false);
	slots[3] = new Slot(width/2.0,110,num,true);

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
	PVector pos,rot;
	boolean reverse;

	Slot(float x,float y,int _len,boolean _reverse){
		len = _len;
		reverse = _reverse;
		pos = new PVector(x,y);
		bytes = new String("76543210");
	}

	void draw(){
		for(int i = 0 ; i < bytes.length();i++){
			int index = reverse?i:bytes.length()-1-i;
		        fill((tan((millis()/1000.0*(((int)bytes.charAt(index)-48))/10.0)*TWO_PI)+1.0)*127.0 );
			text(bytes.charAt(index),i*siz+pos.x,pos.y);
		}
	}
}

