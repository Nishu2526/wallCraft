import 'package:flutter/material.dart';
import 'package:wallpaper_app/views/screens/search_screen.dart';

class SearchBar extends StatelessWidget {
  SearchBar({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 40,
      decoration: BoxDecoration(
          color: Color.fromARGB(61, 131, 134, 132),
          border: Border.all(color: Colors.black, width: 1.6),
          borderRadius: BorderRadius.circular(25)),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search wallpaper',
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
              ),
            ),
          ),
          InkWell(
              onTap: () {
                if (_searchController.text != "") {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SearchScreen(
                      search: _searchController.text,
                    );
                  }));
                }
              },
              child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: const Icon(Icons.search)))
        ],
      ),
    );
  }
}
