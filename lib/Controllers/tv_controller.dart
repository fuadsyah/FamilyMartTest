// 📦 Package imports:
import 'package:get/get.dart';

// 🌎 Project imports:
import '../../Models/review_model.dart';
import '../../Models/tv_detail_model.dart';
import '../../Models/tv_model.dart';
import '../../Utils/connection.dart';
import '../Constant/api_url.dart';
import '../Views/Television/tv_detail_screen.dart';
import '../Widget/snack_bar.dart';

class TVController extends GetxController {
  var page = 99.obs;
  var isLoading = true.obs;

  @override
  void onInit() async {
    ///get now playing
    await getOnAir(page.value);

    ///get popular tv
    await getPopularTV(page.value);

    ///stop loading shimmer
    isLoading.value = false;
    super.onInit();
  }

  Rx<TvModel> onAir = TvModel(page: 1, results: [], totalPages: 0, totalResults: 0).obs;

  Rx<TvModel> popular = TvModel(page: 1, results: [], totalPages: 0, totalResults: 0).obs;

  Future getOnAir(int page) async {
    Uri uri = Uri.parse('$getOnTheAirTvUrl?page=3');
    var response = await Connection(uri: uri).get();
    if (response.statusCode == 200) {
      TvModel data = tvModelFromJson(response.body);
      if (page > 1) {
        onAir.value.page = data.page;
        onAir.value.results.addAll(data.results);
      } else {
        onAir.value = data;
      }

      return;
    } else {
      showSnackBar(message: '${response.body} : ${response.statusCode}', isWarning: true);
      return;
    }
  }

  Future getPopularTV(int page) async {
    Uri uri = Uri.parse('$getPopularTvUrl?page=$page');
    var response = await Connection(uri: uri).get();
    if (response.statusCode == 200) {
      TvModel data = tvModelFromJson(response.body);
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

  void onSelectTv(int tvId) {
    Get.to(() => TvDetailScreen(tvId: tvId));
  }

  void onCLickSeeMore() {
    showSnackBar(isWarning: true, message: 'Under Construction');
  }
}

class TVDetailController extends GetxController {
  final int tvId;
  TVDetailController({required this.tvId});
  var reviewPage = 1.obs;
  var isLoading = true.obs;

  Rx<TvDetailModel> detail = TvDetailModel().obs;
  Rx<ReviewModel> reviews =
      ReviewModel(totalResults: 0, totalPages: 0, results: [], page: 0, id: 0).obs;

  @override
  void onInit() async {
    ///get detail
    await getDetail(tvId);

    ///get some reviews
    await getReviews(id: tvId, page: reviewPage.value);
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
    Uri uri = Uri.parse('$getTvDetailUrl/$id');
    var response = await Connection(uri: uri).get();
    if (response.statusCode == 200) {
      TvDetailModel data = tvDetailModelFromJson(response.body);
      detail.value = data;
      return;
    } else {
      showSnackBar(message: 'Failed to get data, status : ${response.statusCode}', isWarning: true);
      return;
    }
  }

  Future getReviews({required int id, required int page}) async {
    Uri uri = Uri.parse('$getTvDetailUrl/$id/reviews?page=$page');
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
