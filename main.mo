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

  // Kullanıcıdan film adını alan ve doğrulayan fonksiyon
  public func MovieName(value: Text) : async Text {
    if (value == "") {
      return "Hata: Film adı boş olamaz.";
    } else {
      tempName := value;
      return "Film adı başarıyla kaydedildi: " # tempName;
    };
  };

  // Kullanıcıdan yılı alan ve doğrulayan fonksiyon
  public func Year(value: Int) : async Text {
    if (value <= 0) {
      return "Hata: Yıl değeri pozitif bir sayı olmalıdır.";
    } else {
      tempYear := value;
      return "Yıl başarıyla kaydedildi: " # Int.toText(tempYear);
    };
  };

  // Kullanıcıdan yönetmeni alan ve doğrulayan fonksiyon
  public func Director(value: Text) : async Text {
    if (value == "") {
      return "Hata: Yönetmen adı boş olamaz.";
    } else {
      tempDirector := value;
      return "Yönetmen adı başarıyla kaydedildi: " # tempDirector;
    };
  };

  // Kullanıcıdan yapımcıyı alan ve doğrulayan fonksiyon
  public func Producer(value: Text) : async Text {
    if (value == "") {
      return "Hata: Yapımcı adı boş olamaz.";
    } else {
      tempProducer := value;
      return "Yapımcı adı başarıyla kaydedildi: " # tempProducer;
    };
  };

  // Kullanıcıdan puanı alan ve doğrulayan fonksiyon
  public func Rating(value: Float) : async Text {
    if (value < 1.0 or value > 10.0) {
      return "Hata: Puan 1.0 ile 10.0 arasında olmalıdır.";
    } else {
      tempRating := value;
      return "Puan başarıyla kaydedildi: " # Float.toText(tempRating);
    };
  };

  // Geçici verileri kontrol edip filmi kaydeden fonksiyon
  public func saveMovie() : async Text {
    if (tempName != "" and
        tempYear != 0 and
        tempDirector != "" and
        tempProducer != "" and
        tempRating != 0.0) {

      let addResult = addMovie(tempName, tempYear, tempDirector, tempProducer, tempRating);

      // Geçici verileri sıfırlama
      tempName := "";
      tempYear := 0;
      tempDirector := "";
      tempProducer := "";
      tempRating := 0.0;

      return addResult;
    } else {
      return "Tüm alanları doldurmanız gerekiyor.";
    };
  };

  // Filmi arşive ekleyen fonksiyon
  func addMovie(name: Text, year: Int, director: Text, producer: Text, rating: Float) : Text {
    let newMovie: Movie = {
      name = name;
      year = year;
      director = director;
      producer = producer;
      rating = rating;
    };

    movieArchive.put(name, newMovie);
    return "Film başarıyla eklendi: " # name;
  };

  // Film detaylarını getiren fonksiyon
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

  // Filmi arşivden silen fonksiyon
  public func removeMovie(movieName: Text) : async Text {
    let removed = movieArchive.remove(movieName);
    switch (removed) {
      case (?movie) {
        return "Film silindi: " # movieName;
      };
      case null {
        return "Film bulunamadı: " # movieName;
      };
    };
  };
}
