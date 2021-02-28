import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:daily_news/core/util/date_utils.dart';
import 'package:flutter_icons/flutter_icons.dart';

class NewsContentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl:
              "https://nypost.com/wp-content/uploads/sites/2/2021/02/GameStopGasparino.jpg?quality=90&strip=all&w=1200",
          placeholder: (context, url) => Image(
              image: CachedNetworkImageProvider(
                "http://via.placeholder.com/450x250",
              ),
            ),
          placeholderFadeInDuration: Duration(
            milliseconds: 500,
          ),
          fit: BoxFit.fitHeight,
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: EdgeInsets.all(14.0),
          child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.0,
              ),
              articleTitle(),
              SizedBox(
                height: 40.0,
              ),
              publishedDescription(),
              SizedBox(
                height: 25.0,
              ),
              publishedContent(),
              Align(
                heightFactor: 3,
                alignment: Alignment.bottomLeft,
                child: articleSource(),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget publishedDescription() {
    return IntrinsicHeight(
      child: Row(
        children: [
          Text(
            "By : Charles Gasparino",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 14,
                fontStyle: FontStyle.italic),
          ),
          VerticalDivider(
            color: Colors.black,
          ),
          Icon(
            FlutterIcons.clock_fea,
            size: 18.0,
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            "2021-02-28T02:29:20Z".getPublishedDate(),
          )
        ],
      ),
    );
  }

  Widget articleTitle() {
    return Text(
      "‘Share-plunge’ GameStop traders serve valuable function",
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.black,
        fontSize: 25,
      ),
    );
  }

  Widget publishedContent() {
    return Text(
      "The number of deaths of New Mexico residents related to COVID-19 is now 3,700.The number of deaths of New Mexico residents related to COVID-19 is now 3,700.The number of deaths of New Mexico residents related to COVID-19 is now 3,700.The number of deaths of New Mexico residents related to COVID-19 is now 3,700.",
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.black,
        fontSize: 20,
      ),
    );
  }

  Widget articleSource() {
    return RichText(
      text: TextSpan(
        text: 'Read more at fox news ',
        style: TextStyle(color: Colors.blueAccent, fontSize: 18),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            print("HEllo!");
          },
      ),
    );
  }
}
