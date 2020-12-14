//Server (sends x's (2))  ???????

import processing.net.*;

color green = #C3FF68;
color orange = #FF8300;
boolean itsMyTurn = true;

int [][] grid;

Server myServer;


void setup() {
  size (600, 800);
  grid = new int[3][3];
  strokeWeight(3);
  textAlign(CENTER, CENTER);
  textSize(100);
  myServer = new Server(this, 1234);
}


void draw() {
  
  if (itsMyTurn) {
  background(green);
  } else {
   background(orange); 
  }

  stroke(0);
  line(200, 0, 200, 600);
  line(400, 0, 400, 600);
  line(0, 200, 600, 200);
  line(0, 400, 600, 400);

  for(int row = 0; row < 3; row++){
    for(int col = 0; col < 3; col++)
    drawXO(row, col);
  }


  fill(0);
  text(mouseX + "," + mouseY, 300, 700);
  
  Client myclient = myServer.available();            
  if (myclient != null) {
    String incoming = myclient.readString();
    int r = int(incoming.substring(0, 1));
    int c = int(incoming.substring(2,3));
    grid[r][c] = 1;
    itsMyTurn = true;
  }
}



void drawXO(int row, int col) {
  pushMatrix();
  translate(row*200, col*200);
  if (grid[row][col] == 1) {
    fill(255, 0);
    ellipse(100, 100, 180, 180);
  } else if (grid[row][col] == 2) {
    line (20, 20, 180, 180);
    line (180, 20, 20, 180);
  }
  popMatrix();
}



void mouseReleased() {

  int row = mouseX/200;
  int col = mouseY/200;
  if (itsMyTurn && grid[row][col] == 0) {  //doesnt have to be itsMyTurn == true because it is already in boolean
    myServer.write(row + "," + col);
    grid[row][col] = 2;
    println(row + "," + col);
    itsMyTurn = false;
  }
  
  
}
