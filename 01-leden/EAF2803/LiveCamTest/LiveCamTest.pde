import gab.opencv.*;
import processing.video.*;
import java.awt.*;


import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;


Capture video;
OpenCV opencv;

void setup() {
  size(640, 480, P2D);
  video = new Capture(this, 640/4, 480/4, Capture.list()[0]);
  opencv = new OpenCV(this, 640/4, 480/4);

  oscP5 = new OscP5(this, 57120);

  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  myRemoteLocation = new NetAddress("127.0.0.1", 1234);

  video.start();
}

void draw() {
  //scale(1);
  opencv.loadImage(video);

  image(video, 0, 0 ,width,height);

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  Rectangle[] faces = opencv.detect();
//  println(faces.length);

  for (int i = 0; i < faces.length; i++) {
  //  println(faces[i].x + "," + faces[i].y);


    /* in the following different ways of creating osc messages are shown by example */
    OscMessage myMessage = new OscMessage("/tvar/"+i);

    myMessage.add(faces[i].x); /* add an int to the osc message */
    myMessage.add(faces[i].y); /* add an int to the osc message */

    /* send the message */
    oscP5.send(myMessage, myRemoteLocation); 

    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
}

void captureEvent(Capture c) {
  c.read();
}
