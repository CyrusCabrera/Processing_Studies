import java.util.*;

public class DNA{
  List<PVector> trianglePoints = new ArrayList<PVector>();
  color triangleColor;
  public DNA(int population){
    for(int i = 0;i<population;i++){
      trianglePoints.add(new PVector(random(0,width),random(0,height)));
    }
    
    triangleColor = color(random(0,256),random(0,256),random(0,256),100);
  }
}