// 📦 Package imports:
import 'package:get/get.dart';

// 🌎 Project imports:
import '../../Models/movie_detail_model.dart';
import '../../Models/movie_model.dart';
import '../../Models/review_model.dart';
import '../../Utils/connection.dart';
import '../../Views/Movie/movie_detail_screen.dart';
import '../Constant/api_url.dart';
import '../Widget/snack_bar.dart';

class MovieController extends GetxController {
  var page = 1.obs;
  var isLoading = true.obs;

  @override
  void onInit() async {
    ///get now playing
    await getNowPlaying(page.value);

    ///get upcoming
    await getUpcoming(page.value);

    ///get popular movie
    await getPopularMovie(page.value);

    ///stop loading shimmer
    isLoading.value = false;
    super.onInit();
  }

  Rx<MovieModel> nowPlaying = MovieModel(
          dates: Dates(maximum: DateTime.now(), minimum: DateTime.now()),
          page: 1,
          results: [],
          totalPages: 0,
          totalResults: 0)
      .obs;

  Rx<MovieModel> upComing = MovieModel(
          dates: Dates(maximum: DateTime.now(), minimum: DateTime.now()),
          page: 1,
          results: [],
          totalPages: 0,
          totalResults: 0)
      .obs;

  Rx<MovieModel> popular = MovieModel(
          dates: Dates(maximum: DateTime.now(), minimum: DateTime.now()),
          page: 1,
          results: [],
          totalPages: 0,
          totalResults: 0)
      .obs;

  Future getNowPlaying(int page) async {
    Uri uri = Uri.parse('$getNowPlayingUrl?page=$page');
    var response = await Connection(uri: uri).get();
    if (response.statusCode == 200) {
      MovieModel data = nowPlayingModelFromJson(response.body);
      if (page > 1) {
        nowPlaying.value.page = data.page;
        nowPlaying.value.results.addAll(data.results);
      } else {
        nowPlaying.value = data;
      }

      return;
    } else {
      showSnackBar(message: '${response.body} : ${response.statusCode}', isWarning: true);
      return;
    }
  }

  Future getUpcoming(int page) async {
    Uri uri = Uri.parse('$getUpcomingUrl?page=$page');
    var response = await Connection(uri: uri).get();
    if (response.statusCode == 200) {
      MovieModel data = nowPlayingModelFromJson(response.body);
      if (page > 1) {
        upComing.value.page = data.page;
        upComing.value.results.addAll(data.results);
      } else {
        upComing.value = data;
      }
      return;
    } else {
      showSnackBar(message: '${response.body} : ${response.statusCode}', isWarning: true);
      return;
    }
  }

  Future getPopularMovie(int page) async {
    Uri uri = Uri.parse('$getPopularMovieUrl?page=$page');
    var response = await Connection(uri: uri).get();
    if (response.statusCode == 200) {
      MovieModel data = nowPlayingModelFromJson(response.body);
      if (page > 1) {
        popular.value.page = data.page;
        popular.value.results.addAll(data.results);
      } else {
        popular.value = data;
      }
      return;
    } else {
      showSnackBar(message: '${response.body} : ${response.statusCode}', isWarning: true);
      return;
    }
  }

  void onSelectMovie(int movieId) {
    Get.to(() => MovieDetailScreen(movieId: movieId));
  }

  void onCLickSeeMore() {
    showSnackBar(isWarning: true, message: 'Under Construction');
  }
}

class MovieDetailController extends GetxController {
  final int movieId;
  MovieDetailController({required this.movieId});
  var reviewPage = 1.obs;
  var isLoading = true.obs;

  Rx<MovieDetailModel> detail = MovieDetailModel().obs;
  Rx<ReviewModel> reviews =
      ReviewModel(totalResults: 0, totalPages: 0, results: [], page: 0, id: 0).obs;

  @override
  void onInit() async {
    ///get detail
    await getDetail(movieId);

    ///get some reviews
    await getReviews(id: movieId, page: reviewPage.value);
    isLoading.value = false;

    super.onInit();
  }

  String getGenres() {
    String result = "";

    for (int i = 0; i < detail.value.genres!.length; i++) {
      result += detail.value.genres![i].name!;
      if (i != detail.value.genres!.length - 1) result += ", ";
    }
    return result;
  }

  String getLanguage() {
    String result = "";
    for (int i = 0; i < detail.value.spokenLanguages!.length; i++) {
      result += detail.value.spokenLanguages![i].name!;
      if (i != detail.value.spokenLanguages!.length - 1) result += ", ";
    }
    return result;
  }

  Future getDetail(int id) async {
    Uri uri = Uri.parse('$getMovieDetailUrl/$id');
    var response = await Connection(uri: uri).get();
    if (response.statusCode == 200) {
      MovieDetailModel data = movieDetailModelFromJson(response.body);
      detail.value = data;

      return;
    } else {
      showSnackBar(message: 'Failed to get data, status : ${response.statusCode}', isWarning: true);
      return;
    }
  }

  Future getReviews({required int id, required int page}) async {
    Uri uri = Uri.parse('$getMovieDetailUrl/$id/reviews?page=$page');
    var response = await Connection(uri: uri).get();
    if (response.statusCode == 200) {
      ReviewModel data = movieReviewModelFromJson(response.body);
      reviews.value = data;

      return;
    } else {
      showSnackBar(message: 'Failed to get data, status : ${response.statusCode}', isWarning: true);
      return;
    }
  }
}
