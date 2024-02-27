import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/category_screen.dart';

class WallCategoryScreen extends StatelessWidget {
  String categoryName;
  String categoryImgSrc;
  WallCategoryScreen(
      {super.key, required this.categoryImgSrc, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryScreen(
                    catImgUrl: categoryImgSrc, catName: categoryName)));
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                categoryImgSrc,
                height: 60,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            categoryName.toUpperCase(),
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w900,
                letterSpacing: 1),
          ),
        ],
      ),
    );
  }
}
