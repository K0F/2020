

Axis [] tri;

void setup(){
	size(320,240,OPENGL);


}



void draw(){




}



class Axis{
	PVector heading;
	float mag[];
	float phase[];
	int slots[][];
	int res,dim;

	Axis(int _dim, int _res){
		res = _res;
		dim = _dim;
		slots = new int[dim][res];
		mag = new float[dim];
		phase = new float[dim];

		for(int i = 0 ; i < dim; i ++){
			mag[i] = 0.0;
			phase[i] = 0.0;
			for(int ii = 0 ; ii < res; ii ++){
				slots[i][ii] = 0;
			}		
		}

	}

}
