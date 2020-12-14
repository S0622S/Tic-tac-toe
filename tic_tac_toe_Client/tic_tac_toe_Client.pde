//Clinet - 1's (o's)   ???????????

import processing.net.*;

color green = #C3FF68;  //our turn
color orange = #FF8300;  //waiting
boolean itsMyTurn = false;

int [][] grid;

Client myClient;

void setup() {
  size (600, 800);
  grid = new int[3][3];
  strokeWeight(3);
  textAlign(CENTER, CENTER);
  textSize(100);
  myClient = new Client(this, "127.0.0.1", 1234);
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

  //int row = 0;
  //int col = 0;
  //while (row < 3) {
  //  drawXO(row, col);
  //  col++;
  //  if (col == 3) {
  //    col = 0;
  //    row++;
  //  }
  //}
  
  for (int row = 0; row < 3; row++) {
    for (int col = 0; col < 3; col++)
      drawXO(row, col);
  }

  fill(0);
  text(mouseX + "," + mouseY, 300, 700);

  //receiving messages
  if (myClient.available() > 0) {  //myClients.available gives you information in numbers
    String incoming = myClient.readString();  
    int r = int(incoming.substring(0, 1));  
    int c = int(incoming.substring(2, 3));  
    grid[r][c] = 2;
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
  if (itsMyTurn && grid[row][col] == 0) {
    grid[row][col] = 1;
    myClient.write(row + "," + col);
    itsMyTurn = false;
  }
}
