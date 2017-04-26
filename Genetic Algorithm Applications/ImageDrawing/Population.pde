public class Population{
  DNA[] dnaList;
  int size;
  public Population(int numPop){
    dnaList = new DNA[numPop];
    size = numPop;
    
    
    for(int i = 0;i<numPop;i++){
      dnaList[i] = new DNA(3);
    }
  }
}