import 'package:daily_news/core/util/shimmer_news.dart';
import 'package:daily_news/features/news_screen/presentation/bloc/news_screen_states.dart';
import 'package:daily_news/features/news_screen/presentation/news_content_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:daily_news/features/news_screen/model/top_headlines_model.dart';
import 'bloc/news_screen_bloc.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen>
    with AutomaticKeepAliveClientMixin {
  PageController _pageController = PageController(keepPage: true);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<NewsScreenBloc, NewsState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return ShimmerNews();
            } else if (state is FetchedNewsScreenState) {
              return PageView.builder(
                scrollDirection: Axis.vertical,
                controller: _pageController,
                itemCount: state.topHeadLinesModel.articles.length,
                itemBuilder: (BuildContext context, int index) {
                  Articles articles = state.topHeadLinesModel.articles[index];
                  return NewsContentScreen(
                    articles: articles,
                  );
                },
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
    return PageView.builder(
      scrollDirection: Axis.vertical,
      controller: _pageController,
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return Scaffold(
          body: SafeArea(
            child: ShimmerNews(),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
