Table table;
int nSamples;
float[] releaseYear;
float[] duration;
String[] type;
color col;


void setup() {
  size(1200, 800);

  // Cargar los datos
  table = loadTable("netflix_titles.csv", "header");

  // Guardar el número de filas en la tabla
  nSamples = table.getRowCount();

  // Inicializamos los arrays
  releaseYear = new float[nSamples];
  duration = new float[nSamples];
  type = new String[nSamples];
  

  // Asignamos los datos
  for (int i = 0; i < nSamples; i++) {
    releaseYear[i] = table.getFloat(i, "release_year");
    type[i] = table.getString(i, "type");
    
    //Como la duracion es diferente para peliculas y series, hay que hacer la separación
    //Para peliculas son minutos y para series son temporadas
    //Por ejemplo: "134 min" o "2 Seasons", separados por un espacio
    String duracionTexto = table.getString(i, "duration");
    String[] list = split(duracionTexto, ' ');
    // list[0] es "134", list[1] es "min"...
    
    duration[i] = float(list[0]);
    
  }
}

void draw() {
  background(0);

  for (int i = 0; i < nSamples; i++) {
    
    //Map del año 
    float x = map(releaseYear[i], min(releaseYear), max(releaseYear), 50, width-20);
    
    //Map de la duración
    //como la duracion es diferente en peliculas y series, toca separarlas
    float y;
    if(type[i].equals("Movie")){
      y = map(duration[i], 0, max(duration), height-50, 20);
    }
    else{
      y = map(duration[i], 0, 10, height-50, 20);
    }

    //Si es pelicula, se pinta de azul, y si es TV Show se pinta de verde
    //Esto lo hace leyendo la columna "type"
    if(type[i].equals("Movie")){
      col=#092EBC;
    }
    else{
      col=#11BC09;
    }
    
    fill(col);
    noStroke();
    circle(x, y, 10);
  }
  
  strokeWeight(3);
  stroke(255);
  strokeWeight(1);
  line(10,760,1190,760);
  line(20,10,20,780);
  
  noFill();
  rect(30,30,100,100);
  fill(255);
  text("Películas",60,50);
  text("Series",60,70);
  
  text("Año",60,100);
  line(40,95,55,95);
  line(50,90,55,95);
  line(50,100,55,95);
  
  text("Duración",60,120);
  line(50,110,50,125);
  line(50,110,45,115);
  line(50,110,55,115);
  
  
  noStroke();
  fill(#092EBC);
  circle(50,45,10);
  fill(#11BC09);
  circle(50,65,10);
}
