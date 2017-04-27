public class Artist{
  GenePolygon[] genomes;
  color[] blueprints;
  int strokeCount;
  
  public Artist(int strokeCount){
    genomes = new GenePolygon[strokeCount];
    blueprints = new color[width * height];
    this.strokeCount = strokeCount;
  }
  
  void createDNA(){
    //blueprints = new color[width * height];
    for(int i = 0;i<strokeCount;i++){
      
        PVector vect1 = new PVector(random(0,width),random(0,height));
        PVector vect2 = new PVector(random(0,width),random(0,height));
        PVector vect3 = new PVector(random(0,width),random(0,height));
        color c = color(random(0,256),random(0,256),random(0,256),100);
        GenePolygon d = new GenePolygon(vect1, vect2, vect3, c);
        genomes[i] = d;
    }
  } 
  
  void mutate(float mutateChance){
    //blueprints = new color[width * height];
    for(int i = 0;i<strokeCount;i++){
      if(random(1) < mutateChance){
        PVector vect1 = new PVector(random(0,width),random(0,height));
        PVector vect2 = new PVector(random(0,width),random(0,height));
        PVector vect3 = new PVector(random(0,width),random(0,height));
        color c = color(random(0,256),random(0,256),random(0,256),100);
        GenePolygon d = new GenePolygon(vect1, vect2, vect3, c);
        genomes[i] = d;
      }
    }
  }   
  
  void translateScreen(){
    //display();
    for(int x = 0;x < width;x++){
      for(int y = 0;y < height;y++){
        blueprints[(x*y) + y] = get(x,y);
      }
    }
  }  
  
  void display(){
    for(int i = 0;i<strokeCount;i++){
      fill(genomes[i].col);
      triangle(genomes[i].v1.x,genomes[i].v1.y, genomes[i].v2.x, genomes[i].v2.y, genomes[i].v3.x, genomes[i].v3.y);
    }
  }  
  
  float calculateFitness(Artist source){
    float fitness = 0;
    float pixelFitness = 0;
    for(int x = 0;x < width;x++){
      for(int y = 0;y < height;y++){
        color c1 = source.blueprints[(x*y) + y];
        color c2 = blueprints[(x*y) + y];
        
        float deltaRed = red(c1) - red(c2);
        float deltaGreen = green(c1) - green(c2);
        float deltaBlue = blue(c1) - blue(c2);
        
        
        pixelFitness = (deltaRed * deltaRed) + (deltaGreen * deltaGreen) + (deltaBlue * deltaBlue);
        
        fitness += pixelFitness;
      }
    }
    
    return fitness;
}  
}