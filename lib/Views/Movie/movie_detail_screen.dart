// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:get/get.dart';

// 🌎 Project imports:
import '../../Constant/api_url.dart';
import '../../Constant/themes.dart';
import '../../Controllers/movie_controller.dart';
import '../../Utils/date_format.dart';
import '../../Utils/time_ago.dart';
import '../../Widget/widgets.dart';

class MovieDetailScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final MovieDetailController mdc = Get.put(MovieDetailController(movieId: movieId));
    return Obx(
      () => Scaffold(
        backgroundColor: primaryColor,
        body: !mdc.isLoading.value
            ? DefaultTabController(
                length: 2,
                child: CustomScrollView(
                  slivers: [
                    _appBar(mdc),
                    SliverToBoxAdapter(
                      child: _body(mdc),
                    ),
                    SliverToBoxAdapter(
                      child: _tabView(mdc),
                    )
                  ],
                ),
              )
            : Center(child: loadingIndicator()),
      ),
    );
  }

  SliverAppBar _appBar(MovieDetailController mdc) {
    return SliverAppBar(
      expandedHeight: 150.0,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(stretchModes: const <StretchMode>[
        StretchMode.zoomBackground,
        StretchMode.blurBackground,
      ], background: imageFromNetwork(url: "$image780Url${mdc.detail.value.backdropPath}")),
    );
  }

  Widget _body(MovieDetailController mdc) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      ///movie info
      _movieInfo(mdc),

      const Divider(
        thickness: 2,
        height: 0,
      ),

      ///movie rating
      _movieRating(mdc),

      const Divider(
        thickness: 10,
        height: 10,
      ),

      ///overview and review
      _tabController(mdc),
    ]);
  }

  Widget _movieInfo(MovieDetailController mdc) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///image poster
          SizedBox(
              width: 115,
              child:
                  imageFromNetwork(url: "$image342Url${mdc.detail.value.posterPath}", radius: 18)),

          ///white space
          const SizedBox(width: 15),

          ///movie detail
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${mdc.detail.value.title}',
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),

                ///white space
                const SizedBox(height: 15),

                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(1),
                  },
                  children: [
                    ///genre
                    TableRow(children: [
                      const Text(
                        'Genre',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(mdc.getGenres())
                    ]),

                    ///sized box
                    const TableRow(children: [
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ]),

                    ///language
                    TableRow(children: [
                      const Text('Language', style: TextStyle(color: Colors.grey)),
                      Text(
                        '${mdc.detail.value.originalLanguage}',
                      )
                    ]),

                    ///sized box
                    const TableRow(children: [
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ]),

                    ///spoken languages
                    TableRow(children: [
                      const Text('Spoken Language', style: TextStyle(color: Colors.grey)),
                      Text(mdc.getLanguage())
                    ]),

                    ///sized box
                    const TableRow(children: [
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ]),

                    ///production country
                    TableRow(children: [
                      const Text('Release Date', style: TextStyle(color: Colors.grey)),
                      Text(
                        formatDate('${mdc.detail.value.releaseDate}'),
                      )
                    ]),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _movieRating(MovieDetailController mdc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          mdc.detail.value.voteCount != null
              ? Row(
                  children: [
                    const Icon(CupertinoIcons.hand_thumbsup_fill, color: famGreen, size: 25),
                    const SizedBox(width: 5),
                    Text(
                      "${mdc.detail.value.voteCount}",
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    )
                  ],
                )
              : const Offstage(),
          const SizedBox(
              height: 35,
              child: VerticalDivider(
                thickness: 2,
              )),
          Row(
            children: [
              const Icon(CupertinoIcons.star_fill, color: Colors.orange, size: 25),
              const SizedBox(width: 5),
              Text("${mdc.detail.value.voteAverage!.toPrecision(1)}",
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold))
            ],
          ),
        ],
      ),
    );
  }

  Widget _tabController(MovieDetailController mdc) {
    return const TabBar(
      labelColor: famBlue,
      indicatorColor: famGreen,
      tabs: [
        Tab(text: "Overview"),
        Tab(
          text: "Review",
        ),
      ],
    );
  }

  Widget _tabView(MovieDetailController mdc) {
    return SizedBox(
      height: Get.height / 2,
      child: TabBarView(
        children: [_overview(mdc), _review(mdc)],
      ),
    );
  }

  Widget _overview(MovieDetailController mdc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///overview
          Text(
            "${mdc.detail.value.overview}",
            style: const TextStyle(color: Colors.blueGrey),
          ),

          const Divider(
            thickness: 2,
            height: 20,
          ),

          ///production country
          const Text(
            "Production Countries",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          const SizedBox(
            height: 10,
          ),
          Wrap(
              spacing: 20.0,
              runSpacing: 20.0,
              children: mdc.detail.value.productionCountries!.map((e) {
                if (e.name != null) {
                  return Text(
                    "${e.name}\n",
                    style: const TextStyle(color: Colors.blueGrey),
                  );
                } else {
                  return const Offstage();
                }
              }).toList()),

          const Divider(
            thickness: 2,
            height: 20,
          ),

          ///production company
          const Text(
            "Production Company",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          const SizedBox(
            height: 10,
          ),
          Wrap(
              spacing: 20.0,
              runSpacing: 20.0,
              children: mdc.detail.value.productionCompanies!.map((e) {
                if (e.logoPath != null) {
                  return SizedBox(
                      width: 50, child: imageFromNetwork(url: "$image342Url${e.logoPath}"));
                } else {
                  return const Offstage();
                }
              }).toList()),
        ],
      ),
    );
  }

  Widget _review(MovieDetailController mdc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: mdc.reviews.value.results.isNotEmpty
          ? ListView.builder(
              addAutomaticKeepAlives: true,
              itemCount: mdc.reviews.value.results.length,
              itemBuilder: (c, i) {
                var data = mdc.reviews.value.results[i];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      minLeadingWidth: 0,
                      dense: true,
                      leading: _buildAvatar(
                          name: data.author, avatarPath: data.authorDetails.avatarPath),
                      title: Text("${data.authorDetails.username}\n",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      trailing: Text(
                        TimeAgo.timeAgoSinceDate(data.createdAt.substring(0, 10),
                            numericDates: false),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ObxValue(
                        (RxBool showLess) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.content,
                                  maxLines: showLess.value
                                      ? 5
                                      : 1000000, //show lines for less text or full text
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Colors.blueGrey),
                                ),
                                if (showLess.value && data.content.length > 400)
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                        constraints: const BoxConstraints.tightForFinite(
                                            height: 20, width: 35),
                                        iconSize: 20,
                                        highlightColor: Colors.transparent,
                                        padding: EdgeInsets.zero,
                                        color: Colors.blueGrey,
                                        icon: const Icon(CupertinoIcons.chevron_down),
                                        onPressed: () => showLess.value = false),
                                  ),
                                if (!showLess.value)
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                        iconSize: 20,
                                        splashColor: Colors.transparent,
                                        padding: EdgeInsets.zero,
                                        color: Colors.blueGrey,
                                        icon: const Icon(CupertinoIcons.chevron_up),
                                        onPressed: () => showLess.value = true),
                                  )
                              ],
                            ),
                        true.obs),
                    i == mdc.reviews.value.results.length - 1
                        ? const Padding(padding: EdgeInsets.only(bottom: 100))
                        : const Divider(
                            thickness: 1,
                            height: 20,
                          ),
                  ],
                );
              },
            )
          : const Center(child: Text("No Review Available")),
    );
  }

  Widget _buildAvatar({required String name, String? avatarPath}) {
    String getInitials(String name) => name.isNotEmpty
        ? name.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join().toUpperCase()
        : '';

    if (avatarPath != null) {
      if (avatarPath.contains("/https")) {
        return CircleAvatar(
          backgroundColor: famGreen,
          backgroundImage: NetworkImage(avatarPath.substring(1)),
        );
      } else {
        return CircleAvatar(
          backgroundImage: NetworkImage("$image342Url$avatarPath"),
        );
      }
    } else {
      return CircleAvatar(
        backgroundColor: famGreen,
        child: Text(getInitials(name)),
      );
    }
  }
}
