import peasy.*;
PeasyCam cam;

void setup(){

	size(400,300,OPENGL);
	cam = new PeasyCam(this,500);
}

void draw(){
	background(0);
	float r = 200;
	int total = 100;
	stroke(255,90);
	strokeWeight(3);
	for(int i = 0 ; i < total;i++){
		float lon = map(i,0,total,-PI,PI);
		for(int j = 0 ; j < total;j++){
			float lat = map(j,0,total,-HALF_PI,HALF_PI);

			float R = (noise(millis()/1000.0,(i-50.0)/100.0,(j-50.0)/100.0) * 20.0) + r;
			float x = R * sin(lon) * cos(lat);
			float y = R * sin(lon) * sin(lat);
			float z = R * cos(lon);

			point(x,y,z);
		}
	}
}
