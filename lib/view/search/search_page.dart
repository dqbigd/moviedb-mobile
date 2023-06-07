import 'package:flutter/material.dart';
import 'package:moviedb/provider/search/search_provider.dart';
import 'package:moviedb/style/color.dart';
import 'package:provider/provider.dart';

import '../../provider/detail/detail_provider.dart';
import '../../utils/constant.dart';
import '../detail/detail_page.dart';
import '../home_page.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final detailProvider = Provider.of<DetailProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Result'),
        backgroundColor: primaryColor,
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Consumer<SearchProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (provider.listSearch.isEmpty) {
              return const Center(child: Text("No data available"));
            } else {
              return GridView.builder(
                padding: const EdgeInsets.only(top: 10),
                itemCount: provider.listSearch.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                      detailProvider.onInit(provider.listSearch[index].id!);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            imagePath: provider
                                        .listSearch[index].backdropPath ==
                                    null
                                ? 'no-image'
                                : '$linkImage${provider.listSearch[index].backdropPath}',
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
                          height: MediaQuery.of(context).size.height * 0.32,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: provider.listSearch[index].posterPath == null
                                ? Image.asset('assets/images/no-image.jpg')
                                : Image.network(
                                    '$linkImage${provider.listSearch[index].posterPath}',
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
    );
  }
}
