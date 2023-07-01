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
import '../../Controllers/movie_controller.dart';
import '../../Widget/network_image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MovieController mc = Get.put(MovieController());
    return Scaffold(
      backgroundColor: primaryColor,
      body: _body(mc),
    );
  }

  Widget _body(MovieController mc) {
    return SingleChildScrollView(
      child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///white space
              const SizedBox(height: 110),

              ///now playing section
              mc.isLoading.value
                  ? __loadingBox()
                  : mc.nowPlaying.value.results.isNotEmpty
                      ? __nowPlaying(mc)
                      : const Offstage(),

              ///white space
              const SizedBox(height: 20),

              ///Upcoming section
              mc.isLoading.value
                  ? __loadingBox()
                  : mc.upComing.value.results.isNotEmpty
                      ? __upcoming(mc)
                      : const Offstage(),

              ///white space
              const SizedBox(height: 20),

              mc.isLoading.value
                  ? __loadingBox()
                  : mc.popular.value.results.isNotEmpty
                      ? __popularMovie(mc)
                      : const Offstage(),

              ///white space
              const SizedBox(height: 100)
            ],
          )),
    );
  }

  Widget __nowPlaying(MovieController mc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Now Playing',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              GestureDetector(onTap: () => mc.onCLickSeeMore(), child: const Text('See more')),
            ],
          ),
        ),
        const SizedBox(height: 15),
        CarouselSlider(
          options: CarouselOptions(
            height: 300,
            aspectRatio: 16 / 9,
            viewportFraction: 0.5,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: false,
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: false,
            scrollDirection: Axis.horizontal,
          ),
          items: mc.nowPlaying.value.results.map(
            (i) {
              return Builder(
                builder: (BuildContext context) {
                  return ___imagePoster(mc,
                      id: i.id, posterPath: i.posterPath, voteAvg: i.voteAverage);
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
            aspectRatio: 16 / 9,
            viewportFraction: 0.6,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: false,
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: false,
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

  Widget __upcoming(MovieController mc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Upcoming', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              GestureDetector(onTap: () => mc.onCLickSeeMore(), child: const Text('See more')),
            ],
          ),
        ),
        const SizedBox(height: 15),
        CarouselSlider(
          options: CarouselOptions(
              height: 300, viewportFraction: 0.5, padEnds: false, enableInfiniteScroll: true),
          items: mc.upComing.value.results.map(
            (i) {
              return Builder(
                builder: (BuildContext context) {
                  return ___imagePoster(mc,
                      id: i.id, posterPath: i.posterPath, voteAvg: i.voteAverage);
                },
              );
            },
          ).toList(),
        )
      ],
    );
  }

  Widget __popularMovie(MovieController mc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Popular Movie',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              GestureDetector(onTap: () => mc.onCLickSeeMore(), child: const Text('See more')),
            ],
          ),
        ),
        const SizedBox(height: 15),
        CarouselSlider(
          options: CarouselOptions(height: 300, viewportFraction: 0.5, enableInfiniteScroll: true),
          items: mc.popular.value.results.map(
            (i) {
              return Builder(
                builder: (BuildContext context) {
                  return ___imagePoster(mc,
                      id: i.id,
                      posterPath: i.posterPath,
                      voteAvg: i.voteAverage,
                      voteCount: i.voteCount);
                },
              );
            },
          ).toList(),
        )
      ],
    );
  }

  Widget ___imagePoster(MovieController mc,
      {required int id, required String posterPath, required double voteAvg, int? voteCount}) {
    return GestureDetector(
      onTap: () => mc.onSelectMovie(id),
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
