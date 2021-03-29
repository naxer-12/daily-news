import 'package:daily_news/core/di/injection_container.dart';
import 'package:daily_news/core/preference/pref_helper.dart';
import 'package:daily_news/core/util/custom_blurhash_widget.dart';
import 'package:daily_news/core/util/shimmer_news.dart';
import 'package:daily_news/core/util/weather_icon_icons.dart';
import 'package:daily_news/features/weather_screen/model/weather_model.dart';
import 'package:daily_news/features/weather_screen/presentation/bloc/weather_bloc.dart';
import 'package:daily_news/features/weather_screen/presentation/bloc/weather_event.dart';
import 'package:daily_news/features/weather_screen/presentation/bloc/weather_states.dart';
import 'package:daily_news/features/weather_screen/presentation/widgets/weather_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:daily_news/core/util/date_utils.dart';
import 'package:timeago/timeago.dart' as timeago;

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  WeatherModel weatherModel;
  PrefHelper helper = sl();
  bool status = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: WeatherAppBar(
      //   onSearch: () {
      //     print("SEARCH CALLED");
      //   },
      // ),
      body: SafeArea(
        child: BlocBuilder<WeatherBloc, WeatherStates>(
          builder: (context, state) {
            if (state is LoadingWeatherState) {
              return ShimmerNews();
            } else if (state is FetchedWeatherDataState) {
              weatherModel = state.weatherModel;

              return Stack(
                fit: StackFit.expand,
                children: [
                  state.randomImageModel != null
                      ? CustomBlurHash(
                          hash: state.randomImageModel?.blurHash,
                          image: state.randomImageModel?.urls?.regular,
                          imageFit: BoxFit.cover,
                        )
                      : Container(
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
                    top: 10.0,
                    right: 10.0,
                    child: metricSwitch(),
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
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
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
              getUpdatedTimeWidget(weatherModel.current.dt),
              SizedBox(
                height: 10,
              ),
              getWeatherStatus(
                  weatherModel.current.weather, weatherModel.current.dt, false),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 25.0,
                        ),
                        child: Text(
                          "${weatherModel.current.temp}\u{00B0}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 60.0,
                              letterSpacing: -1.0,
                              fontWeight: FontWeight.w200,
                              fontFamily: "Library"),
                        ),
                      ),
                      Positioned(
                        top: 30,
                        child: getWeatherIcon(
                            50, 50, weatherModel.current.weather[0].icon),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(2.0),
                    decoration: ShapeDecoration(
                      color: Colors.lightBlueAccent,
                      shape: CircleBorder(
                        side: BorderSide.none,
                      ),
                    ),
                    child: InkWell(
                      child: Icon(
                        Icons.refresh,
                        color: Colors.white,
                      ),
                      onTap: () {
                        BlocProvider.of<WeatherBloc>(context)
                            .add(FetchWeatherDataEvent());
                      },
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
                  getUpdatedTimeWidget(weatherModel.current.dt)
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ListView.separated(
                  primary: true,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext ctx, int data) {
                    return getWeatherStatus(
                      weatherModel.daily[data].weather,
                      weatherModel.daily[data].dt,
                      true,
                    );
                  },
                  separatorBuilder: (BuildContext ctx, int data) {
                    return Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                    );
                  },
                  itemCount: weatherModel.daily.length)
            ],
          ),
        ),
      ),
    );
  }

  Widget getWeatherIcon(double height, double width, String icon) {
    return Container(
      child: Image.network(
        "https://openweathermap.org/img/wn/$icon@2x.png",
        width: width,
        height: height,
        colorBlendMode: BlendMode.hardLight,
        // height: double.infinity,
        // width: double.infinity,
      ),
    );
  }

  Text getUpdatedTimeWidget(num dateValue) {
    DateTime currentWeatherDate;
    currentWeatherDate = DateTime.fromMillisecondsSinceEpoch(dateValue * 1000);
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

  Widget getWeatherStatus(List<Weather> weather, num dateValue, bool withIcon) {
    DateTime currentWeatherDate;
    currentWeatherDate = DateTime.fromMillisecondsSinceEpoch(dateValue * 1000);
    String weatherDesc =
        "${weather[0].description[0].toUpperCase()}${weather[0].description.substring(1)}";
    String date = DateFormat('dd').format(currentWeatherDate);
    String weekDay = DateFormat('EEE').format(currentWeatherDate);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (withIcon) getWeatherIcon(35, 35, weather[0].icon),
            Text(
              weatherDesc,
              style: TextStyle(
                color: Colors.black,
                letterSpacing: -1.0,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  weekDay,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    letterSpacing: -1.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
            ),
          ],
        ),
      ],
    );
  }

  Widget metricSwitch() {
    return FlutterSwitch(
      width: 100.0,
      height: 40.0,
      valueFontSize: 25.0,
      toggleSize: 45.0,
      value: helper.getMetrics(),
      borderRadius: 30.0,
      padding: 8.0,
      activeIcon: Icon(
        WeatherIcon.celsius,
        size: 18.0,
      ),
      inactiveIcon: Icon(WeatherIcon.fahrenheit_degrees),
      activeColor: Colors.white,

      inactiveColor: Colors.white,
      onToggle: (val) async {
        await helper.setUnitMetrics(val);
        BlocProvider.of<WeatherBloc>(context).add(FetchWeatherDataEvent());
      },
    );
  }
}
