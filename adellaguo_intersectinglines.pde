//////////LOGISTICS//////////

/////line details/////
int numLines = 20;
int lineLength = 400;
int lineWeight = 1;

/////intersection point details/////
int intWidth = 15;
/////////////////////////////

void setup(){
  size(720,480);
  createCoordinates();
}

void mousePressed(){
  print("hi");
  clear();
  createCoordinates();
}


void createCoordinates(){
  background(255, 177, 190);
  //clears line details so new set can be generated & lines wouldn't be on top of each other
  float[] angle = {};
  float[] x1 = {};
  float[] y1 = {};
  float[] x2 = {};
  float[] y2 = {};
  //loops the number of lines and stores each line's details: angle, x1, y1, x2, y2 in respective arrays
  for (int i = 0; i < numLines; i++) {
    angle = append(angle, random(PI)); //orientation of line (angle) is randomly generated
    x1 = append(x1,(int(random(0,720)))); //startpoint (x1) is randomly generated
    y1 = append(y1, (int(random(0,480)))); //startpoint (y1) is randomly generated
    x2 = append(x2, (cos(angle[i])*lineLength + x1[i])); //endpoint (x2) is determined through trig ensuring same hypotenuse length
    y2 = append(y2, (sin(angle[i])*lineLength + y1[i])); //endpoint (y2) is determined through trig ensuring same hypotenuse length
    stroke(0, 0, 255);
    strokeWeight(lineWeight);
    line(x1[i], y1[i], x2[i], y2[i]);
  }
  //nested loop checks for intersection between all lines and draws circle at intersection
  for (int i = 0; i < numLines; i++){
    for (int j = i+1; j < numLines; j++){
      //line 1
      float X1 = x1[i];
      float X2 = x2[i];
      float Y1 = y1[i];
      float Y2 = y2[i];
      //line2
      float X3 = x1[j];
      float X4 = x2[j];
      float Y3 = y1[j];
      float Y4 = y2[j];
      //using Paul Bourke's Formula 
      float d = ((Y4 - Y3)*(X2 - X1) - (X4 - X3)*(Y2 - Y1)); //denominator
      float ua = ((X4 - X3) * (Y1 - Y3) - (Y4 - Y3) * (X1 - X3)) / d;
      float ub = ((X2 - X1) * (Y1 - Y3) - (Y2 - Y1) * (X1 - X3)) / d;
      //points of intersection
      float X = X1 + ua*(X2 - X1);
      float Y = Y1 + ua*(Y2 - Y1);
      if (0 <= ua && ua <= 1 && 0 <= ub && ub <= 1){
        noStroke();
        fill(255,255,255);
        ellipse(X, Y, intWidth, intWidth);
      }
    }
  }
}


  