import 'dart:convert';
import 'package:fluttermovie/models/searchmodel.dart';
import 'package:http/http.dart' as http;

import 'package:fluttermovie/models/moviemodel.dart';
import 'package:fluttermovie/models/featuredmoviemodel.dart';

//Tích hợp api thông qua api.dart và genremodel
// liên kết giao diện người dùng với api bằng home_screen và homepagefeaturewidget
import 'models/genremodel.dart';

//Lớp Api sẽ chịu trách nhiệm gọi backend mỗi khi bạn gọi một trong các hàm của nó.
class Api {
  static var httpClient = http.Client();
  var data = [];
  List<SearchModel> results = [];
  // Bên trong lớp này đặt các biến sau:
  static const url = "https://api.themoviedb.org/3";
  // static const urlBase = 'https://api.themoviedb.org/3/movie';
  static const apiKey = "22029fdd6e2d58caa827696931864516";
  // static const urlSearch =
  //     'https://api.themoviedb.org/3/search/movie?api_key=${apiKey}&language=en-US&page=1&include_adult=false';
  // static const urlUpcoming = '/upcoming?';
  // static const urlLanguage = '&language=en-US';
  //Hàm getGenreList() nó là một async(kh đồng bộ) và trả về một future
  //Hàm này trả về một future kiểu danh sách kiểu GenreModel
  Future<List<GenreModel>> getGenreList() async {
    //Thiết lập một biến phản hồi (final response)
    //Nó sẽ thông qua apiKey và http.get, url để lấy về thể loại/phim/danh sách
    final response =
        await http.get(Uri.parse('$url/genre/movie/list?api_key=$apiKey'));
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    // kiểm tra xem mã trạng thái response có phải là 200 hay không, điều này về cơ bản trong http có nghĩa là mọi thứ đã ổn
    if (response.statusCode == 200) {
      final parsed =
          json.decode(response.body)['genres'].cast<Map<String, dynamic>>();

      //Sau đó, trả lại nó dưới dạng danh sách
      return parsed
          .map<GenreModel>((json) => GenreModel.fromJson(json))
          .toList();
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<List<FeaturedMovieModel>> getFeaturedMovies() async {
    final response =
        await http.get(Uri.parse('$url/trending/movie/day?api_key=$apiKey'));
    print(response.body);
    if (response.statusCode == 200) {
      final parsed =
          json.decode(response.body)['results'].cast<Map<String, dynamic>>();
      print(parsed);
      return parsed
          .map<FeaturedMovieModel>((json) => FeaturedMovieModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load featured movies');
    }
  }

  Future<MovieModel> getMovieInfo(int movieId) async {
    final response =
        await http.get(Uri.parse("$url/movie/$movieId?api_key=$apiKey"));

    if (response.statusCode == 200) {
      return MovieModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Movie Information');
    }
  }

  Future<List<SearchModel>> getSearchList({String? MovieName}) async {
    try {
      final response =
          await http.get(Uri.parse("$url/movie/popular?api_key=$apiKey"));
      if (response.statusCode == 200) {
        data =
            json.decode(response.body)['results'].cast<Map<String, dynamic>>();
        results = data.map((e) => SearchModel.fromJson(e)).toList();
        if (MovieName != null) {
          results = results
              .where((element) => element.original_title
                  .toLowerCase()
                  .contains((MovieName.toLowerCase())))
              .toList();
        }
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return results;
  }
}

//FeaturedMovieModel = TrendingMovie
String getPosterImage(String input) {
  return "https://image.tmdb.org/t/p/original/$input";
}

// hình ảnh áp phích mà chúng ta nhận được từ API không phải là url đầy đủ, vì vậy ta tạo một hàm getPosterImage trong thư mục api.dart
//Hàm này dành riêng cho TMDb api và trả về url hình ảnh đầy đủ
// String getVidep(String input) {
//   return "https://api.themoviedb.org/3/movie/297762/videos?api_key=$apiKey&language=en-US/$input";
// }

