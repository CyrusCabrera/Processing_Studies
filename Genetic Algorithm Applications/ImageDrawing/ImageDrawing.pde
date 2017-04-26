int populationCount = 500;
int pixLength = 200;
int triangleCount = 20;
PImage img;
Artist[] artists = new Artist[populationCount];
color[] bestCriteria = new color[pixLength * pixLength];
void setup(){
  size(200,200);
  String url = "http://vignette1.wikia.nocookie.net/thesarahjaneadventures/images/c/cb/Mona-Lisa-200x200.jpg/revision/latest?cb=20101125182139";
  img = loadImage(url,"jpg");
  image(img, 0, 0);
  transformBestCriteria();
  noStroke();
  
  //createPopulation(populationCount);
}

void transformBestCriteria(){
  for(int x = 0;x<width;x++){
    for(int y = 0;y<height;y++){
      //println(x,y);
      bestCriteria[(x*y) + y] = get(x,y);
    }
  }
}

void createPopulation(int populationCount){
  for(int i = 0;i<populationCount;i++){
      artists[i] = new Artist(triangleCount);
  }
}

void draw(){

}

void display(){
  for(Artist artist: artists){
    for(DNA d: artist.dnaList){
      fill(d.triangleColor);
      triangle(d.trianglePoints.get(0).x,d.trianglePoints.get(0).y,
               d.trianglePoints.get(1).x,d.trianglePoints.get(1).y,
               d.trianglePoints.get(2).x,d.trianglePoints.get(2).y);
    }
  }
}