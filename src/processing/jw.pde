var gridSize = 16;

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
    fill(255);
    rectMode(Processing.CENTER);
    var boxSize = 512;
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

}