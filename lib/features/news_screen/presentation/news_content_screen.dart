import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_news/features/news_screen/model/top_headlines_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:daily_news/core/util/date_utils.dart';
import 'package:flutter_icons/flutter_icons.dart';

class NewsContentScreen extends StatelessWidget {
  final Articles articles;

  const NewsContentScreen({Key key, this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        articles.urlToImage != null
            ? CachedNetworkImage(
                imageUrl: articles.urlToImage,
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
              )
            : SizedBox.shrink(),
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
          articles.author != null && articles.author.isNotEmpty
              ? Text(
                  "By : ${articles.author}",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 14,
                      fontStyle: FontStyle.italic),
                )
              : Text(
                  "By : Anonymous",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 14,
                      fontStyle: FontStyle.italic),
                ),
          if (articles.publishedAt != null &&
              articles.publishedAt.isNotEmpty) ...[
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
              articles.publishedAt.getPublishedDate(),
            )
          ]
        ],
      ),
    );
  }

  Widget articleTitle() {
    return articles.title != null && articles.title.isNotEmpty
        ? Text(
            articles.title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 25,
            ),
          )
        : SizedBox.shrink();
  }

  Widget publishedContent() {
    return articles.description != null && articles.description.isNotEmpty
        ? Text(
            articles.description,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 20,
            ),
          )
        : SizedBox.shrink();
  }

  Widget articleSource() {
    return articles.source.name != null && articles.source.name.isNotEmpty
        ? RichText(
            text: TextSpan(
              text: 'Read more at ${articles.source.name}',
              style: TextStyle(color: Colors.blueAccent, fontSize: 18),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print("HEllo!");
                },
            ),
          )
        : SizedBox.shrink();
  }
}
