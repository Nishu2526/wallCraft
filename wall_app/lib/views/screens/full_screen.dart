import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FullScreen extends StatefulWidget {
  String imgUrl;
  FullScreen({super.key, required this.imgUrl});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(
      children: [
        Hero(
            tag: widget.imgUrl,
            child: kIsWeb
                ? Image.network(widget.imgUrl, fit: BoxFit.cover)
                : Container(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(widget.imgUrl),
                            fit: BoxFit.cover)))),
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          height: height,
          width: width,
          alignment: Alignment.bottomCenter,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity((0.8))),
              onPressed: () {
                // Navigator.pop(context);
              },
              child: Stack(children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xff1C1B1B).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white24, width: 1),
                      borderRadius: BorderRadius.circular(40),
                      gradient: const LinearGradient(
                          colors: [Color(0x36FFFFFF), Color(0x0FFFFFFF)],
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.bottomRight)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Text(
                        "Set Wallpaper",
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Text(
                        kIsWeb
                            ? "Image will open in new tab to download"
                            : "Image will be saved in gallery",
                        style: TextStyle(fontSize: 8, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            const SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                    color: Colors.white60,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 50,
            )
          ]),
        ),
      ],
    ));
  }
}
