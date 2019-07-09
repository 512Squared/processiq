var gridSize = 128; // number of squares in the grid
var boxSize = 512; // size of the box holding the grid
var startSelectX = 0;
var startSelectY = 0;
var endSelectX = 0;
var endSelectY = 0;


// building an array to control selectState

int [] selectState = {0,1,2}; // 0= layer select off, 1= layer select start point, 2= layer select completed
var layerSelect = selectState[0]; // default, layer select is off

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
    boxSelection();

    textSize(24);
   
    textAlign(CENTER);
    text("Layers", 93, 550);
    fill(146,146,146);
    rect(55, 560, 40, 40);
    fill(246,246,246);
    
    rect(95, 560, 40, 40);
    rect(135, 560, 40, 40);
    rect(175, 560, 40, 40);
    rect(215, 560, 40, 40);
    rect(255, 560, 40, 40);
    rect(295, 560, 40, 40);
    rect(335, 560, 40, 40);
    rect(375, 560, 40, 40);
    rect(415, 560, 40, 40);
    
    textSize(20);
    fill(#575757)
    text("1", 55, 573, 40, 40);
    text("2", 95, 573, 40, 40);
    text("3", 135, 573, 40, 40);
    text("4", 175, 573, 40, 40);
    text("5", 215, 573, 40, 40);
    text("6", 255, 573, 40, 40);
    text("7", 295, 573, 40, 40);
    text("8", 335, 573, 40, 40);
    text("9", 375, 573, 40, 40);
    text("10",414, 573, 40, 40);
   
    

}

void boxSelection() {

    switch (layerSelect) {
        case selectState[0]: 
            startSelectX = 0;
            startSelectY = 0;
            break;
        case selectState[1]:
            fill(#ffc899);
            rectMode(Processing.CORNER);
            translate(0,0);
            rect((floor((startSelectX - 128) / gridSize) * gridSize),(floor((startSelectY - 128) / gridSize) * gridSize),gridSize,gridSize);
            break;
        case selectState[2]:
            if (startSelectX < endSelectX && startSelectY < endSelectY) { // select box moving SE
                fill(#ffc899, 128);
                rectMode(Processing.CORNER);
                translate(0,0);
                rect((floor((startSelectX - 128) / gridSize) * gridSize),(floor((startSelectY - 128) / gridSize) * gridSize),((ceil((endSelectX - 128) / gridSize) * gridSize)) - ((floor((startSelectX - 128) / gridSize) * gridSize)),((ceil((endSelectY - 128) / gridSize) * gridSize)) - ((floor((startSelectY - 128) / gridSize) * gridSize)));
                break;
            }

        }
        
    }


void mouseClicked() {
    println("mouseClicked " + mouseX + "," + mouseY + "; grid=" + gridSize);
    // control buttons for grid size
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
        println("new grid = " + gridSize);
    }
    // select layer controls
    
    if (mouseX > 127 && mouseX < 640 && mouseY > 127 && mouseY < 640 ) { 
            
        switch (layerSelect) {
            case selectState[0]: 
                startSelectX = mouseX;
                startSelectY = mouseY;
                layerSelect = selectState[1];
                println("BoxSelection - selection is started; startSelectX: " + startSelectX + "; startSelectY: " + startSelectY + "; endSelectX: " + endSelectX + "; endSelectY: " + endSelectY);
                println("Mouse click. startSelect values captured");
                break;
            case selectState[1]:
                endSelectX = mouseX;
                endSelectY = mouseY;
                swap = 0;
                if (endSelectX < startSelectX){
                    swap = endSelectX;
                    endSelectX = startSelectX;
                    startSelectX = swap;
                }
                if (endSelectY < startSelectY){
                    swap = endSelectY;
                    endSelectY = startSelectY;
                    startSelectY = swap;
                }
                layerSelect = selectState[2];
                println("BoxSelection - selection is completed; startSelectX: " + startSelectX + "; startSelectY: " + startSelectY + "; endSelectX: " + endSelectX + "; endSelectY: " + endSelectY);
                println("Mouse click. endSelect values captured");
                break;
            case selectState[2]:
                layerSelect = selectState[0];
                startSelectX = 0;
                endSelectX = 0;
                startSelectY = 0;
                endSelectY = 0; 
                println("BoxSelection - selection switched off; startSelectX: " + startSelectX + "; startSelectY: " + startSelectY + "; endSelectX: " + endSelectX + "; endSelectY: " + endSelectY);
                println("Mouse click. Select set to off");
                break;
        }
    }
    if (mouseX < 127 || mouseX > 640 || mouseY < 127 || mouseY > 640 ) {
    layerSelect = selectState[0];
                startSelectX = 0;
                endSelectX = 0;
                startSelectY = 0;
                endSelectY = 0; 
    }
}

void boxOver() {
    fill(250,150,0);
    rectMode(Processing.CORNER);
    translate(128,128);
    if (mouseX > 127 && mouseX < 640 && mouseY > 127 && mouseY < 640 ){
        rect((floor((mouseX - 128) / gridSize) * gridSize),(floor((mouseY - 128) / gridSize) * gridSize),gridSize,gridSize);
        
    }
}


/* create layer from rectangle

values for rect need to be stored. 
variable to hold each layer needs to be stored
number of layers? Set number of layers? Button for adding layers?
Button for calling a layer into view
*/