public class Artist{
  DNA[] dnaList;
  int size;
  public Artist(int numPop){
    dnaList = new DNA[numPop];
    size = numPop;
    
    
    for(int i = 0;i<numPop;i++){
      dnaList[i] = new DNA(3);
    }
  }
  
  int calculateFitness(){
    for(int x = 0;x<width;x++){
      for(int y = 0;y<height;y++){
        color c1 = get(x,y);
        
        float red = red(c1);
        float blue = blue(c1);
        float green = green(c1);
        
        
      }
    }
    return 0;
  }
}