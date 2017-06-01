var Wid;
var Hei;
var blocks = new Array(16);
var winGame = false;
var loseGame = false;
var bombsLeft = 40;
var bombsLeftReal = 40;
var star = document.getElementById("stars.jpg");
function setup() {
  Wid = window.innerWidth;
  Hei = window.innerHeight;
  star.width = Wid;
  star.height = Hei;
  createCanvas(Wid, Hei);
  var xPlace = .1;
  var yPlace = .1;
  for (var i = 0; i < 16; i ++) {
    blocks[i] = new Array();
    for (var j = 0; j < 16; j ++) {
      var insert = new Block(false, 0, xPlace * Wid, yPlace * Hei);
      blocks[i].push(insert);
      yPlace += .05
    }
    yPlace = .1;
    xPlace += .05;
  }
  bombCreation();
}

function draw() {
  if (winGame == false && loseGame == false) {
    game();
  }
  if (winGame == true) {
    textSize(Wid * .1);
    fill(0);
    text("You Win!!", Wid * .25, Hei * .55);
  }
  if (loseGame == true) {
    textSize(Wid * .1);
    fill(0);
    text("Game Over", Wid * .25, Hei * .55);
  }
}

function game() {
  background(93, 165, 219);
  image(star,0,0);
  textSize(Wid * .03);
  fill(0);
  text("Thermal Detonator Sweeper", Wid * .1, Hei * .07);
  text("Detonators Left: " + bombsLeft, Wid * .65, Hei * .07);

  for (var i = 0; i < 16; i ++) {
    for (var j = 0; j < 16; j++) {
      fill(255);
      if (blocks[i][j].spotted == true) {
        fill(219, 45, 25);
      }
      if (blocks[i][j].clicked == true) {
        fill(207, 220, 220);
      }
      rect(blocks[i][j].xPos, blocks[i][j].yPos, Wid * .05, Hei * .05);

      if (blocks[i][j].clicked == true) {
        if (blocks[i][j].isBomb == false) {
          if (blocks[i][j].numberAdjacent != 0) {
            fill(0);
            text(blocks[i][j].numberAdjacent, blocks[i][j].xPos + .02 * Wid, blocks[i][j].yPos  +  .05 * Hei);
          }
        }
      }
    }
  }
  fill(0);
  rect(Wid*.1, Hei*.1, Wid*.001, Hei*.8);
  rect(Wid*.15, Hei*.1, Wid*.001, Hei*.8);
  rect(Wid*.2, Hei*.1, Wid*.001, Hei*.8);
  rect(Wid*.25, Hei*.1, Wid*.001, Hei*.8);
  rect(Wid*.3, Hei*.1, Wid*.001, Hei*.8);
  rect(Wid*.35, Hei*.1, Wid*.001, Hei*.8);
  rect(Wid*.4, Hei*.1, Wid*.001, Hei*.8);
  rect(Wid*.45, Hei*.1, Wid*.001, Hei*.8);
  rect(Wid*.5, Hei*.1, Wid*.001, Hei*.8);
  rect(Wid*.55, Hei*.1, Wid*.001, Hei*.8);
  rect(Wid*.6, Hei*.1, Wid*.001, Hei*.8);
  rect(Wid*.65, Hei*.1, Wid*.001, Hei*.8);
  rect(Wid*.7, Hei*.1, Wid*.001, Hei*.8);
  rect(Wid*.75, Hei*.1, Wid*.001, Hei*.8);
  rect(Wid*.8, Hei*.1, Wid*.001, Hei*.8);
  rect(Wid*.85, Hei*.1, Wid*.001, Hei*.8);
  rect(Wid*.9, Hei*.1, Wid*.001, Hei*.8);

  rect(Wid*.1, Hei*.1, Wid*.8, Wid*.001);
  rect(Wid*.1, Hei*.15, Wid*.8, Wid*.001);
  rect(Wid*.1, Hei*.2, Wid*.8, Wid*.001);
  rect(Wid*.1, Hei*.25, Wid*.8, Wid*.001);
  rect(Wid*.1, Hei*.3, Wid*.8, Wid*.001);
  rect(Wid*.1, Hei*.35, Wid*.8, Wid*.001);
  rect(Wid*.1, Hei*.4, Wid*.8, Wid*.001);
  rect(Wid*.1, Hei*.45, Wid*.8, Wid*.001);
  rect(Wid*.1, Hei*.5, Wid*.8, Wid*.001);
  rect(Wid*.1, Hei*.55, Wid*.8, Wid*.001);
  rect(Wid*.1, Hei*.6, Wid*.8, Wid*.001);
  rect(Wid*.1, Hei*.65, Wid*.8, Wid*.001);
  rect(Wid*.1, Hei*.7, Wid*.8, Wid*.001);
  rect(Wid*.1, Hei*.75, Wid*.8, Wid*.001);
  rect(Wid*.1, Hei*.8, Wid*.8, Wid*.001);
  rect(Wid*.1, Hei*.85, Wid*.8, Wid*.001);
  rect(Wid*.1, Hei*.9, Wid*.8, Wid*.001);
}

function bombCreation() {
  for (var i = 0; i < 40; i ++) {
    var row = Math.floor(Math.random() * 16);
    var col = Math.floor(Math.random() * 16);
    if (blocks[row][col].isBomb == true) {
      i--;
    }
    if (blocks[row][col].isBomb == false) {
      if (!row == 0) {
        blocks[row-1][col].numberAdjacent++;
      }
      if (row != 0 && col != 0) {
        blocks[row-1][col-1].numberAdjacent++;
      }
      if (col != 0) {
        blocks[row][col-1].numberAdjacent++;
      }
      if (row != 15) {
        blocks[row+1][col].numberAdjacent++;
      }
      if (row != 15 && col != 15) {
        blocks[row+1][col+1].numberAdjacent++;
      }
      if (col != 15) {
        blocks[row][col+1].numberAdjacent++;
      }
      if (row != 0 && col != 15) {
        blocks[row-1][col+1].numberAdjacent++;
      }
      if (row != 15 && col != 0) {
        blocks[row+1][col-1].numberAdjacent++;
      }
    }
    blocks[row][col].isBomb = true;
  }
}

function mousePressed() {
  for (var i = 0; i < 16; i ++) {
    for (var j = 0; j < 16; j++) {
      if (overRect(blocks[i][j].xPos, blocks[i][j].yPos, Wid * .05, Hei * .05)) {
        if (mouseButton == LEFT) {
          blocks[i][j].clicked = true;
          if (blocks[i][j].spotted == true) {
            bombsLeft ++;
          }
          if (blocks[i][j].isBomb == true) {
            loseGame = true;
          }
          if (blocks[i][j].numberAdjacent == 0) {
            search(i, j);
          }
        }
        if (mouseButton == RIGHT && blocks[i][j].clicked) {
          blocks[i][j].spotted = true;
          if (blocks[i][j].isBomb == true) {
            bombsLeftReal--;
          }
          bombsLeft --;
        }
      }
    }
  }
}

function overRect(x, y, w, h) { //Method that determines if the mouse is within a given rectangle
  if (mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h) {
    return true;
  } else {
    return false;
  }
}

function search(r, c) {

  blocks[r][c].clicked = true;
  blocks[r-1][c].clicked = true;


  if (blocks[r-1][c-1].isBomb == false) {
    blocks[r-1][c-1].clicked = true;
  }

  blocks[r][c-1].clicked = true;

  blocks[r+1][c].clicked = true;

  if (blocks[r+1][c+1].isBomb == false) {
    blocks[r+1][c+1].clicked = true;
  }

  blocks[r][c+1].clicked = true;

  if (blocks[r-1][c+1].isBomb == false) {
    blocks[r-1][c+1].clicked = true;
  }

  if (blocks[r+1][c-1].isBomb == false) {
    blocks[r+1][c-1].clicked = true;
  }

  if (blocks[r][c - 1].numberAdjacent == 0 && blocks[r][c - 1].isBomb == false && c != 0) {
    search(r, c - 1);
  }


  if (blocks[r - 1][c].numberAdjacent == 0 && blocks[r - 1][c].isBomb == false && r != 0) {
    search(r - 1, c);
  }

  if (blocks[r][c + 1].numberAdjacent == 0 && blocks[r][c + 1].isBomb == false && c != 15) {
    search(r, c + 1);
  }

  if (blocks[r + 1][c].numberAdjacent == 0 && blocks[r + 1][c].isBomb == false && r != 15) {
    search(r + 1, c);
  }
}


function Block(isBomb, numberAdjacent, xPos, yPos) {
  this.isBomb = isBomb;  
  this.numberAdjacent = numberAdjacent;
  this.xPos = xPos;
  this.yPos = yPos;
  this.clicked = "false";
  this.spotted = "false";
  this.adjacent = 0;
  this.changeExplosion = function (change) {
    this.isBomb = change;
  };

  this.findNumber = function (array) {
    var x = this.xPos - 1;
    var y = this.yPos - 1;
    if (xPos = 0) {
      x = 0;
    }
    if (y = 0) {
      y = 0;
    }
  };
}

function show_image(src, width, height, alt) {
  var img = document.createElement("stars.jpg");
  img.src = src;
  img.width = width;
  img.height = height;
  img.alt = alt;
  document.body.appendChild(img);
}