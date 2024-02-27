import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_app/controller/photos_api.dart';
import 'package:wallpaper_app/models/photos_model.dart';
import 'package:wallpaper_app/views/download_image.dart';
import 'package:wallpaper_app/views/screens/full_screen.dart';
import 'package:wallpaper_app/views/widgets/cate_block.dart';
import 'package:wallpaper_app/views/widgets/custom_appbar.dart';
import 'package:wallpaper_app/views/widgets/search_bar.dart';

import '../../models/category_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<PhotosModel> trendingWallpaperList = [];
  late List<CategoryModel> catModList = [];
  late List<PhotosModel> categoryResults = [];
  bool isLoading = true;

  GetCatDetails() async {
    catModList = await PhotoApiController.getCategoriesList();
    // print("GETTTING CAT MOD LIST");
    // print(CatModList);
    setState(() {
      catModList = catModList;
    });
  }

  GetTrendingWallpaper() async {
    trendingWallpaperList = await PhotoApiController.getTrendingWallpaper();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    GetCatDetails();
    GetTrendingWallpaper();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: CustomAppBar(
          word1: 'Home',
          word2: '',
        ),
      ),
      body: isLoading
          ? const Center(
              child: SpinKitCircle(
                color: Colors.red,
                size: 50,
              ),
            )
          : Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: SearchBar()),
              Container(
                // color: Colors.red,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: SizedBox(
                  height: 60,
                  width: width,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: catModList.length,
                      itemBuilder: (context, index) {
                        return WallCategoryScreen(
                            categoryImgSrc: catModList[index].catImgUrl,
                            categoryName: catModList[index].catName);
                      }),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Container(
                padding: EdgeInsets.only(left: 15),
                alignment: Alignment.topLeft,
                child: Text(
                  'Trending',
                  style: GoogleFonts.poppins(
                      color: Colors.black87,
                      letterSpacing: 2,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Expanded(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    },
                    child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                mainAxisExtent: 445),
                        itemCount: trendingWallpaperList.length,
                        itemBuilder: (context, index) => GridTile(
                                child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FullScreen(
                                            imgUrl: trendingWallpaperList[index]
                                                .imgSrc)));
                              },
                              child: Hero(
                                tag: trendingWallpaperList[index].imgSrc,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              trendingWallpaperList[index]
                                                  .imgSrc))),
                                ),
                              ),
                            ))),
                  ),
                ),
              )
            ]),
    );
  }
}
