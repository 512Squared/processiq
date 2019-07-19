/* @pjs preload="images/save.png,images/clear.png,images/saveHidden.png,images/clearOn.png,images/saveShow.png"; */

var gridSize = 128; // number of squares in the grid
var boxSize = 512; // size of the box holding the grid
float startSelectX = 0; // layer start x co-ordinates
float startSelectY = 0; // layer start y co-ordinates
float endSelectX = 0; // layer end x co-ordinates
float endSelectY = 0; // layer start y co-ordinates
int pageSize = 1080; // size of canvas
float offset = floor((pageSize - boxSize)/2); // centers grid and related elements
boolean readyToSave = false;  // switch for controlling when to pull new layer values

// building an array to control selectState

int [] selectState = {0,1,2}; // 0= layer select off, 1= start point, 2= end point
var layerSelect = selectState[0]; // layerSelect switch controls layer select phases

Slot s1, s2, s3, s4, s5, s6, s7, s8, s9, s10; // slots to save layers

ControlPanel c1,c2; // command buttons: save, clear

PImage save = loadImage("images/save.png");
PImage saveHidden = loadImage("images/saveHidden.png");
PImage saveShow = loadImage("images/saveShow.png");
PImage clearOn = loadImage("images/clearOn.png");
PImage clear = loadImage("images/clear.png"); // hover image


void setup() {
    size(pageSize, pageSize);
    frameRate(30)
    setupControls();
}

void draw() {
    
    background(100);
    mainGrid();
    layers(); 
    drawSlots();
    boxOver(); 
}

    // switches for layerSet shown below: 
    // if (selectState[2] && s*.slotOn == true && s*.layerSet == true && c1.saveVisible == true)

    // layer draw is found in Slots.display
    // cPanel actions found in mouseClicked 
    // cPanel draw found in ControlPanel.display

class Slot 

{
    // display slots
    String slotNum;
    color sC;
    int sX, sY, sW, sH;
    boolean saveVisible;
    boolean slotOn;
    
    // store layer values in slots
    int layX,layY,layW,layH;
    boolean layerSet; 
    
    Slot(String slotnum,color slotcol,int slotx,int sloty,int slotw, int sloth,boolean slotsavevisible,boolean slotstate,int layerX,int layerY,int layerW,int layerH,boolean slotLayerSet) 
    
    {
        
        slotNum = slotnum;
        sC = slotcol;
        sX = slotx;
        sY = sloty;
        sW = slotw;
        sH = sloth;
        saveVisible = slotsavevisible;
        slotOn = slotstate;
        layX = layerX;
        layY = layerY;
        layW = layerW;
        layH = layerH;
        layerSet = slotLayerSet;
            
    }

    void gradientRect(int x, int y, int w, int h, color gradC1, color gradC2) 
    
    {
        beginShape();
        fill(gradC1);
        vertex(x,y);
        vertex(x,y+h);
        fill(gradC2);
        vertex(x+w,y+h);
        vertex(x+w,y);
        endShape();
    }
    
    void display() 
    
    { // display slots

        if (slotOn == true) // draw active slot (no data, so class level)
        
        {
            // fill(59,70,84);
            gradC1 = (59,70,84);
            gradC2 = (73,87,105);
            gradientRect(sX,sY,sW,sH,gradC1,gradC2);
            textSize(20);
            textAlign(CENTER);
            fill(#fefefe);
            text(slotNum, sX, (sY + 14), sW, sH);
            
            stroke(150,164,181);
            line(sX+1,sY+39,sX+39,sY+39);
            line(sX+39,sY+1,sX+39,sY+39);

            stroke(120);
            line(sX+2,sY+38,sX+38,sY+38);
            line(sX+38,sY+2,sX+38,sY+38);
            
            stroke(15);
            line(sX+1,sY+1,sX+1,sY+39);
            line(sX+1,sY+1,sX+39,sY+1);
            
            stroke(27,30,33);
            line(sX+2,sY+2,sX+2,sY+38);
            line(sX+2,sY+2,sX+38,sY+2);
            stroke(96);

        } 
        
        if (slotOn == false) // draw inactive slot (no data, so class level)
        
        {
            fill(sC);   
            rect(sX,sY,sW,sH);
            textSize(20);
            textAlign(CENTER);
            fill(#575757);
            text(slotNum, sX, (sY + 13), sW, sH);
        }

        if (mouseX > sX && mouseX < sX+40 && mouseY > sY && mouseY < sY+40 && slotOn == false) // slot rollovers
        
        { // draw slot button rollover (no data, so class level)
            fill(255);   
            rect(sX,sY,sW,sH);
            stroke(150,164,181);
            line(sX+1,sY+39,sX+39,sY+39);
            line(sX+39,sY+1,sX+39,sY+39);
            
            stroke(15);
            line(sX+1,sY+1,sX+1,sY+39);
            line(sX+1,sY+1,sX+39,sY+1);
            
            stroke(27,30,33);
            line(sX+2,sY+2,sX+2,sY+38);
            line(sX+2,sY+2,sX+38,sY+2);


            stroke(96);
            textSize(20);
            textAlign(CENTER);
            fill(#575757);
            text(slotNum, sX, (sY + 14), sW, sH);


        
            if (mousePressed == true && slotOn == false) // mousepressed and slot is off
        
            {
                gradC1 = (59,70,84);
                gradC2 = (73,87,105);
                gradientRect(sX,sY,sW,sH,gradC1,gradC2);
                textSize(20);
                textAlign(CENTER);
                fill(#f2f2f2);
                text(slotNum, sX, (sY + 14), sW, sH);
                stroke(150,164,181);
                line(sX+1,sY+39,sX+39,sY+39);
                line(sX+39,sY+1,sX+39,sY+39);
            
                stroke(15);
                line(sX+1,sY+1,sX+1,sY+39);
                line(sX+1,sY+1,sX+39,sY+1);
            
                stroke(27,30,33);
                line(sX+2,sY+2,sX+2,sY+38);
                line(sX+2,sY+2,sX+38,sY+2);

                stroke(96);
            }



        }

        slotLayerShowHideGridDraw(); // (data stored, unique methods s1-s10 required)

    }
}

class ControlPanel // cPanel

{

    int cX,cY,cW,cH; // controlPanel button co-ordinates
    boolean cSaved; // layer save 
    boolean saveVisible; // save visibility

    ControlPanel(int controlX, int controlY,int controlW,int controlH, boolean controlSave, boolean controlSaveShownIcon) {
        cX = controlX;
        cY = controlY;
        cW = controlW;
        cH = controlH;
        cSaved = controlSave; // save is active, i.e. icon showing, layerSet = true etc. 
        saveVisible = controlSaveShownIcon; // save is visible
    }



    void display()  { // display controlPanel buttons


        // buttons set on or off
        
        if (c2.cSaved == false && c1.cSaved == true) 
        
        { // draw clear icon for visible save
            fill(255); 
            rect(c2.cX,c2.cY,c2.cW,c2.cH);
            image(clear,c2.cX+5,c2.cY+5,30,30);
        }

        if (c1.cSaved == false && layerSelect == selectState[2])
        
        { // save is off
            fill(255);   
            rect(c1.cX,c1.cY,c1.cW,c1.cH);
            image(save,c1.cX+5,c1.cY+5,30,30); 
        }
        
        saveShowHideButtonDraw();

        // hover draws for buttons
        
        if (mouseX > c2.cX && mouseX < c2.cX+40 && mouseY > c2.cY && mouseY < c2.cY+40 && c1.cSaved == true) 
        
        { // hover draw for clear button
        
            stroke(150,164,181);
            line(c2.cX+1,c2.cY+39,c2.cX+39,c2.cY+39);
            line(c2.cX+39,c2.cY+1,c2.cX+39,c2.cY+39);
            
            stroke(15);
            line(c2.cX+1,c2.cY+1,c2.cX+1,c2.cY+39);
            stroke(44,49,54);
            line(c2.cX+2,c2.cY+2,c2.cX+2,c2.cY+38);
           
            line(c2.cX+1,c2.cY+1,c2.cX+39,c2.cY+1);
            line(c2.cX+2,c2.cY+2,c2.cX+38,c2.cY+2);
            stroke(150,164,181);
            line(c2.cX+1,c2.cY+39,c2.cX+39,c2.cY+39);
            line(c2.cX+39,c2.cY+1,c2.cX+39,c2.cY+39);
            stroke(27,30,33);
            line(c2.cX+1,c2.cY+1,c2.cX+1,c2.cY+39);
            line(c2.cX+1,c2.cY+1,c2.cX+39,c2.cY+1);
            
            stroke(255);
            fill(255);
            rect(c2.cX+5,c2.cY+5,30,30); 
            image(clear,c2.cX+5,c2.cY+5,30,30);
            stroke(96);

        }
        
        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && c1.cSaved == false && layerSelect == selectState[2]) 
        
        { // draw save hover before first click to 'save layer'
          
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(255);
            fill(255);
            rect(c1.cX+5,c1.cY+5,30,30); 
            image(save,c1.cX+5,c1.cY+5,30,30); 
            stroke(96);

        }

        hoverSaveButtonDraw();
        
        // mousePress effects  
        if (mousePressed == true && c1.cSaved == false && layerSelect == selectState[2])
        
        { // save is currently off, but being switched on
            if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40) 

            { // save is being switched on - green icon appears
            
            fill(#646464);   
            rect(c1.cX,c1.cY,c1.cW,c1.cH);
            
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(120);
            line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
            line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

            image(saveShow,c1.cX+5,c1.cY+6,30,30);
            }        
        }

        if (mousePressed == true && c1.cSaved == true)
        
        { // save is currently on
        
         mousePressedShowHideButtonDraw();
        
        }
    }
}

void setupControls() 

{ // needs to be in Setup() - instantiates slots and cPanel controls
    s1 = new Slot("1",255,(offset+55),(offset+572),40,40,true,true,0,0,0,0,false);
    s2 = new Slot("2",255,(offset+95),(offset+572),40,40,false,false,0,0,0,0,false);
    s3 = new Slot("3",255,(offset+135),(offset+572),40,40,false,false,0,0,0,0,false);
    s4 = new Slot("4",255,(offset+175),(offset+572),40,40,false,false,0,0,0,0,false);
    s5 = new Slot("5",255,(offset+215),(offset+572),40,40,false,false,0,0,0,0,false);
    s6 = new Slot("6",255,(offset+255),(offset+572),40,40,false,false,0,0,0,0,false);
    s7 = new Slot("7",255,(offset+295),(offset+572),40,40,false,false,0,0,0,0,false);
    s8 = new Slot("8",255,(offset+335),(offset+572),40,40,false,false,0,0,0,0,false);
    s9 = new Slot("9",255,(offset+375),(offset+572),40,40,false,false,0,0,0,0,false);
    s10 = new Slot("10",255,(offset+415),(offset+572),40,40,false,false,0,0,0,0,false);
    c1 = new ControlPanel((offset+55),(offset+617),40,40,false,true); // save
    c2 = new ControlPanel((offset+55),(offset+662),40,40,false,false); // clear
    
}

void drawSlots()

{ // needs to be in draw() - i.e. draw slots
    s1.display();
    s2.display();
    s3.display();
    s4.display();
    s5.display();
    s6.display();
    s7.display();
    s8.display();
    s9.display();
    s10.display();
    c1.display();
    c2.display();

    
}
 
void layers() 

{ // draws layers for selection, start point, end point and final layer
 
    switch (layerSelect) {
        case selectState[0]: // no select
            startSelectX = 0;
            startSelectY = 0;
            break;
        case selectState[1]: // get 1st x,y co-ordinates 
            fill(#ffc899);
            rectMode(Processing.CORNER);
            rect(offset + (floor((startSelectX - offset) / gridSize) * gridSize),offset + (floor((startSelectY - offset) / gridSize) * gridSize),gridSize,gridSize);
            break;
        case selectState[2]: // get 2nd x,y co-ordinates and calculate layer size
            if (startSelectX < endSelectX && startSelectY < endSelectY) { // select box moving SE
                fill(#ffc899, 128);
                rectMode(Processing.CORNER);
                rect((floor((startSelectX - offset) / gridSize) * gridSize) + offset,(floor((startSelectY - offset) / gridSize) * gridSize) + offset,((ceil((endSelectX - offset) / gridSize) * gridSize)) - ((floor((startSelectX - offset) / gridSize) * gridSize)),((ceil((endSelectY - offset) / gridSize) * gridSize)) - ((floor((startSelectY - offset) / gridSize) * gridSize)));
                break;
            }
    }
}

void mouseClicked() 

{ // mouse click events 

    
    if (mouseY < 64) { // CHANGE GRID SIZE
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
    
    if (mouseX < width/2+(offset/2) && mouseX > width/2-(offset/2) && mouseY < (offset/2)) { // CONSOLE LOG REPORTING
        println("Console log.");
        println("left/right offset: " + offset);

    }

    
    if (mouseX > offset && mouseX < (offset)+512 && mouseY > offset && mouseY < (offset)+512 ) { // SELECT LAYER 
        switch (layerSelect) {
            case selectState[0]: // ready to start, get start x,y
                startSelectX = mouseX;
                startSelectY = mouseY;
                layerSelect = selectState[1];
                println("Mouse click. First (x,y) values captured");
                println("Layers - selection is started; startSelectX: " + startSelectX + "; startSelectY: " + startSelectY + "; endSelectX: " + endSelectX + "; endSelectY: " + endSelectY);
                break;
            case selectState[1]: // ready to complete, get end x,y
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
                readyToSave = true;
                break;
            case selectState[2]:
                layerSelect = selectState[0];
                startSelectX = 0;
                endSelectX = 0;
                startSelectY = 0;
                endSelectY = 0;
                readyToSave = false; 
                println("Mouse click. Layer select set to off");
                println("Layers - selection switched off; startSelectX: " + startSelectX + "; startSelectY: " + startSelectY + "; endSelectX: " + endSelectX + "; endSelectY: " + endSelectY);
                break;
        }
    }
    if ((mouseY > 64 && mouseX < offset) || (mouseY > 64 && mouseX < offset) || (mouseX > 512+offset && mouseY > 64)) {
        layerSelect = selectState[0];
        startSelectX = 0;
        endSelectX = 0;
        startSelectY = 0;
        endSelectY = 0;
        readyToSave = false;

               
    }

    slotSelectClicks(); // SLOT SELECTION
    
    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40)
    
    { // cPanel save clicks for slots 1-10 

        saveButtonClicks();
        
    }
    
    if (mouseX > c2.cX && mouseX < c2.cX+40 && mouseY > c2.cY && mouseY < c2.cY+40) 
    
    { // cPanel clear clicks for slots 1-10
    
      clearButtonClicks();

    }

    
}

void boxOver() 

{ // rollover on main grid squares before selection
    
    fill(250,150,0);
    rectMode(Processing.CORNER);
    translate(offset,offset);
    if (mouseX > offset && mouseX < 512+offset && mouseY > offset && mouseY < 512+offset ){
        rect((floor((mouseX - offset) / gridSize) * gridSize),(floor((mouseY - offset) / gridSize) * gridSize),gridSize,gridSize);
    }
        c = 140;    
    if (mouseX > 183 && mouseX < 223 && mouseY > 690 && mouseY < 730) { // slot1
    }
    else {
        c = 190;
    }
}

void mainGrid() 

{ // draws the background, grid, and top buttons
    
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
    
    
    // grid
    fill(255);
    rectMode(Processing.CENTER);
    var min = offset;
    var max = (min + boxSize);
    var x = min;
    var y = min;
    stroke(96);
    rect(offset,offset,boxSize,boxSize);
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
    text("Layers", offset+92, offset+562);
}


// DRAWS AND CLICKS RELATED TO SLOT LAYERS


void slotLayerShowHideGridDraw()

{ // draw show & hide saved layers on grid
    
    if (s1.slotOn == true && s1.layerSet == true && c1.saveVisible == true && s1.saveVisible == true) // draw saved layer
        // s1.draw saved layer
        {
               
            fill(0x1Aff99ff);
            rectMode(Processing.CORNER);
            rect(s1.layX,s1.layY,s1.layW,s1.layH);
            
        }

    if (s1.slotOn == true && s1.layerSet == true && c1.saveVisible == false && s1.saveVisible == false) 
        // s1.hide saved layer
        {
             
            fill(#ff99ff,128);
            rectMode(Processing.CORNER);
            rect(0,0,0,0);
            
        }

    if (s2.slotOn == true && s2.layerSet == true && c1.saveVisible == true && s2.saveVisible == true) 
        
        { // s2.draw saved layer
               
            fill(0x20ff99ff);
            rectMode(Processing.CORNER);
            rect(s2.layX,s2.layY,s2.layW,s2.layH);
            
        }

    if (s2.slotOn == true && s2.layerSet == true && c1.saveVisible == false && s2.saveVisible == false) // hide saved layer
        
        { // s2.hide saved layer
             
            fill(#ff99ff, 128);
            rectMode(Processing.CORNER);
            rect(0,0,0,0);
            
        }

    if (s3.slotOn == true && s3.layerSet == true && c1.saveVisible == true && s3.saveVisible == true) 
        
        { // s3.draw saved layer
               
            fill(0x20ff99ff);
            rectMode(Processing.CORNER);
            rect(s3.layX,s3.layY,s3.layW,s3.layH);
            
        }

    if (s3.slotOn == true && s3.layerSet == true && c1.saveVisible == false && s3.saveVisible == false) // hide saved layer
        
        { // s3.hide saved layer
             
            fill(#ff99ff, 128);
            rectMode(Processing.CORNER);
            rect(0,0,0,0);
            
        }

    if (s4.slotOn == true && s4.layerSet == true && c1.saveVisible == true && s4.saveVisible == true) 
        
        { // s4.draw saved layer
               
            fill(0x20ff99ff);
            rectMode(Processing.CORNER);
            rect(s4.layX,s4.layY,s4.layW,s4.layH);
            
        }

    if (s4.slotOn == true && s4.layerSet == true && c1.saveVisible == false && s4.saveVisible == false) // hide saved layer
        
        { // s4.hide saved layer
             
            fill(#ff99ff, 128);
            rectMode(Processing.CORNER);
            rect(0,0,0,0);
            
        }
        
    if (s5.slotOn == true && s5.layerSet == true && c1.saveVisible == true && s5.saveVisible == true) 
        
        { // s5.draw saved layer
               
            fill(0x20ff99ff);
            rectMode(Processing.CORNER);
            rect(s5.layX,s5.layY,s5.layW,s5.layH);
            
        }

    if (s5.slotOn == true && s5.layerSet == true && c1.saveVisible == false && s5.saveVisible == false) // hide saved layer
        
        { // s5.hide saved layer
             
            fill(#ff99ff, 128);
            rectMode(Processing.CORNER);
            rect(0,0,0,0);
            
        }

    if (s6.slotOn == true && s6.layerSet == true && c1.saveVisible == true && s6.saveVisible == true) 
        
        { // s6.draw saved layer
               
            fill(0x20ff99ff);
            rectMode(Processing.CORNER);
            rect(s6.layX,s6.layY,s6.layW,s6.layH);
            
        }

    if (s6.slotOn == true && s6.layerSet == true && c1.saveVisible == false && s6.saveVisible == false) // hide saved layer
        
        { // s6.hide saved layer
             
            fill(#ff99ff, 128);
            rectMode(Processing.CORNER);
            rect(0,0,0,0);
            
        }

    if (s7.slotOn == true && s7.layerSet == true && c1.saveVisible == true && s7.saveVisible == true) 
        
        { // s7.raw saved layer
               
            fill(0x20ff99ff);
            rectMode(Processing.CORNER);
            rect(s7.layX,s7.layY,s7.layW,s7.layH);
            
        }

    if (s7.slotOn == true && s7.layerSet == true && c1.saveVisible == false && s7.saveVisible == false) // hide saved layer
        
        { // s7.hide saved layer
             
            fill(#ff99ff, 128);
            rectMode(Processing.CORNER);
            rect(0,0,0,0);
            
        }

    if (s8.slotOn == true && s8.layerSet == true && c1.saveVisible == true && s8.saveVisible == true) 
        
        { // s8.draw saved layer
               
            fill(0x20ff99ff);
            rectMode(Processing.CORNER);
            rect(s8.layX,s8.layY,s8.layW,s8.layH);
            
        }

    if (s8.slotOn == true && s8.layerSet == true && c1.saveVisible == false && s8.saveVisible == false) // hide saved layer
        
        { // s8.hide saved layer
             
            fill(#ff99ff, 128);
            rectMode(Processing.CORNER);
            rect(0,0,0,0);
            
        }

    if (s9.slotOn == true && s9.layerSet == true && c1.saveVisible == true && s9.saveVisible == true) 
        
        { // s9.draw saved layer
               
            fill(0x20ff99ff);
            rectMode(Processing.CORNER);
            rect(s9.layX,s9.layY,s9.layW,s9.layH);
            
        }

    if (s9.slotOn == true && s9.layerSet == true && c1.saveVisible == false && s9.saveVisible == false) // hide saved layer
        
        { // s9.hide saved layer
             
            fill(#ff99ff, 128);
            rectMode(Processing.CORNER);
            rect(0,0,0,0);
            
        }

    if (s10.slotOn == true && s10.layerSet == true && c1.saveVisible == true && s10.saveVisible == true) 
        
        { // s10.draw saved layer
               
            fill(0x20ff99ff);
            rectMode(Processing.CORNER);
            rect(s10.layX,s10.layY,s10.layW,s10.layH);
            
        }

    if (s10.slotOn == true && s10.layerSet == true && c1.saveVisible == false && s10.saveVisible == false) // hide saved layer
        
        { // s10.hide saved layer
             
            fill(#ff99ff, 128);
            rectMode(Processing.CORNER);
            rect(0,0,0,0);
            
        }
}

void saveShowHideButtonDraw() 

{ // draw show & hide buttons in cPanel

    if (s1.saveVisible == true && c1.cSaved == true && c1.saveVisible == true )  
    
    { // s1.save is on and visible (will need to do these for all slots)
        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveShow,c1.cX+5,c1.cY+6,30,30);

    }
    
    if (s1.saveVisible == false && c1.cSaved == true && c1.saveVisible == false)

    { //  s1.save is on, but invisible (will need to do these for all slots)

        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveHidden,c1.cX+5,c1.cY+6,30,30);

    }

    if (s2.saveVisible == true && c1.cSaved == true && c1.saveVisible == true)  
    
    { // s2.save is on and visible
        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveShow,c1.cX+5,c1.cY+6,30,30);

    }
    
    if (s2.saveVisible == false && c1.cSaved == true && c1.saveVisible == false)

    { //  s2.save is on, but invisible

        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveHidden,c1.cX+5,c1.cY+6,30,30);

    }

    if (s3.saveVisible == true && c1.cSaved == true && c1.saveVisible == true) 
    
    { // s3.save is on and visible
        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveShow,c1.cX+5,c1.cY+6,30,30);
    }
    
    if (s3.saveVisible == true && c1.cSaved == true && c1.saveVisible == true)  
    { //  s3.save is on, but invisible

        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveHidden,c1.cX+5,c1.cY+6,30,30);

    }

    if (s4.saveVisible == true && c1.cSaved == true && c1.saveVisible == true)  
    
    { // s4.save is on and visible
        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveShow,c1.cX+5,c1.cY+6,30,30);

    }
    
    if (s4.saveVisible == false && c1.cSaved == true && c1.saveVisible == false)

    { //  s4.save is on, but invisible

        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveHidden,c1.cX+5,c1.cY+6,30,30);

    }

    if (s5.saveVisible == true && c1.cSaved == true && c1.saveVisible == true)  
    
    { // s5.save is on and visible
        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveShow,c1.cX+5,c1.cY+6,30,30);

    }
    
    if (s5.saveVisible == false && c1.cSaved == true && c1.saveVisible == false)

    { //  s5.save is on, but invisible

        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveHidden,c1.cX+5,c1.cY+6,30,30);

    }

    if (s6.saveVisible == true && c1.cSaved == true && c1.saveVisible == true)  
    
    { // s6.save is on and visible
        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveShow,c1.cX+5,c1.cY+6,30,30);

    }
    
    if (s6.saveVisible == false && c1.cSaved == true && c1.saveVisible == false)

    { //  s6.save is on, but invisible

        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveHidden,c1.cX+5,c1.cY+6,30,30);

    }

    if (s7.saveVisible == true && c1.cSaved == true && c1.saveVisible == true)  
    
    { // s7.save is on and visible
        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveShow,c1.cX+5,c1.cY+6,30,30);

    }
    
    if (s7.saveVisible == false && c1.cSaved == true && c1.saveVisible == false)

    { //  s7.save is on, but invisible

        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveHidden,c1.cX+5,c1.cY+6,30,30);

    }

    if (s8.saveVisible == true && c1.cSaved == true && c1.saveVisible == true)  
    
    { // s8.save is on and visible
        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveShow,c1.cX+5,c1.cY+6,30,30);

    }
    
    if (s8.saveVisible == false && c1.cSaved == true && c1.saveVisible == false)

    { //  s8.save is on, but invisible

        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveHidden,c1.cX+5,c1.cY+6,30,30);

    }

    if (s9.saveVisible == true && c1.cSaved == true && c1.saveVisible == true)  
    
    { // s9.save is on and visible
        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveShow,c1.cX+5,c1.cY+6,30,30);

    }
    
    if (s9.saveVisible == false && c1.cSaved == true && c1.saveVisible == false)

    { //  s9.save is on, but invisible

        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveHidden,c1.cX+5,c1.cY+6,30,30);

    }    
    
    if (s10.saveVisible == true && c1.cSaved == true && c1.saveVisible == true)  
    
    { // s10.save is on and visible
        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveShow,c1.cX+5,c1.cY+6,30,30);

    }
    
    if (s10.saveVisible == false && c1.cSaved == true && c1.saveVisible == false)

    { //  s10.save is on, but invisible

        translate(0,0);        
        fill(#646464);   
        rect(c1.cX,c1.cY,c1.cW,c1.cH);
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(120);
        line(c1.cX+2,c1.cY+38,c1.cX+38,c1.cY+38);
        line(c1.cX+38,c1.cY+2,c1.cX+38,c1.cY+38);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);

        stroke(96);
        image(saveHidden,c1.cX+5,c1.cY+6,30,30);

    }


}

void hoverSaveButtonDraw()

{ // draw hover on save button in cPanel (s1-s10)

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && c1.cSaved == true && c1.saveVisible == true && s1.saveVisible == true) 
        
        { // s1.draw hover after layer is saved - layer is visible 
           
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            image(saveHidden,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && c1.cSaved == true && c1.saveVisible == true && s2.saveVisible == true) 
        
        { // s2.draw hover after layer is saved - layer is visible 
          
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            image(saveHidden,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && c1.cSaved == true && c1.saveVisible == true && s3.saveVisible == true) 
        
        { // s3.draw hover after layer is saved - layer is visible 
           
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            image(saveHidden,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && c1.cSaved == true && c1.saveVisible == true && s4.saveVisible == true) 
        
        { // s4.draw hover after layer is saved - layer is visible (will need to do separately for each slot)
           
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            image(saveHidden,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && c1.cSaved == true && c1.saveVisible == true && s5.saveVisible == true) 
        
        { // s5.draw hover after layer is saved - layer is visible 
           
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            image(saveHidden,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && c1.cSaved == true && c1.saveVisible == true && s6.saveVisible == true) 
        
        { // s6.draw hover after layer is saved - layer is visible 
          
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            image(saveHidden,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && c1.cSaved == true && c1.saveVisible == true && s7.saveVisible == true) 
        
        { // s7.draw hover after layer is saved - layer is visible 
          
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            image(saveHidden,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && c1.cSaved == true && c1.saveVisible == true && s8.saveVisible == true) 
        
        { // s8.draw hover after layer is saved - layer is visible
          
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            image(saveHidden,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && c1.cSaved == true && c1.saveVisible == true && s9.saveVisible == true) 
        
        { // s9.draw hover after layer is saved - layer is visible 
           
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            image(saveHidden,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && c1.cSaved == true && c1.saveVisible == true && s10.saveVisible == true) 
        
        { // s10.draw hover after layer is saved - layer is visible 
          
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            image(saveHidden,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && c1.cSaved == true && c1.saveVisible == false && s1.saveVisible == false) 
        
        { // s1.draw hover after layer is saved - layer is invisible 
           
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            rect(c1.cX+5,c1.cY+6,30,30); 
            
            image(saveShow,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && c1.cSaved == true && c1.saveVisible == false && s2.saveVisible == false) 
        
        { // s2.draw hover after layer is saved - layer is invisible 
           
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            rect(c1.cX+5,c1.cY+6,30,30); 
            
            image(saveShow,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && c1.cSaved == true && c1.saveVisible == false && s3.saveVisible == false) 
        
        { // s3.draw hover after layer is saved - layer is invisible 
          
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            rect(c1.cX+5,c1.cY+6,30,30); 
            
            image(saveShow,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }
        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && c1.cSaved == true && c1.saveVisible == false && s4.saveVisible == false) 
        
        { // s4.draw hover after layer is saved - layer is invisible 
          
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            rect(c1.cX+5,c1.cY+6,30,30); 
            
            image(saveShow,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }        
        
        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && c1.cSaved == true && c1.saveVisible == false && s5.saveVisible == false) 
        
        { // s5.draw hover after layer is saved - layer is invisible 
          
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            rect(c1.cX+5,c1.cY+6,30,30); 
            
            image(saveShow,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && c1.cSaved == true && c1.saveVisible == false && s6.saveVisible == false) 
        
        { // s6.draw hover after layer is saved - layer is invisible
          
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            rect(c1.cX+5,c1.cY+6,30,30); 
            
            image(saveShow,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && c1.cSaved == true && c1.saveVisible == false && s7.saveVisible == false) 
        
        { // s7.draw hover after layer is saved - layer is invisible 
           
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            rect(c1.cX+5,c1.cY+6,30,30); 
            
            image(saveShow,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && c1.cSaved == true && c1.saveVisible == false && s8.saveVisible == false) 
        
        { // s8.draw hover after layer is saved - layer is invisible 
            
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            rect(c1.cX+5,c1.cY+6,30,30); 
            
            image(saveShow,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && c1.cSaved == true && c1.saveVisible == false && s9.saveVisible == false) 
        
        { // s9.draw hover after layer is saved - layer is invisible 
            
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            rect(c1.cX+5,c1.cY+6,30,30); 
            
            image(saveShow,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

        if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && c1.cSaved == true && c1.saveVisible == false && s10.saveVisible == false) 
        
        { // s10.draw hover after layer is saved - layer is invisible 
           
            stroke(150,164,181);
            line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
            line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
            
            stroke(15);
            line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
            stroke(44,49,54);
            line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
           
            line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
            line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
            stroke(#646464);
            fill(#646464);
            rect(c1.cX+5,c1.cY+6,30,30); 
            
            image(saveShow,c1.cX+5,c1.cY+6,30,30); 
            stroke(96);
           
        }

}

void mousePressedShowHideButtonDraw()

{  // draw mousepressed for show & hide buttons in cPanel

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s1.saveVisible == false) 

    { // s1.mousepress is switching to layer invisible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveShow,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);

    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s2.saveVisible == false) 

    { // s2.mousepress is switching to layer invisible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveShow,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
        
    }    

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s3.saveVisible == false) 

    { // s3.mousepress is switching to layer invisible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveShow,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
        
    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s4.saveVisible == false) 

    { // s4.mousepress is switching to layer invisible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveShow,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
        
    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s5.saveVisible == false) 

    { // s5.mousepress is switching to layer invisible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveShow,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
        
    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s6.saveVisible == false) 

    { // s6.mousepress is switching to layer invisible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveShow,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
        
    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s7.saveVisible == false) 

    { // s7.mousepress is switching to layer invisible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveShow,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
        
    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s8.saveVisible == false) 

    { // s8.mousepress is switching to layer invisible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveShow,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
        
    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s9.saveVisible == false) 

    { // s9.mousepress is switching to layer invisible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveShow,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
        
    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s10.saveVisible == false) 

    { // s10.mousepress is switching to layer invisible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveShow,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
        
    }
   

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s1.saveVisible == true) 

    { // s1.mousepress is switching to layer visible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveHidden,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
    
    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s2.saveVisible == true) 

    { // s2.mousepress is switching to layer visible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveHidden,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
    
    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s3.saveVisible == true) 

    { // s3.mousepress is switching to layer visible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveHidden,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
    
    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s4.saveVisible == true) 

    { // s4.mousepress is switching to layer visible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveHidden,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
    
    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s5.saveVisible == true) 

    { // s5.mousepress is switching to layer visible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveHidden,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
    
    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s6.saveVisible == true) 

    { // s6.mousepress is switching to layer visible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveHidden,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
    
    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s7.saveVisible == true) 

    { // s7.mousepress is switching to layer visible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveHidden,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
    
    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s8.saveVisible == true) 

    { // s8.mousepress is switching to layer visible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveHidden,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
    
    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s9.saveVisible == true) 

    { // s9.mousepress is switching to layer visible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveHidden,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
    
    }

    if (mouseX > c1.cX && mouseX < c1.cX+40 && mouseY > c1.cY && mouseY < c1.cY+40 && s10.saveVisible == true) 

    { // s10.mousepress is switching to layer visible (save) 
        
        stroke(150,164,181);
        line(c1.cX+1,c1.cY+39,c1.cX+39,c1.cY+39);
        line(c1.cX+39,c1.cY+1,c1.cX+39,c1.cY+39);
        
        stroke(15);
        line(c1.cX+1,c1.cY+1,c1.cX+1,c1.cY+39);
        stroke(44,49,54);
        line(c1.cX+2,c1.cY+2,c1.cX+2,c1.cY+38);
        
        line(c1.cX+1,c1.cY+1,c1.cX+39,c1.cY+1);
        line(c1.cX+2,c1.cY+2,c1.cX+38,c1.cY+2);
        stroke(#646464);
        fill(#646464);
        rect(c1.cX+5,c1.cY+6,30,30); 
        
        image(saveHidden,c1.cX+5,c1.cY+6,30,30); 
        stroke(96);
    
    }

    if (mouseX > c2.cX && mouseX < c2.cX+40 && mouseY > c2.cY && mouseY < c2.cY+40)
            
    { // mousepressed and clearing slot drawn
            
        fill(#646464);   
        rect(c2.cX,c2.cY,c2.cW,c2.cH);
            
        stroke(150,164,181);
        line(c2.cX+1,c2.cY+39,c2.cX+39,c2.cY+39);
        line(c2.cX+39,c2.cY+1,c2.cX+39,c2.cY+39);
        
        stroke(120);
        line(c2.cX+2,c2.cY+38,c2.cX+38,c2.cY+38);
        line(c2.cX+38,c2.cY+2,c2.cX+38,c2.cY+38);
        
        stroke(15);
        line(c2.cX+1,c2.cY+1,c2.cX+1,c2.cY+39);
        stroke(44,49,54);
        line(c2.cX+2,c2.cY+2,c2.cX+2,c2.cY+38);
        
        
        line(c2.cX+1,c2.cY+1,c2.cX+39,c2.cY+1);
        line(c2.cX+2,c2.cY+2,c2.cX+38,c2.cY+2);
            
        stroke(#646464);
        fill(#646464);
        rect(c2.cX+5,c2.cY+6,30,30); 
        image(clearOn,c2.cX+5,c2.cY+6,30,30);
        stroke(96);

    }

}

void slotSelectClicks() 

{ // click slot button to make active
    
    if (mouseX > s1.sX && mouseX < s1.sX+40 && mouseY > s1.sY && mouseY < s1.sY+40){ // slots

        if (s1.slotOn == false) {
                s1.slotOn = true;
                s2.slotOn = false;
                s3.slotOn = false;
                s4.slotOn = false;
                s5.slotOn = false;
                s6.slotOn = false;
                s7.slotOn = false;
                s8.slotOn = false;
                s9.slotOn = false;
                s10.slotOn = false;
                c1.cX = offset+55;
                c2.cX = offset+55;                
        }

        if (s1.layerSet == true) {
            c1.cSaved = true;
        }
        else if (s1.layerSet == false) {
            c1.cSaved = false;
        }


    }
    if (mouseX > s2.sX && mouseX < s2.sX+40 && mouseY > s2.sY && mouseY < s2.sY+40){ // slots
        
        if (s2.slotOn == false) {
                s1.slotOn = false;
                s2.slotOn = true;
                s3.slotOn = false;
                s4.slotOn = false;
                s5.slotOn = false;
                s6.slotOn = false;
                s7.slotOn = false;
                s8.slotOn = false;
                s9.slotOn = false;
                s10.slotOn = false;
                c1.cX = offset+55;
                c2.cX = offset+55;
                c1.cX = 40+c1.cX;
                c2.cX = 40+c2.cX;

        }
        if (s2.layerSet == true) {
            c1.cSaved = true; 
        }
        else if (s2.layerSet == false) {
            c1.cSaved = false;
        }
    }    
    if (mouseX > s3.sX && mouseX < s3.sX+40 && mouseY > s3.sY && mouseY < s3.sY+40){ // slots
        
        if (s3.slotOn == false) {
                s1.slotOn = false;
                s2.slotOn = false;
                s3.slotOn = true;
                s4.slotOn = false;
                s5.slotOn = false;
                s6.slotOn = false;
                s7.slotOn = false;
                s8.slotOn = false;
                s9.slotOn = false;
                s10.slotOn = false;
                c1.cX = offset+55;
                c2.cX = offset+55;
                c1.cX = 80+c1.cX;
                c2.cX = 80+c2.cX;
        }
        if (s3.layerSet == true) {
            c1.cSaved = true; 
        }
        else if (s3.layerSet == false) {
            c1.cSaved = false;
        }
    }    
    if (mouseX > s4.sX && mouseX < s4.sX+40 && mouseY > s4.sY && mouseY < s4.sY+40){ // slots
        
        if (s4.slotOn == false) {
                s1.slotOn = false;
                s2.slotOn = false;
                s3.slotOn = false;
                s4.slotOn = true;
                s5.slotOn = false;
                s6.slotOn = false;
                s7.slotOn = false;
                s8.slotOn = false;
                s9.slotOn = false;
                s10.slotOn = false;
                c1.cX = offset+55;
                c2.cX = offset+55;
                c1.cX = 120+c1.cX;
                c2.cX = 120+c2.cX;

        }
        if (s4.layerSet == true) {
            c1.cSaved = true; 
        }
        else if (s4.layerSet == false) {
            c1.cSaved = false;
        }

    }
    if (mouseX > s5.sX && mouseX < s5.sX+40 && mouseY > s5.sY && mouseY < s5.sY+40){ // slots
        
        if (s5.slotOn == false) {
                s1.slotOn = false;
                s2.slotOn = false;
                s3.slotOn = false;
                s4.slotOn = false;
                s5.slotOn = true;
                s6.slotOn = false;
                s7.slotOn = false;
                s8.slotOn = false;
                s9.slotOn = false;
                s10.slotOn = false;
                c1.cX = offset+55;
                c2.cX = offset+55;
                c1.cX = 160+c1.cX;
                c2.cX = 160+c2.cX;

        }
        if (s5.layerSet == true) {
            c1.cSaved = true; 
        }
        else if (s5.layerSet == false) {
            c1.cSaved = false;
        }


    }
    if (mouseX > s6.sX && mouseX < s6.sX+40 && mouseY > s6.sY && mouseY < s6.sY+40){ // slots
        
        if (s6.slotOn == false) {
                s1.slotOn = false;
                s2.slotOn = false;
                s3.slotOn = false;
                s4.slotOn = false;
                s5.slotOn = false;
                s6.slotOn = true;
                s7.slotOn = false;
                s8.slotOn = false;
                s9.slotOn = false;
                s10.slotOn = false;
                c1.cX = offset+55;
                c2.cX = offset+55;
                c1.cX = 200+c1.cX;
                c2.cX = 200+c2.cX;

        }
        if (s6.layerSet == true) {
            c1.cSaved = true; 
        }
        else if (s6.layerSet == false) {
            c1.cSaved = false;
        }


    }
    if (mouseX > s7.sX && mouseX < s7.sX+40 && mouseY > s7.sY && mouseY < s7.sY+40){ // slots
        

        if (s7.slotOn == false) {
                s1.slotOn = false;
                s2.slotOn = false;
                s3.slotOn = false;
                s4.slotOn = false;
                s5.slotOn = false;
                s6.slotOn = false;
                s7.slotOn = true;
                s8.slotOn = false;
                s9.slotOn = false;
                s10.slotOn = false;
                c1.cX = offset+55;
                c2.cX = offset+55;
                c1.cX = 240+c1.cX;
                c2.cX = 240+c2.cX;

        }
        if (s7.layerSet == true) {
            c1.cSaved = true; 
        }
        else if (s7.layerSet == false) {
            c1.cSaved = false;
        }



    }
    if (mouseX > s8.sX && mouseX < s8.sX+40 && mouseY > s8.sY && mouseY < s8.sY+40){ // slots
        

        if (s8.slotOn == false) {
                s1.slotOn = false;
                s2.slotOn = false;
                s3.slotOn = false;
                s4.slotOn = false;
                s5.slotOn = false;
                s6.slotOn = false;
                s7.slotOn = false;
                s8.slotOn = true;
                s9.slotOn = false;
                s10.slotOn = false;
                c1.cX = offset+55;
                c2.cX = offset+55;
                c1.cX = 280+c1.cX;
                c2.cX = 280+c2.cX;

        }
        if (s8.layerSet == true) {
            c1.cSaved = true; 
        }
        else if (s8.layerSet == false) {
            c1.cSaved = false;
        }    


    }
    if (mouseX > s9.sX && mouseX < s9.sX+40 && mouseY > s9.sY && mouseY < s9.sY+40){ // slots
        
        if (s9.slotOn == false) {
                s1.slotOn = false;
                s2.slotOn = false;
                s3.slotOn = false;
                s4.slotOn = false;
                s5.slotOn = false;
                s6.slotOn = false;
                s7.slotOn = false;
                s8.slotOn = false;
                s9.slotOn = true;
                s10.slotOn = false;
                c1.cX = offset+55;
                c2.cX = offset+55;
                c1.cX = 320+c1.cX;
                c2.cX = 320+c2.cX;

        }

        if (s9.layerSet == true) {
            c1.cSaved = true; 
        }
        else if (s9.layerSet == false) {
            c1.cSaved = false;
        } 

        
    }
    
    if (mouseX > s10.sX && mouseX < s10.sX+40 && mouseY > s10.sY && mouseY < s10.sY+40){ // slots
        
        if (s10.slotOn == false) {
                s1.slotOn = false;
                s2.slotOn = false;
                s3.slotOn = false;
                s4.slotOn = false;
                s5.slotOn = false;
                s6.slotOn = false;
                s7.slotOn = false;
                s8.slotOn = false;
                s9.slotOn = false;
                s10.slotOn = true;
                c1.cX = offset+55;
                c2.cX = offset+55;
                c1.cX = 360+c1.cX;
                c2.cX = 360+c2.cX;

        }

        if (s10.layerSet == true) {
            c1.cSaved = true; 
        }
        else if (s10.layerSet == false) {
            c1.cSaved = false;
        } 

    }     
}

void saveButtonClicks() 

{  // click save button in cPanel 
        
    if (s1.saveVisible == false && c1.cSaved == true && s1.layerSet == true && c1.saveVisible == false) 
        
    { // s1.switch save visibility to on, from off
             
        c1.saveVisible = true; // this is for the button draw
        s1.saveVisible = true; // this is for the layer draw

    }
        
    else if (s1.saveVisible == true && c1.cSaved == true && s1.layerSet == true && c1.saveVisible == true) 
    
    { // s1.switch save visibility to off, from on
            
        c1.saveVisible = false; // controls the cP button draw
        s1.saveVisible = false; // controls the layer draw in the grid
    }

    if (s1.slotOn == true && layerSelect == selectState[2] && c1.cSaved == false && readyToSave == true) 
    
    {  // s1.on click, get values for layer save

        if (endSelectX < startSelectX)
        
        {
                    swap = endSelectX;
                    endSelectX = startSelectX;
                    startSelectX = swap;
        }
                
        if (endSelectY < startSelectY)
        
        {
            swap = endSelectY;
            endSelectY = startSelectY;
            startSelectY = swap;
        }

        s1.layX = (floor((startSelectX - offset) / gridSize) * gridSize) + offset;
           
        s1.layY = (floor((startSelectY - offset) / gridSize) * gridSize) + offset;
           
        s1.layW = ((ceil((endSelectX - offset) / gridSize) * gridSize)) - ((floor((startSelectX - offset) / gridSize) * gridSize));
            
        s1.layH = ((ceil((endSelectY - offset) / gridSize) * gridSize)) - ((floor((startSelectY - offset) / gridSize) * gridSize));
        
        s1.layerSet = true; // now display save layer if saveVisible is visible cPanel display()
        c1.cSaved = true;
        c1.saveVisible = true;
        s1.saveVisible = true;
        layerSelect = selectState[0];
        startSelectX = 0;
        endSelectX = 0;
        startSelectY = 0;
        endSelectY = 0;
        readyToSave = false; 
            
    }

    if (s2.saveVisible == false && c1.cSaved == true && s2.layerSet == true && c1.saveVisible == false) 
        
    { // s2.switch save visibility to on, from off
             
        c1.saveVisible = true;
        s2.saveVisible = true;

    }
        
    else if (s2.saveVisible == true && c1.cSaved == true && s2.layerSet == true && c1.saveVisible == true) 
    
    { // s2.switch save visibility to off, from on
            
        c1.saveVisible = false; // controls the cP button draw
        s2.saveVisible = false; // controls the layer draw in the grid
    }

    if (c1.cSaved == false && s2.slotOn == true && layerSelect == selectState[2] &&  readyToSave == true) 
    
    {  // s2.on click, get values for layer save

        if (endSelectX < startSelectX)
        
        {
                    swap = endSelectX;
                    endSelectX = startSelectX;
                    startSelectX = swap;
        }
                
        if (endSelectY < startSelectY)
        
        {
            swap = endSelectY;
            endSelectY = startSelectY;
            startSelectY = swap;
        }

        s2.layX = (floor((startSelectX - offset) / gridSize) * gridSize) + offset;
           
        s2.layY = (floor((startSelectY - offset) / gridSize) * gridSize) + offset;
           
        s2.layW = ((ceil((endSelectX - offset) / gridSize) * gridSize)) - ((floor((startSelectX - offset) / gridSize) * gridSize));
            
        s2.layH = ((ceil((endSelectY - offset) / gridSize) * gridSize)) - ((floor((startSelectY - offset) / gridSize) * gridSize));
        
        s2.layerSet = true; // now display save layer: cPanel display()
        c1.cSaved = true;
        c1.saveVisible = true;
        s2.saveVisible = true;
        layerSelect = selectState[0];
        startSelectX = 0;
        endSelectX = 0;
        startSelectY = 0;
        endSelectY = 0;
        readyToSave = false; 
            
    }

    if (s3.saveVisible == false && c1.cSaved == true && s3.layerSet == true && c1.saveVisible == false) 
        
    { // s3.switch save visibility to on, from off
             
        c1.saveVisible = true;
        s3.saveVisible = true;

    }
        
    else if (s3.saveVisible == true && c1.cSaved == true && s3.layerSet == true && c1.saveVisible == true) 
    
    { // s3.switch save visibility to off, from on
            
        c1.saveVisible = false; // controls the cP button draw
        s3.saveVisible = false; // controls the layer draw in the grid
    }

    if (c1.cSaved == false && s3.slotOn == true && layerSelect == selectState[2] &&  readyToSave == true) 
    
    {  // s3.on click, get values for layer save

        if (endSelectX < startSelectX)
        
        {
                    swap = endSelectX;
                    endSelectX = startSelectX;
                    startSelectX = swap;
        }
                
        if (endSelectY < startSelectY)
        
        {
            swap = endSelectY;
            endSelectY = startSelectY;
            startSelectY = swap;
        }

        s3.layX = (floor((startSelectX - offset) / gridSize) * gridSize) + offset;
           
        s3.layY = (floor((startSelectY - offset) / gridSize) * gridSize) + offset;
           
        s3.layW = ((ceil((endSelectX - offset) / gridSize) * gridSize)) - ((floor((startSelectX - offset) / gridSize) * gridSize));
            
        s3.layH = ((ceil((endSelectY - offset) / gridSize) * gridSize)) - ((floor((startSelectY - offset) / gridSize) * gridSize));
        
        s3.layerSet = true; // now display save layer: cPanel display()
        c1.cSaved = true;
        c1.saveVisible = true;
        s3.saveVisible = true;
        layerSelect = selectState[0];
        startSelectX = 0;
        endSelectX = 0;
        startSelectY = 0;
        endSelectY = 0;
        readyToSave = false; 
            
    }

    if (s4.saveVisible == false && c1.cSaved == true && s4.layerSet == true && c1.saveVisible == false) 
        
    { // s4.switch save visibility to on, from off
             
        c1.saveVisible = true;
        s4.saveVisible = true;

    }
        
    else if (s4.saveVisible == true && c1.cSaved == true && s4.layerSet == true && c1.saveVisible == true) 
    
    { // s4.switch save visibility to off, from on
            
        c1.saveVisible = false; // controls the cP button draw
        s4.saveVisible = false; // controls the layer draw in the grid
    }

    if (c1.cSaved == false && s4.slotOn == true && layerSelect == selectState[2] &&  readyToSave == true) 
    
    {  // s4.on click, get values for layer save

        if (endSelectX < startSelectX)
        
        {
                    swap = endSelectX;
                    endSelectX = startSelectX;
                    startSelectX = swap;
        }
                
        if (endSelectY < startSelectY)
        
        {
            swap = endSelectY;
            endSelectY = startSelectY;
            startSelectY = swap;
        }

        s4.layX = (floor((startSelectX - offset) / gridSize) * gridSize) + offset;
           
        s4.layY = (floor((startSelectY - offset) / gridSize) * gridSize) + offset;
           
        s4.layW = ((ceil((endSelectX - offset) / gridSize) * gridSize)) - ((floor((startSelectX - offset) / gridSize) * gridSize));
            
        s4.layH = ((ceil((endSelectY - offset) / gridSize) * gridSize)) - ((floor((startSelectY - offset) / gridSize) * gridSize));
        
        s4.layerSet = true; // now display save layer: cPanel display()
        c1.cSaved = true;
        c1.saveVisible = true;
        s4.saveVisible = true;
        layerSelect = selectState[0];
        startSelectX = 0;
        endSelectX = 0;
        startSelectY = 0;
        endSelectY = 0;
        readyToSave = false; 
            
    }

    if (s5.saveVisible == false && c1.cSaved == true && s5.layerSet == true && c1.saveVisible == false) 
        
    { // s5.switch save visibility to on, from off
             
        c1.saveVisible = true;
        s5.saveVisible = true;

    }
        
    else if (s5.saveVisible == true && c1.cSaved == true && s5.layerSet == true && c1.saveVisible == true) 
    
    { // s5.switch save visibility to off, from on
            
        c1.saveVisible = false; // controls the cP button draw
        s5.saveVisible = false; // controls the layer draw in the grid
    }

    if (c1.cSaved == false && s5.slotOn == true && layerSelect == selectState[2] && readyToSave == true) 
    
    {  // s5.on click, get values for layer save

        if (endSelectX < startSelectX)
        
        {
            swap = endSelectX;
            endSelectX = startSelectX;
            startSelectX = swap;
        }
                
        if (endSelectY < startSelectY)
        
        {
            swap = endSelectY;
            endSelectY = startSelectY;
            startSelectY = swap;
        }

        s5.layX = (floor((startSelectX - offset) / gridSize) * gridSize) + offset;
           
        s5.layY = (floor((startSelectY - offset) / gridSize) * gridSize) + offset;
           
        s5.layW = ((ceil((endSelectX - offset) / gridSize) * gridSize)) - ((floor((startSelectX - offset) / gridSize) * gridSize));
            
        s5.layH = ((ceil((endSelectY - offset) / gridSize) * gridSize)) - ((floor((startSelectY - offset) / gridSize) * gridSize));
        
        s5.layerSet = true; // now display save layer: cPanel display()
        c1.cSaved = true;
        c1.saveVisible = true;
        s5.saveVisible = true;
        layerSelect = selectState[0];
        startSelectX = 0;
        endSelectX = 0;
        startSelectY = 0;
        endSelectY = 0;
        readyToSave = false; 
            
    }
    
    if (s6.saveVisible == false && c1.cSaved == true && s6.layerSet == true && c1.saveVisible == false) 
        
    { // s6.switch save visibility to on, from off
             
        c1.saveVisible = true;
        s6.saveVisible = true;

    }
        
    else if (s6.saveVisible == true && c1.cSaved == true && s6.layerSet == true && c1.saveVisible == true) 
    
    { // s6.switch save visibility to off, from on
            
        c1.saveVisible = false; // controls the cP button draw
        s6.saveVisible = false; // controls the layer draw in the grid
    }

    if (c1.cSaved == false && s6.slotOn == true && layerSelect == selectState[2] && readyToSave == true) 
    
    {  // s6.on click, get values for layer save

        if (endSelectX < startSelectX)
        
        {
            swap = endSelectX;
            endSelectX = startSelectX;
            startSelectX = swap;
        }
                
        if (endSelectY < startSelectY)
        
        {
            swap = endSelectY;
            endSelectY = startSelectY;
            startSelectY = swap;
        }

        s6.layX = (floor((startSelectX - offset) / gridSize) * gridSize) + offset;
           
        s6.layY = (floor((startSelectY - offset) / gridSize) * gridSize) + offset;
           
        s6.layW = ((ceil((endSelectX - offset) / gridSize) * gridSize)) - ((floor((startSelectX - offset) / gridSize) * gridSize));
            
        s6.layH = ((ceil((endSelectY - offset) / gridSize) * gridSize)) - ((floor((startSelectY - offset) / gridSize) * gridSize));
        
        s6.layerSet = true; // now display save layer: cPanel display()
        c1.cSaved = true;
        c1.saveVisible = true;
        s6.saveVisible = true;
        layerSelect = selectState[0];
        startSelectX = 0;
        endSelectX = 0;
        startSelectY = 0;
        endSelectY = 0;
        readyToSave = false; 
            
    }
    
    if (s7.saveVisible == false && c1.cSaved == true && s7.layerSet == true && c1.saveVisible == false) 
        
    { // s7.switch save visibility to on, from off
             
        c1.saveVisible = true;
        s7.saveVisible = true;

    }
        
    else if (s7.saveVisible == true && c1.cSaved == true && s7.layerSet == true && c1.saveVisible == true) 
    
    { // s7.switch save visibility to off, from on
            
        c1.saveVisible = false; // controls the cP button draw
        s7.saveVisible = false; // controls the layer draw in the grid
    }

    if (c1.cSaved == false && s7.slotOn == true && layerSelect == selectState[2] && readyToSave == true) 
    
    {  // s7.on click, get values for layer save

        if (endSelectX < startSelectX)
        
        {
                    swap = endSelectX;
                    endSelectX = startSelectX;
                    startSelectX = swap;
        }
                
        if (endSelectY < startSelectY)
        
        {
            swap = endSelectY;
            endSelectY = startSelectY;
            startSelectY = swap;
        }

        s7.layX = (floor((startSelectX - offset) / gridSize) * gridSize) + offset;
           
        s7.layY = (floor((startSelectY - offset) / gridSize) * gridSize) + offset;
           
        s7.layW = ((ceil((endSelectX - offset) / gridSize) * gridSize)) - ((floor((startSelectX - offset) / gridSize) * gridSize));
            
        s7.layH = ((ceil((endSelectY - offset) / gridSize) * gridSize)) - ((floor((startSelectY - offset) / gridSize) * gridSize));
        
        s7.layerSet = true; // now display save layer: cPanel display()
        c1.cSaved = true;
        c1.saveVisible = true;
        s7.saveVisible = true;
        layerSelect = selectState[0];
        startSelectX = 0;
        endSelectX = 0;
        startSelectY = 0;
        endSelectY = 0;
        readyToSave = false; 
            
    }

    if (s8.saveVisible == false && c1.cSaved == true && s8.layerSet == true && c1.saveVisible == false) 
        
    { // s8.switch save visibility to on, from off
             
        c1.saveVisible = true;
        s8.saveVisible = true;

    }
        
    else if (s8.saveVisible == true && c1.cSaved == true && s8.layerSet == true && c1.saveVisible == true) 
    
    { // s8.switch save visibility to off, from on
            
        c1.saveVisible = false; // controls the cP button draw
        s8.saveVisible = false; // controls the layer draw in the grid
    }

    if (c1.cSaved == false && s8.slotOn == true && layerSelect == selectState[2] && readyToSave == true) 
    
    {  // s8.on click, get values for layer save

        if (endSelectX < startSelectX)
        
        {
                    swap = endSelectX;
                    endSelectX = startSelectX;
                    startSelectX = swap;
        }
                
        if (endSelectY < startSelectY)
        
        {
            swap = endSelectY;
            endSelectY = startSelectY;
            startSelectY = swap;
        }

        s8.layX = (floor((startSelectX - offset) / gridSize) * gridSize) + offset;
           
        s8.layY = (floor((startSelectY - offset) / gridSize) * gridSize) + offset;
           
        s8.layW = ((ceil((endSelectX - offset) / gridSize) * gridSize)) - ((floor((startSelectX - offset) / gridSize) * gridSize));
            
        s8.layH = ((ceil((endSelectY - offset) / gridSize) * gridSize)) - ((floor((startSelectY - offset) / gridSize) * gridSize));
        
        s8.layerSet = true; // now display save layer: cPanel display()
        c1.cSaved = true;
        c1.saveVisible = true;
        s8.saveVisible = true;
        layerSelect = selectState[0];
        startSelectX = 0;
        endSelectX = 0;
        startSelectY = 0;
        endSelectY = 0;
        readyToSave = false; 
            
    }

    if (c1.cSaved == true && s9.layerSet == true && c1.saveVisible == false && s9.saveVisible == false) 
        
    { // s9.switch save visibility to on, from off
             
        c1.saveVisible = true;
        s9.saveVisible = true;

    }
        
    else if (c1.cSaved == true && s9.layerSet == true && c1.saveVisible == true && s9.saveVisible == true) 
    
    { // s9.switch save visibility to off, from on
            
        c1.saveVisible = false; // controls the cP button draw
        s9.saveVisible = false; // controls the layer draw in the grid
    }

    if (c1.cSaved == false && s9.slotOn == true && layerSelect == selectState[2] && readyToSave == true) 
    
    {  // s9.on click, get values for layer save

        if (endSelectX < startSelectX)
        
        {
                    swap = endSelectX;
                    endSelectX = startSelectX;
                    startSelectX = swap;
        }
                
        if (endSelectY < startSelectY)
        
        {
            swap = endSelectY;
            endSelectY = startSelectY;
            startSelectY = swap;
        }

        s9.layX = (floor((startSelectX - offset) / gridSize) * gridSize) + offset;
           
        s9.layY = (floor((startSelectY - offset) / gridSize) * gridSize) + offset;
           
        s9.layW = ((ceil((endSelectX - offset) / gridSize) * gridSize)) - ((floor((startSelectX - offset) / gridSize) * gridSize));
            
        s9.layH = ((ceil((endSelectY - offset) / gridSize) * gridSize)) - ((floor((startSelectY - offset) / gridSize) * gridSize));
        
        s9.layerSet = true; // now display save layer: cPanel display()
        c1.cSaved = true;
        c1.saveVisible = true;
        s9.saveVisible = true;
        layerSelect = selectState[0];
        startSelectX = 0;
        endSelectX = 0;
        startSelectY = 0;
        endSelectY = 0;
        readyToSave = false; 
            
    }

    if (c1.cSaved == true && s10.layerSet == true && c1.saveVisible == false && s10.saveVisible == false) 
        
    { // s10.switch save visibility to on, from off
             
        c1.saveVisible = true;
        s10.saveVisible = true;

    }
        
    else if (c1.cSaved == true && s10.layerSet == true && c1.saveVisible == true && s10.saveVisible == true) 
    
    { // s10.switch save visibility to off, from on
            
        c1.saveVisible = false; // controls the cP button draw
        s10.saveVisible = false; // controls the layer draw in the grid
    }

    if (c1.cSaved == false && s10.slotOn == true && layerSelect == selectState[2] && readyToSave == true) 
    
    {  // s10.on click, get values for layer save

        if (endSelectX < startSelectX)
        
        {
                    swap = endSelectX;
                    endSelectX = startSelectX;
                    startSelectX = swap;
        }
                
        if (endSelectY < startSelectY)
        
        {
            swap = endSelectY;
            endSelectY = startSelectY;
            startSelectY = swap;
        }

        s10.layX = (floor((startSelectX - offset) / gridSize) * gridSize) + offset;
           
        s10.layY = (floor((startSelectY - offset) / gridSize) * gridSize) + offset;
           
        s10.layW = ((ceil((endSelectX - offset) / gridSize) * gridSize)) - ((floor((startSelectX - offset) / gridSize) * gridSize));
            
        s10.layH = ((ceil((endSelectY - offset) / gridSize) * gridSize)) - ((floor((startSelectY - offset) / gridSize) * gridSize));
        
        s10.layerSet = true; // now display save layer: cPanel display()
        c1.cSaved = true;
        c1.saveVisible = true;
        s10.saveVisible = true;
        layerSelect = selectState[0];
        startSelectX = 0;
        endSelectX = 0;
        startSelectY = 0;
        endSelectY = 0;
        readyToSave = false; 
            
    }
}

void clearButtonClicks()

{  // click clear button in cPanel clear 
    if (c1.cSaved == true) { // clear all motherfucking values for the slot
           
        if (s1.slotOn == true){ // check which slot is active, change that slots values
            s1.layX = 0;
            s1.layY = 0;
            s1.layW = 0;
            s1.layH = 0;
            s1.layerSet = false; // s1 layer is no longer set
            c1.cSaved = false; // save icon is not drawn
            c1.saveVisible = true;  // starts as true
            s1.saveVisible = false;// no layer to draw
        }

        if (s2.slotOn == true){ // check which slot is active, change that slots values
            s2.layX = 0;
            s2.layY = 0;
            s2.layW = 0;
            s2.layH = 0;
            s2.layerSet = false; // s2 layer is no longer set
            c1.cSaved = false; // save icon is not drawn
            c1.saveVisible = true;  // starts as true
            s2.saveVisible = false;// no layer to draw
        } 

        if (s3.slotOn == true){ // check which slot is active, change that slots values
            s3.layX = 0;
            s3.layY = 0;
            s3.layW = 0;
            s3.layH = 0;
            s3.layerSet = false; // s3 layer is no longer set
            c1.cSaved = false; // save icon is not drawn
            c1.saveVisible = true;  // starts as true
            s3.saveVisible = false;// no layer to draw
        }            

        if (s4.slotOn == true){ // check which slot is active, change that slots values
            s4.layX = 0;
            s4.layY = 0;
            s4.layW = 0;
            s4.layH = 0;
            s4.layerSet = false; // s4 layer is no longer set
            c1.cSaved = false; // save icon is not drawn
            c1.saveVisible = true;  // starts as true
            s4.saveVisible = false;// no layer to draw
        } 

        if (s5.slotOn == true){ // check which slot is active, change that slots values
            s5.layX = 0;
            s5.layY = 0;
            s5.layW = 0;
            s5.layH = 0;
            s5.layerSet = false; // s5 layer is no longer set
            c1.cSaved = false; // save icon is not drawn
            c1.saveVisible = true;  // starts as true
            s5.saveVisible = false;// no layer to draw
        } 

        if (s6.slotOn == true){ // check which slot is active, change that slots values
            s6.layX = 0;
            s6.layY = 0;
            s6.layW = 0;
            s6.layH = 0;
            s6.layerSet = false; // s6 layer is no longer set
            c1.cSaved = false; // save icon is not drawn
            c1.saveVisible = true;  // starts as true
            s6.saveVisible = false;// no layer to draw
        } 

        if (s7.slotOn == true){ // check which slot is active, change that slots values
            s7.layX = 0;
            s7.layY = 0;
            s7.layW = 0;
            s7.layH = 0;
            s7.layerSet = false; // s7 layer is no longer set
            c1.cSaved = false; // save icon is not drawn
            c1.saveVisible = true;  // starts as true
            s7.saveVisible = false;// no layer to draw
        } 

        if (s8.slotOn == true){ // check which slot is active, change that slots values
            s8.layX = 0;
            s8.layY = 0;
            s8.layW = 0;
            s8.layH = 0;
            s8.layerSet = false; // s8 layer is no longer set
            c1.cSaved = false; // save icon is not drawn
            c1.saveVisible = true;  // starts as true
            s8.saveVisible = false;// no layer to draw
        } 

        if (s9.slotOn == true){ // check which slot is active, change that slots values
            s9.layX = 0;
            s9.layY = 0;
            s9.layW = 0;
            s9.layH = 0;
            s9.layerSet = false; // s9 layer is no longer set
            c1.cSaved = false; // save icon is not drawn
            c1.saveVisible = true;  // starts as true
            s9.saveVisible = false;// no layer to draw
        } 

        if (s10.slotOn == true){ // check which slot is active, change that slots values
            s10.layX = 0;
            s10.layY = 0;
            s10.layW = 0;
            s10.layH = 0;
            s10.layerSet = false; // s10 layer is no longer set
            c1.cSaved = false; // save icon is not drawn
            c1.saveVisible = true;  // starts as true
            s10.saveVisible = false;// no layer to draw
        } 

        }
        else {
            c2.cSaved = false; // if save isn't active, clear slot isn't visible
        }    
}







