import 'package:daily_news/features/news_screen/presentation/bloc/news_screen_bloc.dart';
import 'package:daily_news/features/news_screen/presentation/bloc/news_screen_events.dart';
import 'package:daily_news/features/news_screen/presentation/news_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsScreenBloc>(
      create: (context) => NewsScreenBloc()
        ..add(
          FetchNewsHeadLineEvent(context),
        ),
      child: NewsScreen(),
    );
  }
}
