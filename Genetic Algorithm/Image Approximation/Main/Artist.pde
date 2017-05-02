public class Artist{
  GenePolygon[] genomes;
  int strokeCount;
  
  public Artist(int strokeCount){
    genomes = new GenePolygon[strokeCount];
    this.strokeCount = strokeCount;
  }
  
  void createDNA(color[] bestMatrix){
    //blueprints = new color[width * height];
    for(int i = 0;i<strokeCount;i++){
      
        PVector vect1 = new PVector(random(0,width+1),random(0,height+1));
        PVector vect2 = new PVector(random(0,width+1),random(0,height+1));
        PVector vect3 = new PVector(random(0,width+1),random(0,height+1));
        color c = color(random(0,256),random(0,256),random(0,256),100);
        //color c = bestMatrix[floor(random(0,bestMatrix.length))];
        GenePolygon d = new GenePolygon(vect1, vect2, vect3, color(red(c), green(c), blue(c), 100));
        genomes[i] = d;
    }
  } 
  
  void mutate(float mutateChance, color[] bestMatrix){
    //blueprints = new color[width * height];
    for(int i = 0;i<strokeCount;i++){
      if(random(1) < mutateChance){
        PVector vect1 = new PVector(random(0,width+1),random(0,height+1));
        PVector vect2 = new PVector(random(0,width+1),random(0,height+1));
        PVector vect3 = new PVector(random(0,width+1),random(0,height+1));
        color c = color(random(0,256),random(0,256),random(0,256),100);
        //color c = bestMatrix[floor(random(0,bestMatrix.length))];
        GenePolygon d = new GenePolygon(vect1, vect2, vect3, color(red(c), green(c), blue(c), 100));
        genomes[i] = d;
      }
    }
  }   
  
  color[] translateScreen(){
    //display();
    color[] blueprints = new color[width * height];
   for(int y = 0;y < height;y++){
      for(int x = 0;x < width;x++){
        blueprints[(y*width) + x] = get(x,y);
      }
    }
    
    return blueprints;
  }  
  
  void display(){
    for(int i = 0;i<strokeCount;i++){
      fill(genomes[i].col);
      triangle(genomes[i].v1.x,genomes[i].v1.y, genomes[i].v2.x, genomes[i].v2.y, genomes[i].v3.x, genomes[i].v3.y);
    }
  }  
  
  float calculateFitness(color[] source){
    float fitness = 0;
    float pixelFitness = 0;
    
    background(255);
    display();
    color[] blueprints = translateScreen();
    
    for(int y = 0;y < height;y++){
      for(int x = 0;x < width;x++){
        color c1 = source[(y*width) + (x)];
        color c2 = blueprints[(y*width) + (x)];
        
        float deltaRed = red(c1) - red(c2);
        float deltaGreen = green(c1) - green(c2);
        float deltaBlue = blue(c1) - blue(c2);
        
        
        pixelFitness = (deltaRed * deltaRed) + (deltaGreen * deltaGreen) + (deltaBlue * deltaBlue);
        
        fitness += pixelFitness;
        
        //if(pixelFitness == 0){
        //    fitness++;
        //}
      }
    }
    
    //return sqrt(fitness) / (width*height);
    ///println(fitness);
    return fitness / (width*height);
}  
}