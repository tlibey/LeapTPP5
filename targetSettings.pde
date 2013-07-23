
public class cTargets
{
  int numTargets=9;
  int maxNumTargets = 100;
  int[] iTarHoldTimes; 
  int[] iTarHeight; 
  int[] iTarWidth; 
  int[] iTarX; 
  int[] iTarY; 
  int[] iTarProbability; 
  int[] iTarHoldTimesTit; 
  int[] iTarHeightTit; 
  int[] iTarWidthTit; 
  int[] iTarXTit; 
  int[] iTarYTit; 
  int[] iTarProbabilityTit; 
  int currentTarget = 0;
  boolean tarHolding = false;
  float tarTimer = 0;
  
  String fileName;
  String baseFileName = "defaultTargetSettings.csv";
  String fileExt = ".csv";
  Table targetSettings;
  boolean updating = false;
  boolean loading = false;
  boolean saving = false;
  PFont guiFont = createFont("Arial",12,true);
  boolean gettingString = false;
  String stringbuffer = "";
  
  cTargets()
  {
    fileName = baseFileName;
    
    iTarHoldTimes = new int[maxNumTargets];
    iTarHeight = new int[maxNumTargets];
    iTarWidth = new int[maxNumTargets];
    iTarX = new int[maxNumTargets];
    iTarY = new int[maxNumTargets];
    iTarProbability = new int[maxNumTargets];
    
    iTarHoldTimesTit = new int[maxNumTargets];
    iTarHeightTit = new int[maxNumTargets];
    iTarWidthTit = new int[maxNumTargets];
    iTarXTit = new int[maxNumTargets];
    iTarYTit = new int[maxNumTargets];
    iTarProbabilityTit = new int[maxNumTargets];
  }

  cTargets(int iNumTargets)
  {
    fileName = baseFileName;
    numTargets = iNumTargets;
      iTarHoldTimes = new int[maxNumTargets];
    iTarHeight = new int[maxNumTargets];
    iTarWidth = new int[maxNumTargets];
    iTarX = new int[maxNumTargets];
    iTarY = new int[maxNumTargets];
    iTarProbability = new int[maxNumTargets];
    
    iTarHoldTimesTit = new int[maxNumTargets];
    iTarHeightTit = new int[maxNumTargets];
    iTarWidthTit = new int[maxNumTargets];
    iTarXTit = new int[maxNumTargets];
    iTarYTit = new int[maxNumTargets];
    iTarProbabilityTit = new int[maxNumTargets];
   
  }

  cTargets(String fName)
  {
    baseFileName = fName;
    fileName = baseFileName;
      iTarHoldTimes = new int[maxNumTargets];
    iTarHeight = new int[maxNumTargets];
    iTarWidth = new int[maxNumTargets];
    iTarX = new int[maxNumTargets];
    iTarY = new int[maxNumTargets];
    iTarProbability = new int[maxNumTargets];
    
    iTarHoldTimesTit = new int[maxNumTargets];
    iTarHeightTit = new int[maxNumTargets];
    iTarWidthTit = new int[maxNumTargets];
    iTarXTit = new int[maxNumTargets];
    iTarYTit = new int[maxNumTargets];
    iTarProbabilityTit = new int[maxNumTargets];
  
  }

  cTargets(int iNumTargets, String fName)
  {
    baseFileName = fName;
    fileName = baseFileName;
    numTargets = iNumTargets;
    iTarHoldTimes = new int[maxNumTargets];
    iTarHeight = new int[maxNumTargets];
    iTarWidth = new int[maxNumTargets];
    iTarX = new int[maxNumTargets];
    iTarY = new int[maxNumTargets];
    iTarProbability = new int[maxNumTargets];
    
    iTarHoldTimesTit = new int[maxNumTargets];
    iTarHeightTit = new int[maxNumTargets];
    iTarWidthTit = new int[maxNumTargets];
    iTarXTit = new int[maxNumTargets];
    iTarYTit = new int[maxNumTargets];
    iTarProbabilityTit = new int[maxNumTargets];
  }

void updateTarget()
{
    int id = currentTarget;
    rect(iTarX[id],iTarY[id],iTarWidth[id],iTarHeight[id]);
}


  void updateSettings()
  {
  
    if(gettingString)
    {
    fill(textColor);
    stringFunction();
    textFont(guiFont,12);
    String displayText = "";
    if(loading)
    { displayText = "Load File: " + stringbuffer;}
    else if(saving)
    {displayText = "Saving File: " +stringbuffer;}
    s1.text(displayText,10,150);
    
  }
    
    else{

    //background(0);
    if(keyPressed)
    {
    if (key == 'Q'||key =='q')
    {
      updating = false;
    }
    if (key == 'T'||key =='t')
    {
      updating = true;
    }
    
    }
    if (updating)
    { 
      if ((key == 'S'||key =='s'))
      {
       //create new file name based on input string
        saving = true;
       gettingString = true;
       stringbuffer = "";
       delay(100);
       
      
      }
         else if(keysPressed['S'] && keysPressed[CONTROL] && !keysPressed[SHIFT])
     {
       //create new file name based on date and time 
         String date = String.valueOf(day())+String.valueOf(month())+String.valueOf(year()); 
         String time = String.valueOf(hour()) + "-" + String.valueOf(minute());
       //update fileName
        fileName = baseFileName.substring(0,baseFileName.length()-4) + "_" + date + "_" + time + ".csv";
        saveSettings();
        s1.println("SettingsSaved");
     }
     
      else if(keyPressed && keysPressed['S'] && keysPressed[CONTROL] && keysPressed[SHIFT])
      {
        //overwrite Original File with current parameters
         fileName = baseFileName;
        delay(500);
        saveSettings();
        delay(100);
        s1.println("SettingsSavedOverwrite");
        
         

      }
      
    
     
      else if(keysPressed['L'])
     {
       loading = true;
       gettingString = true;
       stringbuffer = "";
       delay(100);
     } 
     
    
      
      if(loading && stringbuffer.length()>0)
      {
        
         try{
         fileName = stringbuffer + fileExt;
         loadSettings();
         baseFileName = fileName;
         s1.println("loaded: " + baseFileName);
         } 
         catch(Exception e)
         {
          s1.println("file failed to load"); 
         }
          loading = false;
         stringbuffer = "";
        
      }
      
      else if(saving && stringbuffer.length()>0)
      {
       try{
        fileName = stringbuffer + fileExt;
       saveSettings();
       baseFileName = fileName;
       s1.println("Saved new File:" + baseFileName);
       }
      catch(Exception e)
     {
      s1.println("Failed to save new file");
     } 
     saving = false;
     stringbuffer="";
      }
      else if ((loading||saving) && stringbuffer.length()==0 && gettingString==false)
      {
       loading = false; 
       saving = false;
      }
      
      
    //updating gui
    fill(textColor);
    s1.textFont(guiFont,12);
    s1.text("Target Options: S_saveNew; Ctrl+S_SaveNewWDate;",10,150);
    s1.text("Ctrl+Shift+S_Overwrite; L_LoadNew; Q_quit;",10,165);
    s1.text("Current File: " + baseFileName, 10, 180);
    }
    }
  }

  void loadSettings()
  {
    Table targetSettingsload = loadTable(fileName, "header");
    println("test");
    numTargets = targetSettingsload.getRowCount();
    currentTarget = (int)random(numTargets);

    for (TableRow row: targetSettingsload.rows())
    {
      int TarNumber = row.getInt("TarNumber");
      iTarHoldTimes[TarNumber-1] = row.getInt("TarHoldTime");
      iTarHeight[TarNumber-1] = row.getInt("TarHeight");
      iTarWidth[TarNumber-1] = row.getInt("TarWidth");
      iTarX[TarNumber-1] = row.getInt("TarX");
      iTarY[TarNumber-1] = row.getInt("TarY");
      iTarProbability[TarNumber-1] = row.getInt("TarProbability");
      iTarHoldTimesTit[TarNumber-1] = row.getInt("TarHoldTimeTit");
      iTarHeightTit[TarNumber-1] = row.getInt("TarHeightTit");
      iTarWidthTit[TarNumber-1] = row.getInt("TarWidthTit");
      iTarXTit[TarNumber-1] = row.getInt("TarXTit");
      iTarYTit[TarNumber-1] = row.getInt("TarYTit");
      iTarProbabilityTit[TarNumber-1] = row.getInt("TarProbabilityTit");
    }
  }

  void saveSettings()
  {
    Table targetSettingsNew = new Table();
    targetSettingsNew.addColumn("TarNumber");
    
    targetSettingsNew.addColumn("TarHoldTime");
    targetSettingsNew.addColumn("TarHeight");
    targetSettingsNew.addColumn("TarWidth");
    targetSettingsNew.addColumn("TarX");
    targetSettingsNew.addColumn("TarY");
    targetSettingsNew.addColumn("TarProbability");

    
    targetSettingsNew.addColumn("TarHoldTimeTit");
    targetSettingsNew.addColumn("TarHeightTit");
    targetSettingsNew.addColumn("TarWidthTit");
    targetSettingsNew.addColumn("TarXTit");
    targetSettingsNew.addColumn("TarYTit");
    targetSettingsNew.addColumn("TarProbabilityTit");

    for (int ii = 0; ii<numTargets;ii++)
    {
      TableRow newRow = targetSettingsNew.addRow();
      newRow.setInt("TarNumber", ii+1);
      
      newRow.setInt("TarHoldTime", iTarHoldTimes[ii]); 
      newRow.setInt("TarHeight", iTarHeight[ii]); 
      newRow.setInt("TarWidth", iTarWidth[ii]); 
      newRow.setInt("TarX", iTarX[ii]); 
      newRow.setInt("TarY", iTarY[ii]);
      newRow.setInt("TarProbability", iTarProbability[ii]);
      
      newRow.setInt("TarHoldTimeTit", iTarHoldTimes[ii]); 
      newRow.setInt("TarHeightTit", iTarHeight[ii]); 
      newRow.setInt("TarWidthTit", iTarWidth[ii]); 
      newRow.setInt("TarXTit", iTarX[ii]); 
      newRow.setInt("TarYTit", iTarY[ii]);
      newRow.setInt("TarProbabilityTit", iTarProbability[ii]);
    }
    saveTable(targetSettingsNew, fileName);
  }
  
  
void stringFunction()
{
 // for(char test = 'A'; test<'z'; test++)
 //{
   if(keyPressed && ((key>='A' && key <= 'z') || (key>='0' && key<='9')))
      {
      stringbuffer = stringbuffer+key;
      delay(100);
      }
// } 
 else if(keysPressed[DELETE])
 {
  stringbuffer = ""; 
 }
 else if(keysPressed[ENTER])
 {
  gettingString = false; 
 }
 else if(keysPressed[BACKSPACE])
 {
   if(stringbuffer.length()>0)
   {
   stringbuffer = stringbuffer.substring(0,stringbuffer.length() - 1);
   delay(100);
   }
 }
 
}
}
void keyPressed()
{
  keysPressed[keyCode] = true;
}

void keyReleased()
{
  keysPressed[keyCode] = false;
}



