import java.util.Collections;

String [] raw;
ArrayList countries;
float minval = 0.0;
float maxval = 0.0;

float maxvals[] = {10000.0,100000.0};
float mag = 480.0;
float scaleX = 1;
String filename = "replaceme";
int nejdelsi = 0;

void setup(){
  size(1920,1080);
  mag = height;
  raw = loadStrings(filename);
  //println(raw.length);
  countries = new ArrayList();

  textFont(createFont("Semplice Regular",8));

  String name = "";
  int delka = 0;
  for(int i = 1 ; i < raw.length ; i++){
    String radek[] = splitTokens(raw[i],",");
    // println(radek.length);
    if(!name.equals(radek[6])){
      name = radek[6];
      countries.add(new Country(radek[6]));
      Country tmp = (Country)countries.get(countries.size()-1);
      tmp.addEntry(radek[0],parseInt(radek[4]),parseInt(radek[5]));
      delka = 0;
    }else{
      Country tmp = (Country)countries.get(countries.size()-1);
      tmp.addEntry(radek[0],parseInt(radek[4]),parseInt(radek[5]));
      delka++;
    }
    if(delka>nejdelsi){
      nejdelsi = delka;
    }
  }
  scaleX = width/(0.0+nejdelsi);

  for(int i = 0; i < countries.size();i++){
    Country tmp = (Country)countries.get(i);
    tmp.reverse();
  }
  noLoop();
}

void draw(){
  for(int ii = 0 ; ii < maxvals.length;ii++){
    maxval = maxvals[ii];
    background(250);
    stroke(0,15);
    fill(0);
    for(int i = 0; i < nejdelsi;i++){
      float x = i*scaleX;
      line(x,0,x,height);
      text((i-nejdelsi+1)+"D",x,10);
    }

    for(int i =0 ; i < countries.size();i++){
      Country tmp = (Country)countries.get(i);
      tmp.draw();
    }
    save("output/"+splitTokens(filename,".")[0]+"_"+(int)maxval+".png");
  }
  exit();
}


class Country{
  String nazev;
  ArrayList entries;

  Country(String _nazev){
    nazev=""+_nazev;
    println("new country " + nazev);
    entries = new ArrayList();
  }

  void addEntry(String _date,int _nakazenych, int _smrti){
    println("adding entry "+_date+" "+_nakazenych+" "+_smrti);
    entries.add(new Entry(this,entries.size()-1,_date,_nakazenych,_smrti));
  }

  void reverse(){
    Collections.reverse(entries);
  }

  void draw(){
    stroke(0,50);
    noFill();
    beginShape();
    float val = 0;
    int total = 0;
    for(int i = 0; i < entries.size();i++){
      Entry tmp = (Entry)entries.get(i);
      val += tmp.mnakazenych;
      total += tmp.nakazenych;
      vertex((width-entries.size()*scaleX)+i*scaleX,height-val);
    }
    endShape();
    int abz = ((int)nazev.charAt(0)-48)*10;
    String legenda = nazev+" "+total+" infected";
    float le = textWidth(legenda);
    line(width,height-val,width-abz-le,height-val); 
    fill(0,120);
    textAlign(RIGHT);
    text(legenda,width-abz,height-val-2);
  }
}

class Entry{
  Country parent;
  String zkratka;
  String date;
  int id;
  float smrti,nakazenych;
  float msmrti,mnakazenych;
  float linsmrt,linnaka;
  float logsmrt,lognaka;

  Entry(Country _parent,int _id,String _date, int _nakazenych, int _smrti){
    parent=_parent;
    date=_date+"";
    id = _id;

    nakazenych = (float)_nakazenych;
    smrti = (float)_smrti;
    mnakazenych = map(nakazenych,minval,maxval,0,mag);//pow(map(nakazenych,minval,maxval,0,mag),0.25);
    msmrti = map(smrti,minval,maxval,0,mag);//pow(map(smrti,minval,maxval,0,mag),0.25);
    /*
       linnaka = (float)linMap.getMappedValueFor((float)nakazenych);
       linsmrt = (float)linMap.getMappedValueFor((float)smrti);

       lognaka = (1.0/(float)logMap.getMappedValueFor((float)nakazenych+1.0))*id;
       logsmrt = (1.0/(float)logMap.getMappedValueFor((float)smrti+1.0))*id;
     */
  }
}
