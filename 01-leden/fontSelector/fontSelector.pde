


String [] list;
int siz = 12;
PFont def,current;
int sel = 0;

void setup(){
  size(720,576);
  list = PFont.list();
  current = createFont(list[sel],siz);
}


void draw(){
  background(0);
  textFont(current);
  text(list[sel]+" "+siz+" 00:01:02:03",30,height/2);

}
void keyPressed(){
  if(keyCode==RIGHT){
    sel++;
    if(sel>list.length-1)
      sel=0;
  }

  if(keyCode==LEFT){

    sel--;
    if(sel<1)
      sel=list.length-1;
  }


  if(keyCode==UP){
    siz++;
  }

  if(keyCode==DOWN){
    siz--;
  }

  current = createFont(list[sel],siz);
}
