void saveButtonClicks()  
{  // MAGIC FIX + click save button in cPanel 

        
    if (s1.layerVisible == false && s1.slotOn == true && s1.layerSet == true) 
        
    { // s1.switch save visibility to on, from off
               
        s1.layerVisible = true; // this is for the layer draw

    }
        
    else if (s1.layerVisible == true && s1.slotOn == true && s1.layerSet == true) 
    
    { // s1.switch save visibility to off, from on
                
        s1.layerVisible = false; // controls the layer draw in the grid
    }

    if (s1.layerSet == false && s1.slotOn == true && layerSelect == selectState[2] && readyToSave == true) 
    
    {  // MAGIC FIX + s1.on click, get values for layer save 

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
        
        s1.layerSet = true; // now display layer if layerVisible is true
        s1.layerVisible = true;
        layerSelect = selectState[0];
        startSelectX = 0;
        endSelectX = 0;
        startSelectY = 0;
        endSelectY = 0;
        readyToSave = false; 
            
    }