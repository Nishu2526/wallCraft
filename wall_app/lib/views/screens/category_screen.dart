import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_app/controller/photos_api.dart';

import 'package:wallpaper_app/views/widgets/custom_appbar.dart';

import '../../models/photos_model.dart';
import 'full_screen.dart';

class CategoryScreen extends StatefulWidget {
  String catName;
  String catImgUrl;
  CategoryScreen({super.key, required this.catImgUrl, required this.catName});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late List<PhotosModel> categoryResults = [];
  // late List<CategoryModel> categoryModResults;
  bool isLoading = true;

  @override
  void initState() {
    GetCatRelWall();
    super.initState();
  }

  GetCatRelWall() async {
    categoryResults = await PhotoApiController.searchWallpaper(widget.catName);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: CustomAppBar(
            word1: "Wall",
            word2: " Craft",
          )),
      body: isLoading
          ? const Center(
              child: SpinKitCubeGrid(
                color: Colors.red,
                size: 50,
              ),
            )
          : SingleChildScrollView(
              child: Column(children: [
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      height: 150,
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                widget.catImgUrl,
                              ))),
                    ),
                    Positioned(
                      left: 150,
                      top: 40,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                        ),
                        child: Text(
                          widget.catName,
                          style: const TextStyle(
                              letterSpacing: 1,
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "${widget.catName} Wallpares",
                    style: GoogleFonts.poppins(
                        color: Colors.black87,
                        letterSpacing: 2,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  height: MediaQuery.of(context).size.height -
                      280, // Adjust the height as needed
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 250,
                    ),
                    itemCount: categoryResults.length,
                    itemBuilder: (context, index) => GridTile(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullScreen(
                                imgUrl: categoryResults[index].imgSrc,
                              ),
                            ),
                          );
                        },
                        child: Hero(
                          tag: categoryResults[index].imgSrc,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.amberAccent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                categoryResults[index].imgSrc,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
    );
  }
}
