import 'package:daily_news/core/di/InjectionContainer.dart';
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

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is FetchNewsHeadLineEvent) {
      yield* fetchLatestHeadLines(event.context);
    }
  }

  Stream<NewsState> fetchLatestHeadLines(BuildContext context) async* {
    yield LoadingState();
    Placemark placeMark = await _determinePosition(context);
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
    bool serviceEnabled;
    LocationPermission permission;
    //
    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   return Future.error('Location services are disabled.');
    // }
    //
    // permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.deniedForever) {
    //   return Future.error(
    //       'Location permissions are permantly denied, we cannot request permissions.');
    // }
    //
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission != LocationPermission.whileInUse &&
    //       permission != LocationPermission.always) {
    //     return Future.error(
    //         'Location permissions are denied (actual value: $permission).');
    //   }
    // }
    bool isPermission = await PermissionUtil.getLocationPermission(context);
    if (isPermission) {
      Position position = await Geolocator.getCurrentPosition();
      print(position);
      List<Placemark> placeMark =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      return placeMark[0];
    }
  }
}
