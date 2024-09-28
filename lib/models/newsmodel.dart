class NewsApiModel {
  String title, imageurl, content, desc;

  NewsApiModel({
    required this.title,
    required this.imageurl,
    required this.content,
    required this.desc,
  });

  factory NewsApiModel.fromJson(Map<String, dynamic> jsondata) {
    return NewsApiModel(
      title: jsondata['title'] ?? '',
      imageurl: jsondata['urlToImage'] ?? '',
      content: jsondata['content'] ?? '',
      desc: jsondata['description'] ?? '',
    );
  }
}
