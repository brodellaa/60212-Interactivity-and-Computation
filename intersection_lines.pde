//////////LOGISTICS//////////

//single color
String[] canvasColor = {"pink"};
//multi-color --> uncomment next line and comment out previous line 
//float canvasColor = ['rgb(250, 90, 85)', 'rgb(253, 223, 92)', 'rgb(122, 206, 249)', 'rgb(239,239,236)']

/////line details/////
int numLines = 20;
int lineLength = 200;
//single color
String[] lineColor = {"blue"};
//multi-color --> uncomment next line and comment out previous line 
//float lineColor = ['rgb(242, 57, 59)', 'rgb(255, 168, 0)', 'rgb(0,0,0)'];
int lineWeight = 5;

/////intersection point details/////
String[] intColor = {"rgba(255,255,255,.70)"};
int intWidth = 30;
/////////////////////////////

void setup(){
  size(720,480);
  createCoordinates();
}

void mousePressed(){
  clear();
  createCoordinates();
}

void createCoordinates(){
  background(random(canvasColor));
  //clears line details so new set can be generated & lines wouldn't be on top of each other
  float angle = [];
  float x1 = [];
  float y1 = [];
  float x2 = [];
  float y2 = [];
  //loops the number of lines and stores each line's details: angle, x1, y1, x2, y2 in respective arrays
  for (var i = 0; i < numLines; i++) {
    angle.push(random(PI)); //orientation of line (angle) is randomly generated
    x1.append(int(random(0,canvasWidth))); //startpoint (x1) is randomly generated
    y1.append(int(random(0,canvasHeight))); //startpoint (y1) is randomly generated
    x2.append(cos(angle[i])*lineLength + x1[i]); //endpoint (x2) is determined through trig ensuring same hypotenuse length
    y2.append(sin(angle[i])*lineLength + y1[i]); //endpoint (y2) is determined through trig ensuring same hypotenuse length
    stroke(random(lineColor))
    strokeWeight(lineWeight)
    line(x1[i], y1[i], x2[i], y2[i]);
  }
  //nested loop checks for intersection between all lines and draws circle at intersection
  for (var i = 0; i < numLines; i++){
    for (var j = i+1; j < numLines; j++){
      //line 1
      var X1 = x1[i];
      var X2 = x2[i];
      var Y1 = y1[i];
      var Y2 = y2[i];
      //line2
      var X3 = x1[j];
      var X4 = x2[j];
      var Y3 = y1[j];
      var Y4 = y2[j];
      //using Paul Bourke's Formula 
      float d = ((Y4 - Y3)*(X2 - X1) - (X4 - X3)*(Y2 - Y1)); //denominator
      float ua = ((X4 - X3) * (Y1 - Y3) - (Y4 - Y3) * (X1 - X3)) / d;
      float ub = ((X2 - X1) * (Y1 - Y3) - (Y2 - Y1) * (X1 - X3)) / d;
      //points of intersection
      float X = X1 + ua*(X2 - X1);
      float Y = Y1 + ua*(Y2 - Y1);
      if (0 <= ua && ua <= 1 && 0 <= ub && ub <= 1){
        noStroke();
        fill(random(intColor));
        ellipse(X, Y, intWidth, intWidth);
      }
    }
  }
}

  



