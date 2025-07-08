enum ApiPath {
  randomImage;

  static String mainUrl = "https://dog.ceo";

  String getUrl() {
    var url = '$mainUrl/api/breeds';
    switch (this) {
      case ApiPath.randomImage:
        return '$url/image/random';
    }
  }
}
