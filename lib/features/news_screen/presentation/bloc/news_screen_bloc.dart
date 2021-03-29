import 'package:daily_news/core/di/injection_container.dart';
import 'package:daily_news/core/preference/pref_helper.dart';
import 'package:daily_news/core/util/api_keys_constant.dart';
import 'package:daily_news/features/news_screen/domain/repository/top_headlines_repo.dart';
import 'package:daily_news/features/news_screen/presentation/bloc/news_screen_events.dart';
import 'package:daily_news/features/news_screen/presentation/bloc/news_screen_states.dart';
import 'package:daily_news/core/util/permission_util.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class NewsScreenBloc extends Bloc<NewsEvent, NewsState> {
  NewsScreenBloc() : super(InitialState());
  TopHeadlinesRepo topHeadlinesRepo = sl();
  PrefHelper helper = sl();

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is FetchNewsHeadLineEvent) {
      yield* fetchLatestHeadLines(event.context);
    }
  }

  Stream<NewsState> fetchLatestHeadLines(BuildContext context) async* {
    yield LoadingState();
    Placemark placeMark = await _determinePosition(context);

    helper.setUserLocation(placeMark);

    final output = await topHeadlinesRepo.fetchLatestData(
        placeMark.isoCountryCode, NEWS_API_KEY);

    yield* output.fold(
      (failure) async* {
        yield ErrorApiState(failure);
      },
      (responseModel) async* {
        yield FetchedNewsScreenState(responseModel.model);
      },
    );
  }

  Future<Placemark> _determinePosition(BuildContext context) async {
    print("LOCATION PERMISSION :: REQUESTED");
    bool isPermission = await PermissionUtil.getLocationPermission(context);

    if (isPermission) {
      print("LOCATION PERMISSION :: ACCEPTED");

      try {
        Position position = await Geolocator.getCurrentPosition();
        print("LOCATION PERMISSION :: GOT POSITION");

        await helper.setUserPosition(position);
        List<Placemark> placeMark = await placemarkFromCoordinates(
            position.latitude, position.longitude);
        print("LOCATION PERMISSION :: GETTING PLACEMARK");

        return placeMark[0];
      } catch (e) {
        print(e);
      }
    }
  }
}
