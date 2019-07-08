var gridSize = 256; // number of squares in the grid
var boxSize = 512; // size of the box holding the grid
var mouseClick = false; // set mouse click event listener
var selectX = 0;
var selectY = 0;

void setup() {
    size(768, 768);
    frameRate(30);
}

void draw() {
    background(100);
    fill(255,0,0);
    rect(0,0,64,64);
    fill(0,255,0);
    rect(width-64, 0, 64, 64);
    fill(255);
    rect(width/2-64, 0, 128, 64);
    textSize(32);
    fill(255);
    rect(width/2-64, 0, 128, 64);
    fill(0)
    textAlign(CENTER);
    text((boxSize/gridSize)*(boxSize/gridSize), width/2, 42);
    fill(255);
    rectMode(Processing.CENTER);
    var min = 128;
    var max = (min + boxSize);
    var x = min;
    var y = min;
    stroke(96);
    rect(128,128,boxSize, boxSize);
    while (y < max) {
        x = min;
        line(x, y, max, y);
        while (x < max) {
            line(x, y, x, max);
            x += gridSize;
        }
        y += gridSize;
    }
    boxOver();
    if (mouseClick == true) {
        boxSelection();
    }
    else if (mouseClick == false) {
    }

}

void boxSelection (){
    if (mouseClick == true ){
        selectState = 1; // 3 select states: no select, selectStart, and selectMade
        fill(#ffc899);
        rectMode(Processing.CORNER);
        translate(0,0);
        rect((floor((selectX - 128) / gridSize) * gridSize),(floor((selectY - 128) / gridSize) * gridSize),gridSize,gridSize);
    }    
    if (mouseClick == false) {
        selectX = 0;
        selectY = 0;

    }
    
}

void mouseClicked() {
    println("mouseClicked " + mouseX + "," + mouseY + "; grid=" + gridSize);
   
    if (mouseY < 64) {
        if (mouseX < 64) {
            if (gridSize > 1) {
                gridSize = gridSize / 2;
            }
        } else if (mouseX > (width-64)) {
            if (gridSize < boxSize / 2) {
                gridSize = gridSize * 2;
            }
        }
    }
    if (mouseX > 127 && mouseX < 640 && mouseY > 127 && mouseY < 640 ){
        println("mouse click = true");
    }
    
    if (mouseX > 127 && mouseX < 640 && mouseY > 127 && mouseY < 640 ) {
        if (mouseClick == false) {
        selectX = mouseX;
        selectY = mouseY;
        mouseClick = true;
        }
        else {
            mouseClick = false;
        }
        }
    println("new grid = " + gridSize);
    
}

void boxOver() {
    fill(250,150,0);
    rectMode(Processing.CORNER);
    translate(128,128);
    if (mouseX > 127 && mouseX < 640 && mouseY > 127 && mouseY < 640 ){
        rect((floor((mouseX - 128) / gridSize) * gridSize),(floor((mouseY - 128) / gridSize) * gridSize),gridSize,gridSize);
        
    }
}


