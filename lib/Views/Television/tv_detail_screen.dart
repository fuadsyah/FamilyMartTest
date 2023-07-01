// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:get/get.dart';

// 🌎 Project imports:
import '../../Constant/api_url.dart';
import '../../Constant/themes.dart';
import '../../Controllers/tv_controller.dart';
import '../../Utils/date_format.dart';
import '../../Utils/time_ago.dart';
import '../../Widget/widgets.dart';

class TvDetailScreen extends StatelessWidget {
  final int tvId;

  const TvDetailScreen({super.key, required this.tvId});

  @override
  Widget build(BuildContext context) {
    final TVDetailController tdc = Get.put(TVDetailController(tvId: tvId));
    return Obx(
      () => Scaffold(
        backgroundColor: primaryColor,
        body: !tdc.isLoading.value
            ? DefaultTabController(
                length: 2,
                child: CustomScrollView(
                  slivers: [
                    _appBar(tdc),
                    SliverToBoxAdapter(
                      child: _body(tdc),
                    ),
                    SliverFillRemaining(
                      hasScrollBody: true,
                      child: _tabView(tdc),
                    )
                  ],
                ),
              )
            : Center(child: loadingIndicator()),
      ),
    );
  }

  SliverAppBar _appBar(TVDetailController tdc) {
    return SliverAppBar(
      expandedHeight: 150.0,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(stretchModes: const <StretchMode>[
        StretchMode.zoomBackground,
        StretchMode.blurBackground,
      ], background: imageFromNetwork(url: "$image780Url${tdc.detail.value.backdropPath}")),
    );
  }

  Widget _body(TVDetailController tdc) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      ///movie info
      _movieInfo(tdc),

      const Divider(
        thickness: 2,
        height: 0,
      ),

      ///movie rating
      _tvRating(tdc),

      const Divider(
        thickness: 10,
        height: 10,
      ),

      ///overview and review
      _tabController(tdc),
    ]);
  }

  Widget _movieInfo(TVDetailController tdc) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///image poster
          SizedBox(
              width: 115,
              child:
                  imageFromNetwork(url: "$image342Url${tdc.detail.value.posterPath}", radius: 18)),

          ///white space
          const SizedBox(width: 15),

          ///movie detail
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${tdc.detail.value.name}',
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
                      Text(tdc.getGenres())
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
                      Text(tdc.getLanguage())
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

                    ///first air date
                    TableRow(children: [
                      const Text('First Air Date', style: TextStyle(color: Colors.grey)),
                      Text(
                        formatDate('${tdc.detail.value.firstAirDate}'),
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

                    ///episodes
                    TableRow(children: [
                      const Text('Episodes', style: TextStyle(color: Colors.grey)),
                      Text('${tdc.detail.value.numberOfEpisodes}')
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

                    ///seasons
                    TableRow(children: [
                      const Text('Seasons', style: TextStyle(color: Colors.grey)),
                      Text('${tdc.detail.value.numberOfSeasons}')
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

                    ///Status
                    TableRow(children: [
                      const Text('Status', style: TextStyle(color: Colors.grey)),
                      Text('${tdc.detail.value.status}')
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

  Widget _tvRating(TVDetailController tdc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          tdc.detail.value.voteCount != null
              ? Row(
                  children: [
                    const Icon(CupertinoIcons.hand_thumbsup_fill, color: famGreen, size: 25),
                    const SizedBox(width: 5),
                    Text(
                      "${tdc.detail.value.voteCount}",
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
              Text("${tdc.detail.value.voteAverage!.toPrecision(1)}",
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold))
            ],
          ),
        ],
      ),
    );
  }

  Widget _tabController(TVDetailController tdc) {
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

  Widget _tabView(TVDetailController tdc) {
    return TabBarView(
      children: [_overview(tdc), _review(tdc)],
    );
  }

  Widget _overview(TVDetailController tdc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///overview
          if (tdc.detail.value.overview!.isNotEmpty)
            Text(
              "${tdc.detail.value.overview}",
              style: const TextStyle(color: Colors.blueGrey),
            ),

          if (tdc.detail.value.overview!.isNotEmpty)
            const Divider(
              thickness: 2,
              height: 20,
            ),

          ///Episodes
          const Text(
            "Episodes",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          const SizedBox(
            height: 10,
          ),
          Table(
            children: [
              TableRow(children: [
                const Text("Last Episode"),
                Text(formatDate('${tdc.detail.value.lastEpisodeToAir!.airDate}')),
              ]),
            ],
          ),

          Table(
            children: const [
              TableRow(children: [
                SizedBox(height: 10),
                SizedBox(height: 10),
              ]),
            ],
          ),

          Table(
            children: [
              TableRow(children: [
                const Text("Next Episode"),
                Text(tdc.detail.value.nextEpisodeToAir != null
                    ? formatDate('${tdc.detail.value.nextEpisodeToAir?.airDate}')
                    : "-"),
              ]),
            ],
          ),

          const Divider(
            thickness: 2,
            height: 20,
          ),

          ///seasons
          const Text(
            "Seasons",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, mainAxisSpacing: 0, mainAxisExtent: 170),
              itemCount:
                  tdc.detail.value.seasons!.length > 8 ? 8 : tdc.detail.value.seasons!.length,
              itemBuilder: (c, i) {
                var e = tdc.detail.value.seasons![i];
                if (e.name != null) {
                  return GestureDetector(
                    onTap: () => showCustomBottomSheet(
                        child: imageFromNetwork(url: "$image780Url${e.posterPath}", radius: 10)),
                    child: Column(
                      children: [
                        SizedBox(
                            width: 75,
                            child: imageFromNetwork(url: "$image342Url${e.posterPath}", radius: 5)),
                        Text(
                          "${e.name}\n",
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.blueGrey),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Offstage();
                }
              }),

          if(tdc.detail.value.productionCountries!.isNotEmpty) const Divider(
            thickness: 2,
            height: 20,
          ),

          ///production country
          if(tdc.detail.value.productionCountries!.isNotEmpty)const Text(
            "Production Countries",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          if(tdc.detail.value.productionCountries!.isNotEmpty)const SizedBox(
            height: 10,
          ),
          if(tdc.detail.value.productionCountries!.isNotEmpty) Wrap(
              spacing: 20.0,
              runSpacing: 20.0,
              children: tdc.detail.value.productionCountries!.map((e) {
                if (e.name != null) {
                  return Text(
                    "${e.name}\n",
                    style: const TextStyle(color: Colors.blueGrey),
                  );
                } else {
                  return const Offstage();
                }
              }).toList()),

          if(tdc.detail.value.productionCompanies!.isNotEmpty) const Divider(
            thickness: 2,
            height: 20,
          ),

          ///production company
          if(tdc.detail.value.productionCompanies!.isNotEmpty)const Text(
            "Production Company",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          if(tdc.detail.value.productionCompanies!.isNotEmpty)const SizedBox(
            height: 10,
          ),
          if(tdc.detail.value.productionCompanies!.isNotEmpty)Wrap(
              spacing: 20.0,
              runSpacing: 20.0,
              children: tdc.detail.value.productionCompanies!.map((e) {
                if (e.logoPath != null) {
                  return SizedBox(
                      width: 75, child: imageFromNetwork(url: "$image342Url${e.logoPath}"));
                } else {
                  return const Text("-");
                }
              }).toList()),
        ],
      ),
    );
  }

  Widget _review(TVDetailController tdc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: tdc.reviews.value.results.isNotEmpty
          ? ListView.builder(
              addAutomaticKeepAlives: true,
              itemCount: tdc.reviews.value.results.length,
              itemBuilder: (c, i) {
                var data = tdc.reviews.value.results[i];
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
                                if (showLess.value && data.content.length > 300)
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
                    i == tdc.reviews.value.results.length - 1
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
