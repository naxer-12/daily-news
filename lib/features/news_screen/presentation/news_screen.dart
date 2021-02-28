import 'package:daily_news/features/news_screen/presentation/news_content_screen.dart';
import 'package:flutter/material.dart';

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
    return PageView.builder(
      scrollDirection: Axis.vertical,
      controller: _pageController,
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return Scaffold(
          body: SafeArea(
            child: NewsContentScreen(),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
