//////////LOGISTICS//////////

/////canvas details/////
var canvasWidth = 720;
var canvasHeight = 480;
//single color
//var canvasColor = ['pink'];
//multi-color --> uncomment next line and comment out previous line 
var canvasColor = ['rgb(250, 90, 85)', 'rgb(253, 223, 92)', 'rgb(122, 206, 249)', 'rgb(239,239,236)', 'rgb(255,177,190)'];

/////line details/////
var numLines = 12;
var lineLength = 400;
//single color
//var lineColor = ['blue'];
//multi-color --> uncomment next line and comment out previous line 
var lineColor = ['rgb(242, 57, 59)', 'rgb(255, 168, 0)', 'rgb(0,0,0)'];
var lineWeight = 5

/////intersection point details/////
var intColor = ['rgba(255,255,255,.70)'];
var intWidth = 30;
///////////////////////////

function setup(){
  createCanvas(canvasWidth,canvasHeight);
  createCoordinates();
}

function mousePressed(){
  clear();
  createCoordinates();
}

function createCoordinates(){
  background(random(canvasColor));
  //clears line details so new set can be generated & lines wouldn't be on top of each other
  var angle = [];
  var x1 = [];
  var y1 = [];
  var x2 = [];
  var y2 = [];
  //loops the number of lines and stores each line's details: angle, x1, y1, x2, y2 in respective arrays
  for (var i = 0; i < numLines; i++) {
    angle.push(random(PI)); //orientation of line (angle) is randomly generated
    x1.push(int(random(0,canvasWidth))); //startpoint (x1) is randomly generated
    y1.push(int(random(0,canvasHeight))); //startpoint (y1) is randomly generated
    x2.push(cos(angle[i])*lineLength + x1[i]); //endpoint (x2) is determined through trig ensuring same hypotenuse length
    y2.push(sin(angle[i])*lineLength + y1[i]); //endpoint (y2) is determined through trig ensuring same hypotenuse length
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
      var d = ((Y4 - Y3)*(X2 - X1) - (X4 - X3)*(Y2 - Y1)); //denominator
      var ua = ((X4 - X3) * (Y1 - Y3) - (Y4 - Y3) * (X1 - X3)) / d;
      var ub = ((X2 - X1) * (Y1 - Y3) - (Y2 - Y1) * (X1 - X3)) / d;
      //points of intersection
      var X = X1 + ua*(X2 - X1);
      var Y = Y1 + ua*(Y2 - Y1);
      if (0 <= ua && ua <= 1 && 0 <= ub && ub <= 1){
        noStroke();
        fill(random(intColor));
        ellipse(X, Y, intWidth, intWidth);
      }
    }
  }
}

  



