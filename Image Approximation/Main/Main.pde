import java.util.*;
int triangleCount = 250;
GenePolygon[] p1 = new GenePolygon[triangleCount];
GenePolygon[] c1 = new GenePolygon[triangleCount];

GenePolygon[] bestGen = null;

PImage img;
PImage parentImage;
PImage childImage;
color[] bestMatrix;
color[] parentMatrix;
color[] childMatrix;

Artist topArtist;

float currentFit = 0.0;
int generationCount = 0;
float maxFitness = 0.0;
float prevFit = 0.0;

int eliteCount = 5;

Artist bestArtist;
List<Artist> population = new ArrayList<Artist>();
List<Artist> candidates = new ArrayList<Artist>();
int popSize = 10;

int candidateLimit = 20;
float lowestFitness = 0;
void setup(){
  background(0);
  noStroke();
  
  size(100,100);
  String url = "http://www.juventus.com/media/images/black-and-white-and-more/Open_graph_image_BWM.jpg";
  img = loadImage(url,"jpg");
  img.resize(100, 100);
  image(img,0,0);
  bestArtist = new Artist(triangleCount);
  bestArtist.translateScreen();
  background(255);
  
  for(int i = 0;i<popSize;i++){
    Artist a = new Artist(triangleCount);
    a.createDNA();
    a.display();
    a.translateScreen();
    population.add(a);
    
  }
  
  
}

float getLowest(){
  
  for(int i = 0;i<popSize;i++){
    float fitness = population.get(i).calculateFitness(bestArtist);
    if(fitness > lowestFitness){
       lowestFitness = fitness; 
    }
  }
  
  return lowestFitness;
}

void draw(){
  naturalSelection();
  crossOver();
  background(255);
  //println("Object state: ",topArtist);
  topArtist.display();
  println("Generation: ",generationCount);
  generationCount++;
}

void elitism(){
}

void naturalSelection(){
  candidates.clear();
  //float lowest = getLowest();
  for(int i = 0;i<popSize;i++){
    float fitness = population.get(i).calculateFitness(bestArtist);
    //fitness = fitness * 100;
    if(maxFitness == 0){
      maxFitness = fitness;
    }
    
    if(fitness < maxFitness){
      maxFitness = fitness;
      eliteCount = 5;
      println("Elite count: ", eliteCount);
      topArtist = population.get(i);
    }
    
   // println(fitness,":",map(fitness,0, maxFitness,50,0));
    float probability = 0;
    if(maxFitness == 0.0){
    }else{
      probability = map(fitness,maxFitness,0,1,0);
    }
    
    //println("Probability: ",fitness,"======>",probability);
    int n = floor(abs(probability)*100) + 1;
    
    //println("Frequency: ", n);
    for(int x = 0;x<n;x++){
      candidates.add(population.get(i));
    }
  }
  
  

  //println("Candidate size: ",candidates.size());
}

void crossOver(){
  population.clear();

  for(int i = 0;i<eliteCount;i++){
    population.add(topArtist);
  }  
  
  for(int i = 0;i<popSize - eliteCount;i++){
    int mate1 = floor(random(0,candidates.size()));
    int mate2 = floor(random(0,candidates.size()));
    
    Artist a1 = candidates.get(mate1);
    Artist a2 = candidates.get(mate2);
    
    int crossOverPoint = floor(random(0,a1.genomes.length));
    
    GenePolygon[] child = new GenePolygon[a1.genomes.length];
    for(int k = 0;k<crossOverPoint;k++){
      child[k] = a1.genomes[k];
    }
    
    for(int k = crossOverPoint;k<a1.genomes.length;k++){
      child[k] = a2.genomes[k];
    }
    
    Artist newGen = new Artist(triangleCount);
    newGen.genomes = child;
    newGen.display();
    background(255);
    newGen.translateScreen();
    
    newGen.mutate(0.01);
    newGen.display();
    newGen.translateScreen();
    
    if(topArtist == null){
      topArtist = newGen;
    }
    
    population.add(newGen);
  }
  
}