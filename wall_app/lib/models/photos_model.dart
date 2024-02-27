class PhotosModel {
  String imgSrc;
  String photoGrapher;

  PhotosModel({required this.imgSrc, required this.photoGrapher});

  static fromApiToApp(Map<String, dynamic> json) {
    return PhotosModel(
        imgSrc: (json['src'])['portrait'], photoGrapher: json['photographer']);
  }
}

//-------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------
