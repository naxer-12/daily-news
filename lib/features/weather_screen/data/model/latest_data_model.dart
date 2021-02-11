class NewsData {

  List<News> news;


  NewsData({this.news});

  NewsData.fromJson(Map<String, dynamic> json) {

    if (json['news'] != null) {
      news = new List<News>();
      json['news'].forEach((v) {
        news.add(new News.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.news != null) {
      data['news'] = this.news.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class News {
  String id;
  String title;
  String description;
  String url;
  String author;
  String image;
  String language;
  List<String> category;
  String published;

  News(
      {this.id,
        this.title,
        this.description,
        this.url,
        this.author,
        this.image,
        this.language,
        this.category,
        this.published});

  News.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    author = json['author'];
    image = json['image'];
    language = json['language'];
    category = json['category'].cast<String>();
    published = json['published'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['author'] = this.author;
    data['image'] = this.image;
    data['language'] = this.language;
    data['category'] = this.category;
    data['published'] = this.published;
    return data;
  }
}
