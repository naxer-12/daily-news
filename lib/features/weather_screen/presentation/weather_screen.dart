import 'package:daily_news/core/di/InjectionContainer.dart';
import 'package:daily_news/core/preference/PrefHelper.dart';
import 'package:daily_news/core/util/shimmer_news.dart';
import 'package:daily_news/features/weather_screen/model/weather_model.dart';
import 'package:daily_news/features/weather_screen/presentation/bloc/weather_bloc.dart';
import 'package:daily_news/features/weather_screen/presentation/bloc/weather_states.dart';
import 'package:daily_news/features/weather_screen/presentation/widgets/weather_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:daily_news/core/util/date_utils.dart';
import 'package:timeago/timeago.dart' as timeago;

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Location location = new Location();
  LocationData locationData;
  WeatherModel weatherModel;
  PrefHelper helper = sl();
  DateTime currentWeatherDate;

  @override
  void initState() {
    fetchLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherStates>(
      builder: (context, state) {
        if (state is LoadingWeatherState) {
          return ShimmerNews();
        } else if (state is FetchedWeatherDataState) {
          weatherModel = state.weatherModel;
          currentWeatherDate = DateTime.fromMillisecondsSinceEpoch(
              weatherModel.current.dt * 1000);
          return Scaffold(
            // appBar: WeatherAppBar(
            //   onSearch: () {
            //     print("SEARCH CALLED");
            //   },
            // ),
            body: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  child: Image.asset(
                    "assets/mock_assets/russia_2.jpg",
                    fit: BoxFit.cover,
                    // colorBlendMode: ,
                    color: Colors.black.withOpacity(0.3),
                    colorBlendMode: BlendMode.hardLight,
                    // height: double.infinity,
                    // width: double.infinity,
                  ),
                ),
                Positioned(
                  top: 0.0,
                  child: yourLocationViewWidget(),
                ),
                Positioned(
                  child: countryLocation(),
                  top: 50.0,
                  left: 20.0,
                ),
                Positioned(
                  bottom: 1.0,
                  child: weatherLocation(),
                ),
              ],
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }

  Widget yourLocationViewWidget() {
    return Container(
      // decoration: BoxDecoration(
      //   border:Border.all(
      //     color: Colors.blueAccent,
      //     style: BorderStyle.none,
      //     width: 0.0
      //   ) ,
      //   borderRadius: BorderRadius.only(
      //
      //   )
      //
      // ),
      decoration: ShapeDecoration(
        color: Colors.lightBlueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(
            width: 0.0,
            style: BorderStyle.none,
            color: Colors.blueAccent,
          ),
        ),
      ),
      margin: EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 10.0,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 5.0,
      ),
      child: Text(
        "Your Location",
        style: TextStyle(
          color: Colors.white,
          fontSize: 10.0,
        ),
      ),
    );
  }

  Widget countryLocation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          helper.getPlace(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5.0),
          child: Text(
            helper.getCountry(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              letterSpacing: -1.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Widget weatherLocation() {
    String weatherDesc = "${weatherModel.current.weather[0].description[0].toUpperCase()}${weatherModel.current.weather[0].description.substring(1)}";
    String date = DateFormat('dd').format(currentWeatherDate);
    String weekDay = DateFormat('EEE').format(currentWeatherDate);
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          side: BorderSide(
            width: 0.0,
            style: BorderStyle.none,
            color: Colors.blueAccent,
          ),
        ),
      ),
      child: SingleChildScrollView(
        primary: true,
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getUpdatedTimeWidget(),
              SizedBox(
                height: 10,
              ),
              getWeatherStatus(weatherDesc, weekDay, date),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "19\u{00B0}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 60.0,
                      letterSpacing: -1.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(2.0),
                    decoration: ShapeDecoration(
                      color: Colors.lightBlueAccent,
                      shape: CircleBorder(
                        side: BorderSide.none,
                      ),
                    ),
                    child: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Next 7 days",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      letterSpacing: -1.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  getUpdatedTimeWidget()
                ],
              ),
              ListView.separated(
                primary: true,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext ctx, int data) {
                  return getWeatherStatus(weatherDesc, weekDay, date);
                },
                separatorBuilder: (BuildContext ctx, int data) {
                  return Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  );
                },
                itemCount: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  Text getUpdatedTimeWidget() {
    return Text(
      timeago.format(currentWeatherDate),
      style: TextStyle(
        color: Colors.grey,
        fontSize: 12.0,
        letterSpacing: -0.5,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget getWeatherStatus(String weatherDesc, String weekDay, String date) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              weatherDesc,
              style: TextStyle(
                color: Colors.black,
                letterSpacing: -1.0,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              weekDay,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                letterSpacing: -1.0,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              date,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                letterSpacing: -1.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        )
      ],
    );
  }

  Future<LocationData> fetchLocation() async {
    locationData = await location.getLocation();
    return locationData;
  }
}
