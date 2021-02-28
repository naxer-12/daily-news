import 'package:daily_news/features/weather_screen/presentation/widgets/weather_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WeatherAppBar(
        onSearch: () {
          print("SEARCH CALLED");
        },
      ),
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
          "London",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5.0),
          child: Text(
            "United Kingdom",
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
              getUpdatedTimeWidget(),
              SizedBox(
                height: 10,
              ),
              getWeatherStatus(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "19",
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
                  return getWeatherStatus();
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
      "Updated 12m ago",
      style: TextStyle(
        color: Colors.grey,
        fontSize: 12.0,
        letterSpacing: -0.5,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget getWeatherStatus() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Heavy Rain",
              style: TextStyle(
                color: Colors.black,
                letterSpacing: -1.0,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Thu",
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
              "06",
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
}
