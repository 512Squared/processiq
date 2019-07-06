var gridSize = 16;
var boxSize = 512;

void setup() {
    size(768, 768);
    background(100);
    frameRate(15);
    fill(255,0,0);
    rect(0,0,64,64);
    fill(0,255,0);
    rect(width-64, 0, 64, 64);
    fill(255);
    rect(width/2-64, 0, 128, 64);
}

void draw() {
    textSize(32);
    fill(255);
    rect(width/2-64, 0, 128, 64);
    fill(0)
    text(""+gridSize, width/2 - 16, 42);
    fill(255);
    rectMode(Processing.CENTER);
    var min = 128;
    var max = (min + boxSize);
    var x = min;
    var y = min;
    stroke(0);
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
    println("new grid = " + gridSize);
}