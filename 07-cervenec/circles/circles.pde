
int PEOPLE = 26;
float SIZ = 300.0/(PEOPLE+0.0);

PVector angles[];
float AMAG = 10.0;
float TEMPO = 121.35/120.0/24.0;
float EASE = 100.0;
float ROZPAL = 10.0;

void setup(){
	size(800,600,OPENGL);
	angles = new PVector[PEOPLE];
	for(int i = 0 ; i < PEOPLE; i++){
	angles[i] = new PVector(0,0,0);
}
}


void draw(){

	noFill();
	stroke(0,120);

	background(233);
	float time = millis()/1000.0*TEMPO;
	pushMatrix();
	translate(width/2,height/2);
	for(int i = 0 ; i < PEOPLE; i++){
		float X = sin(noise(time,i/ROZPAL,0))*180*AMAG;
		float Y = sin(noise(time,0,i/ROZPAL))*180*AMAG;
		float Z = sin(noise(time,0,0))*180*AMAG;
		
		angles[i].x += (X-angles[i].x)/EASE;
		angles[i].y += (Y-angles[i].y)/EASE;
		angles[i].z += (Z-angles[i].z)/EASE;

		pushMatrix();
	//	rotateZ(radians(Z));
		rotateY(radians(X));
		rotateX(radians(Y));

		float R = (i+1) * SIZ;
		ellipse(0,0,R,R);
popMatrix();
	}
	popMatrix();


}
