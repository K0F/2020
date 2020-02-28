

class Recorder{
  int id;
  boolean isRecording;
  boolean isPlaying;
  ArrayList vals;

  Recorder(int id){
    vals = new ArrayList();
    isRecording = true;
  }

  void add(float x,float y,float z){
    vals.add(new PVector(x,y,z));
  }



}
