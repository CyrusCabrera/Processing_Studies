import java.util.*;
int triangleCount = 125;
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


int genMod = 100;

Artist bestArtist;
List<Artist> population = new ArrayList<Artist>();
List<Artist> candidates = new ArrayList<Artist>();
int popSize = 5;
int eliteCount = floor(popSize * 0.50);

int candidateLimit = 20;
float lowestFitness = 0;
void setup(){
  background(0);
  noStroke();
  
  size(200,200);
  String url = "http://vignette1.wikia.nocookie.net/thesarahjaneadventures/images/c/cb/Mona-Lisa-200x200.jpg/revision/latest?cb=20101125182139";
  img = loadImage(url,"jpg");
  img.resize(200, 200);
  image(img,0,0);
  bestArtist = new Artist(triangleCount);
  bestMatrix = bestArtist.translateScreen();
  background(255);
  
  for(int i = 0;i<popSize;i++){
    Artist a = new Artist(triangleCount);
    a.createDNA(bestMatrix);
    population.add(a);
    
  }
  
  
}

void draw(){
  naturalSelection();
  crossOver();
  background(255);
  //scale(1);
  //println("Object state: ",topArtist);
  if((generationCount % genMod) == 0){
    topArtist.display();
  }
  
  println("Generation: ",generationCount, "Accuracy: ",topArtist.calculateFitness(bestMatrix));
  generationCount++;
}

void elitism(){
}

void naturalSelection(){
  candidates.clear();
  //float lowest = getLowest();
  for(int i = 0;i<popSize;i++){
    float fitness = population.get(i).calculateFitness(bestMatrix);
    //fitness = fitness * 100;
    if(maxFitness == 0){
      maxFitness = fitness;
    }
    
    if(fitness < maxFitness){
      maxFitness = fitness;
      topArtist = population.get(i);
    }
    
   // println(fitness,":",map(fitness,0, maxFitness,50,0));
    float probability = 1;
    if(fitness > maxFitness){
      probability = 1 - ((fitness - maxFitness) / maxFitness);
      //probability = map(fitness, 0, width*height, 0,1);
    }
    
    //println("Probability: ",fitness,"======>",probability);
    int n = floor(abs(probability)*100);
    
    //println("Frequency: ", n);
    for(int x = 0;x<n;x++){
      candidates.add(population.get(i));
    }
  }
  
  

  //println("Candidate size: ",candidates.size());
}

void crossOver(){
  population.clear();


  for(int i = 0;i<popSize - eliteCount;i++){
    int mate1 = floor(random(0,candidates.size()));
    int mate2 = floor(random(0,candidates.size()));
    
    Artist a1 = candidates.get(mate1);
    Artist a2 = candidates.get(mate2);
    
    int crossOverPoint = floor(random(0,a1.genomes.length));
    int swapOn = floor(random(0,2));
    GenePolygon[] child = new GenePolygon[a1.genomes.length];
    
    for(int k = 0;k<crossOverPoint;k++){
      child[k] = a1.genomes[k];
      //swapOn = floor(random(0,2));
      //if(swapOn == 1){
      //  swapOn = 0;
      //  child[k] = a1.genomes[k];
      //}else{
      //  swapOn = 1;
      //  child[k] = a2.genomes[k];
      //}
    }
    
    
    for(int k = crossOverPoint;k<a1.genomes.length;k++){
      child[k] = a2.genomes[k];
    }
    
    Artist newGen = new Artist(triangleCount);
    newGen.genomes = child;
    newGen.mutate(0.01, bestMatrix);
    
    if(topArtist == null){
      topArtist = newGen;
    }
    
    population.add(newGen);
  }
  
  for(int i = 0;i<eliteCount;i++){
    population.add(topArtist);
  }  
    
  
}