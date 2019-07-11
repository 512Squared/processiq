var gridSize = 128; // number of squares in the grid
var boxSize = 512; // size of the box holding the grid
float startSelectX = 0;
float startSelectY = 0;
float endSelectX = 0;
float endSelectY = 0;
color c = color(255);

// building an array to control selectState

int [] selectState = {0,1,2}; // 0= layer select off, 1= layer select start point, 2= layer select completed
var layerSelect = selectState[0]; // default, layer select is off

// building objects for the layer slots

LayerSlot slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9, slot10;


void setup() {
    size(768, 768);
    frameRate(30);
    slot1 = new LayerSlot("1",c,183,690,40,40,false);
    slot2 = new LayerSlot("2",c,223,690,40,40,false);
    slot3 = new LayerSlot("3",c,263,690,40,40,false);
    slot4 = new LayerSlot("4",c,303,690,40,40,false);
    slot5 = new LayerSlot("5",c,343,690,40,40,false);
    slot6 = new LayerSlot("6",c,383,690,40,40,false);
    slot7 = new LayerSlot("7",c,423,690,40,40,false);
    slot8 = new LayerSlot("8",c,463,690,40,40,false);
    slot9 = new LayerSlot("9",c,503,690,40,40,false);
    slot10 = new LayerSlot("10",c,543,690,40,40,false);

}

void draw() {
    background(100);
    mainGrid();
    layers();  // function for selecting layers
    
    // draw layer slots. 
    slot1.display();
    slot2.display();
    slot3.display();
    slot4.display();
    slot5.display();
    slot6.display();
    slot7.display();
    slot8.display();
    slot9.display();
    slot10.display();
    boxOver(); // rollover to prompt layer select
    


}

class LayerSlot {
    String slotNumber;
    color c = color (255);
    float slotX, slotY, slotW, slotH;
    boolean status = false;
    void display() {
        fill(c);   
        rect(slotX,slotY,slotW,slotH);
        textSize(20);
        fill(#575757)
        text(slotNumber, slotX, (slotY + 13), slotW, slotH);
    }
}

void layers() {

    switch (layerSelect) {
        case selectState[0]: // no select
            startSelectX = 0;
            startSelectY = 0;
            break;
        case selectState[1]: // get 1st x,y co-ordinates 
            fill(#ffc899);
            rectMode(Processing.CORNER);
            translate(0,0);
            rect((floor((startSelectX - 128) / gridSize) * gridSize),(floor((startSelectY - 128) / gridSize) * gridSize),gridSize,gridSize);
            break;
        case selectState[2]: // get 2nd x,y co-ordinates and calculate layer size
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
    //println("mouseClicked " + mouseX + "," + mouseY + "; grid=" + gridSize);
    // control buttons for grid size
    if (mouseY < 64) { 
        if (mouseX < 64) {
            if (gridSize > 1) {
                gridSize = gridSize / 2;
                println("new grid = " + gridSize);
            }
        } else if (mouseX > (width-64)) {
            if (gridSize < boxSize / 2) {
                gridSize = gridSize * 2;
                println("new grid = " + gridSize);
            }
        }
        
    }

    // console log reporting - click on centre box

    if (mouseX < width/2+64 && mouseX > width/2-64 && mouseY < 64) {
        println("Console log.");
        println("SlotX: " + slot1.slotX + ". SlotY: " + slot1.slotY + ". Status: " + slot1.status + ". SlotWidth: " + slot1.slotW + ". SlotHeight: " + slot1.slotH +  ". Color: " + slot1.c);
    }


    // select layer controls
    
    if (mouseX > 127 && mouseX < 640 && mouseY > 127 && mouseY < 640 ) { 
            
        switch (layerSelect) {
            case selectState[0]: 
                startSelectX = mouseX;
                startSelectY = mouseY;
                layerSelect = selectState[1];
                println("Mouse click. First (x,y) values captured");
                println("Layers - selection is started; startSelectX: " + startSelectX + "; startSelectY: " + startSelectY + "; endSelectX: " + endSelectX + "; endSelectY: " + endSelectY);
                break;
            case selectState[1]:
                endSelectX = mouseX;
                endSelectY = mouseY;
                swap = 0;
                println("Mouse click. Second (x,y) values captured");
                if (endSelectX < startSelectX){
                    swap = endSelectX;
                    endSelectX = startSelectX;
                    startSelectX = swap;
                    println("X values swapped");
                }
                if (endSelectY < startSelectY){
                    swap = endSelectY;
                    endSelectY = startSelectY;
                    startSelectY = swap;
                    println("Y values swapped");
                }
                layerSelect = selectState[2];
                println("Layers - layer selection is completed");
                println("Layer co-ordinates are startSelectX: " + startSelectX + "; startSelectY: " + startSelectY + "; endSelectX: " + endSelectX + "; endSelectY: " + endSelectY);
                break;
            case selectState[2]:
                layerSelect = selectState[0];
                startSelectX = 0;
                endSelectX = 0;
                startSelectY = 0;
                endSelectY = 0; 
                println("Mouse click. Layer select set to off");
                println("Layers - selection switched off; startSelectX: " + startSelectX + "; startSelectY: " + startSelectY + "; endSelectX: " + endSelectX + "; endSelectY: " + endSelectY);
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
    
    if (mouseX > 223 && mouseX < 263 && mouseY >688 && mouseY < 728) { 
            // fill(190);
            // rect(0, 0, 440, 440);
            println("Layers box click activated");
    }
}
void boxOver() {
    fill(250,150,0);
    rectMode(Processing.CORNER);
    translate(128,128);
    if (mouseX > 127 && mouseX < 640 && mouseY > 127 && mouseY < 640 ){
        rect((floor((mouseX - 128) / gridSize) * gridSize),(floor((mouseY - 128) / gridSize) * gridSize),gridSize,gridSize);
    }
    if (mouseX > 183 && mouseX < 223 && mouseY > 690 && mouseY < 730) { // slot1
        c = 140;    
    }
    // if (mouseX > 223 && mouseX < 263 && mouseY > 690 && mouseY < 730) { // slot1
    //     slotSelectC = 140;    
    // }
    // if (mouseX > 263 && mouseX < 303 && mouseY > 690 && mouseY < 730) { // slot1
    //     slotSelectC = 140;    
    // }
    // if (mouseX > 303 && mouseX < 343 && mouseY > 690 && mouseY < 730) { // slot1
    //     slotSelectC = 140;    
    // }
    // if (mouseX > 343 && mouseX < 383 && mouseY > 690 && mouseY < 730) { // slot1
    //     slotSelectC = 140;    
    // }
    // if (mouseX > 383 && mouseX < 423 && mouseY > 690 && mouseY < 730) { // slot1
    //     slotSelectC = 140;    
    // }
    // if (mouseX > 423 && mouseX < 463 && mouseY > 690 && mouseY < 730) { // slot1
    //     slotSelectC = 140;    
    // }
    // if (mouseX > 463 && mouseX < 503 && mouseY > 690 && mouseY < 730) { // slot1
    //     slotSelectC = 140;    
    // }
    // if (mouseX > 503 && mouseX < 543 && mouseY > 690 && mouseY < 730) { // slot1
    //     slotSelectC = 140;    
    // }
    // if (mouseX > 543 && mouseX < 583 && mouseY > 690 && mouseY < 730) { // slot1
    //     slotSelectC = 140;    
    // }
    else {
        c = 190;
    }
}
void mainGrid() {
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
    textSize(24);
    fill(246, 150, 0);
    textAlign(CENTER);
    text("Layers", 220, 680);
}
void slotSelectFormat(){
    line(183, 690, 223, 690);
    stroke(20);
    line(223, 690, 223, 730);
    stroke(255);
    line(223, 730, 183, 730);
}


/* create layer from rectangle
  values for rect need to be stored. 
variable to hold each layer needs to be stored
number of layers? Set number of layers? Button for adding layers?
Button for calling a layer into view
*/