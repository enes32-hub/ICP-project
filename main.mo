import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Int "mo:base/Int";
import Float "mo:base/Float";

actor {
type Movie = {
  name: Text;
  year: Int;
  director: Text;
  producer: Text;
  rating: Float; 
};
var movieArchive = HashMap.HashMap<Text, Movie>(0, Text.equal, Text.hash);
var tempName: Text = "";
var tempYear: Int = 0;
var tempDirector: Text = "";
var tempProducer: Text = "";
var tempRating: Float = 0.0;
public func MovieName(value: Text) : async Text {
  tempName := value;
  return tempName; 
};

public func Year(value: Int) : async Int {
  tempYear := value;
  return tempYear;
};

public func Director(value: Text) : async Text {
  tempDirector := value;
  return tempDirector;
};

public func Producer(value: Text) : async Text {
  tempProducer := value;
  return tempProducer;
};

public func Rating(value: Float) : async Float {
  tempRating := value;
  return tempRating;
};

public func saveMovie() : async Text {
  if (tempName != "" and 
      tempYear != 0 and
      tempDirector != "" and
      tempProducer != "" and
      tempRating != 0.0) {
      

    addMovie(tempName, tempYear, tempDirector, tempProducer, tempRating);

    let savedMovieName = tempName;
    

    tempName := "";
    tempYear := 0;
    tempDirector := "";
    tempProducer := "";
    tempRating := 0.0;
    
    return "Film kaydedildi: " # savedMovieName;
  } else {
    return "Tüm alanları doldurmanız gerekiyor.";
  };
};


func addMovie(name: Text, year: Int, director: Text, producer: Text, rating: Float) {
  if (rating < 1.0 or rating > 10.0) {

    return;
  };
  
  let newMovie: Movie = {
    name = name;
    year = year;
    director = director;
    producer = producer;
    rating = rating;
  };
  
  movieArchive.put(name, newMovie); 
};
public func getMovieDetails(movieName: Text) : async Text {
  let movieOption = movieArchive.get(movieName);
  switch (movieOption) {
    case (?movie) {

      return "Film Adı: " # movie.name #
              "\nYıl: " # Int.toText(movie.year) #
              "\nYönetmen: " # movie.director #
              "\nYapımcı: " # movie.producer #
              "\nPuan: " # Float.toText(movie.rating);
    };
    case null {
      return "Film bulunamadı: " # movieName;
    };
  };
};
  public func removeMovie(movieName: Text) : async Text {
  let removed = movieArchive.remove(movieName);
  switch (removed) {
    case (?name) {
      return "Movie removed: " # movieName;
    };
    case null {
      return "Movie not found: " # movieName;
    };
  };
};
}
