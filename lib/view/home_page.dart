import 'package:flutter/material.dart';
import 'package:moviedb/provider/home_provider.dart';
import 'package:moviedb/utils/constant.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../provider/detail/detail_provider.dart';
import '../style/color.dart';
import 'detail/detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final detailProvider = Provider.of<DetailProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Card(
            margin: const EdgeInsets.only(top: 8),
            child: TextFormField(
              enabled: false,
              textInputAction: TextInputAction.search,
              onFieldSubmitted: (keyword) {
                // productController.getProductData(1, keyword, "");
              },
              onTap: () {},
              // controller: keywordController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  prefixIcon: GestureDetector(
                    onTap: () {
                      // print(keywordController.text);
                      // productController.getProductData(
                      //     1, keywordController.text, "");
                    },
                    child: const Icon(
                      Icons.search,
                      color: primaryColor,
                    ),
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.only(
                      left: 15, bottom: 11, top: 13, right: 15),
                  hintText: "Find your movie"),
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          Container(
            height: 20,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                )),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: RefreshIndicator(
                onRefresh: () async {
                  await homeProvider.getNowPlayingData();
                },
                child: Consumer<HomeProvider>(
                  builder: (context, provider, _) {
                    if (provider.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return GridView.builder(
                        padding: const EdgeInsets.only(top: 10),
                        itemCount: provider.listNowPlaying.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.65,
                        ),
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, index) {
                          var linkImage = Constant.imageUrl;
                          return GestureDetector(
                            onTap: () {
                              detailProvider
                                  .onInit(provider.listNowPlaying[index].id!);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                    imagePath:
                                        '$linkImage${provider.listNowPlaying[index].backdropPath}',
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(1, 1),
                                    blurRadius: 8,
                                    color: Colors.black.withOpacity(.1),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.32,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      '$linkImage${provider.listNowPlaying[index].posterPath}',
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return ShimmerImage(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.32);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShimmerImage extends StatelessWidget {
  final double height;

  const ShimmerImage({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.white,
      baseColor: Colors.grey[300]!,
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: const Card(
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(8),
            // ),
            ),
      ),
    );
  }
}
