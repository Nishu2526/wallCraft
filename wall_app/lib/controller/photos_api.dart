import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:wallpaper_app/models/photos_model.dart';

import '../models/category_model.dart';

class PhotoApiController {
  static List<PhotosModel> trendingWallPaper = [];
  static List<PhotosModel> searchWallpaperList = [];
  static List<CategoryModel> cateogryModelList = [];
  static Future<List<PhotosModel>> getTrendingWallpaper() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated'), headers: {
      "Authorization":
          "EkW87C6qvlmo8393vCt2D01ng342zuzL1YPabm59DnUPPSX2uKue0Ofy"
    }).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      for (var element in photos) {
        trendingWallPaper.add(PhotosModel.fromApiToApp(element));
      }
    });
    return trendingWallPaper;
  }

  static Future<List<PhotosModel>> searchWallpaper(String search) async {
    await http.get(Uri.parse('https://api.pexels.com/v1/search?query=$search'),
        headers: {
          "Authorization":
              "EkW87C6qvlmo8393vCt2D01ng342zuzL1YPabm59DnUPPSX2uKue0Ofy"
        }).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      searchWallpaperList.clear();
      for (var element in photos) {
        searchWallpaperList.add(PhotosModel.fromApiToApp(element));
      }
    });
    return searchWallpaperList;
  }

  static Future<List<CategoryModel>> getCategoriesList() async {
    List<CategoryModel> categoryModelList = [];
    List<String> categoryName = [
      "Galaxy",
      "Cars",
      "Nature",
      "Bikes",
      "Street",
      "City",
      "Flowers",
      "Laptops",
      "Fasion",
    ];

    for (var catName in categoryName) {
      // ignore: no_leading_underscores_for_local_identifiers
      final _random = Random();
      List<PhotosModel> photosList = await searchWallpaper(catName);
      // ignore: unnecessary_null_comparison
      if (photosList != null && photosList.isNotEmpty) {
        PhotosModel photoModel = photosList[_random.nextInt(photosList.length)];
        categoryModelList
            .add(CategoryModel(catImgUrl: photoModel.imgSrc, catName: catName));
      } else {
        // ignore: avoid_print
        print('no data found $catName');
      }
    }

    return categoryModelList;
  }
}
