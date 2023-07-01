// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

// 🌎 Project imports:
import '../../Constant/api_url.dart';
import '../../Constant/themes.dart';
import '../../Controllers/tv_controller.dart';
import '../../Widget/network_image.dart';

class TelevisionScreen extends StatelessWidget {
  const TelevisionScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final TVController tvc = Get.put(TVController());
    return Scaffold(
      backgroundColor: primaryColor,
      body: _body(tvc),
    );
  }

  Widget _body(TVController tvc) {
    return SingleChildScrollView(
      child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///white space
              const SizedBox(height: 110),

              ///now playing section
              tvc.isLoading.value
                  ? __loadingBox()
                  : tvc.onAir.value.results.isNotEmpty
                      ? __onTheAir(tvc)
                      : const Offstage(),

              ///white space
              const SizedBox(height: 20),

              ///white space
              const SizedBox(height: 20),

              tvc.isLoading.value
                  ? __loadingBox()
                  : tvc.popular.value.results.isNotEmpty
                      ? __popularMovie(tvc)
                      : const Offstage(),

              ///white space
              const SizedBox(height: 100)
            ],
          )),
    );
  }

  Widget __onTheAir(TVController tvc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('On The Air',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red)),
              GestureDetector(onTap: () => tvc.onCLickSeeMore(), child: const Text('See more')),
            ],
          ),
        ),
        const SizedBox(height: 15),
        CarouselSlider(
          options: CarouselOptions(height: 250, viewportFraction: 0.45, padEnds: false,enableInfiniteScroll: true),
          items: tvc.onAir.value.results.map(
            (i) {
              return Builder(
                builder: (BuildContext context) {
                  if(i.posterPath!=null){
                    return ___imagePoster(tvc,
                        id: i.id, posterPath: i.posterPath!, voteAvg: i.voteAverage);
                  }else{
                    return Text(i.name);
                  }
                },
              );
            },
          ).toList(),
        )
      ],
    );
  }

  Widget __loadingBox() {
    return Shimmer.fromColors(
      baseColor: Colors.white60,
      highlightColor: primaryColor,
      child: CarouselSlider(
        options: CarouselOptions(
            height: 300,
            viewportFraction: 0.6,
            initialPage: 0,
            scrollPhysics: const NeverScrollableScrollPhysics()),
        items: [
          1,
          2,
          3,
        ].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration:
                      BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    'text $i',
                  ));
            },
          );
        }).toList(),
      ),
    );
  }

  Widget __popularMovie(TVController tvc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Popular TV Series',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              GestureDetector(onTap: () => tvc.onCLickSeeMore(), child: const Text('See more')),
            ],
          ),
        ),
        const SizedBox(height: 15),
        CarouselSlider(
          options: CarouselOptions(
              height: 250, viewportFraction: 0.45, padEnds: false, disableCenter: true),
          items: tvc.popular.value.results.map(
            (i) {
              return Builder(
                builder: (BuildContext context) {
                  if(i.posterPath!=null){
                    return ___imagePoster(tvc,
                        id: i.id,
                        posterPath: i.posterPath!,
                        voteAvg: i.voteAverage,
                        voteCount: i.voteCount);
                  }else{
                    return Center(child: Text(i.name));
                  }
                },
              );
            },
          ).toList(),
        )
      ],
    );
  }

  Widget ___imagePoster(TVController tvc,
      {required int id, required String posterPath, required double voteAvg, int? voteCount}) {
    return GestureDetector(
      onTap: () => tvc.onSelectTv(id),
      child: Stack(
        children: [
          ///main poster
          Container(
            width: Get.width,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: const BoxDecoration(color: Colors.transparent),
            child: imageFromNetwork(radius: 15, url: "$image342Url$posterPath"),
          ),

          ///rate
          voteAvg > 0
              ? Positioned(
                  top: 5,
                  right: 10,
                  left: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      voteCount != null
                          ? Container(
                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black54.withOpacity(0.6)),
                              child: Row(
                                children: [
                                  const Icon(CupertinoIcons.hand_thumbsup_fill,
                                      color: primaryColor, size: 15),
                                  const SizedBox(width: 5),
                                  Text(
                                    "$voteCount",
                                    style: const TextStyle(color: primaryColor),
                                  )
                                ],
                              ),
                            )
                          : const Offstage(),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.black54.withOpacity(0.6)),
                        child: Row(
                          children: [
                            const Icon(CupertinoIcons.star_fill, color: Colors.amber, size: 15),
                            const SizedBox(width: 5),
                            Text(
                              "$voteAvg",
                              style: const TextStyle(color: primaryColor),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : const Offstage(),
        ],
      ),
    );
  }
}
