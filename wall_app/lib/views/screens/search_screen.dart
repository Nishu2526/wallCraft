import 'package:flutter/material.dart';
import 'package:wallpaper_app/controller/photos_api.dart';
import 'package:wallpaper_app/models/photos_model.dart';
import 'package:wallpaper_app/views/screens/full_screen.dart';

import 'package:wallpaper_app/views/widgets/custom_appbar.dart';
import 'package:wallpaper_app/views/widgets/search_bar.dart';

class SearchScreen extends StatefulWidget {
  String search;

  SearchScreen({
    super.key,
    required this.search,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<PhotosModel> searchResults = [];
  bool isLoading = true;

  getSearchResults() async {
    searchResults = await PhotoApiController.searchWallpaper(widget.search);

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSearchResults();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: CustomAppBar(
          word1: 'Wall ',
          word2: ' Craft',
        ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: SearchBar()),
            //

            //
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            mainAxisExtent: 480),
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) => GridTile(
                            child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FullScreen(
                                        imgUrl: searchResults[index].imgSrc)));
                          },
                          child: Hero(
                            tag: searchResults[index].imgSrc,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.tealAccent,
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          searchResults[index].imgSrc))),
                            ),
                          ),
                        ))),
              ),
            )
          ]),
    );
  }
}
