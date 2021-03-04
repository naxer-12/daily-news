import 'package:daily_news/core/models/error/failure.dart';
import 'package:daily_news/features/news_screen/model/top_headlines_model.dart';

abstract class NewsState {}

class InitialState extends NewsState {
  InitialState();
}

class LoadingState extends NewsState {}

class FetchedNewsScreenState extends NewsState {
  final TopHeadLinesModel topHeadLinesModel;

  FetchedNewsScreenState(this.topHeadLinesModel);
}

class ErrorApiState extends NewsState {
  final Failure failure;

  ErrorApiState(this.failure);
}
