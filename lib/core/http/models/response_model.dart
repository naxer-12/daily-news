import 'package:daily_news/features/weather_screen/data/model/latest_data_model.dart';

class ApiResponse {
  String status;
  List<News> news;

  ApiResponse.fromJson(Map<String, dynamic> json) {
    if (json['news'] != null) {
      news = new List<News>();
      json['news'].forEach((v) {
        news.add(new News.fromJson(v));
      });
    }
    status = json['status'];
  }
}
