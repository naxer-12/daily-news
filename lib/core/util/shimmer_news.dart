import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildShimmer(context, MediaQuery.of(context).size.height / 3,
            MediaQuery.of(context).size.width),
        Container(
          margin: EdgeInsets.all(14.0),
          child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.0,
              ),
              buildShimmer(context, 20, MediaQuery.of(context).size.width),
              SizedBox(
                height: 10.0,
              ),
              buildShimmer(context, 20, MediaQuery.of(context).size.width / 2),
              SizedBox(
                height: 40.0,
              ),
              buildShimmer(context, 20, MediaQuery.of(context).size.width),
              SizedBox(
                height: 10.0,
              ),
              buildShimmer(context, 20, MediaQuery.of(context).size.width),
              SizedBox(
                height: 10.0,
              ),
              buildShimmer(context, 20, MediaQuery.of(context).size.width),
              SizedBox(
                height: 10.0,
              ),
              buildShimmer(context, 20, MediaQuery.of(context).size.width / 2),
              Align(
                heightFactor: 10,
                alignment: Alignment.bottomLeft,
                child: Shimmer.fromColors(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 20,
                    color: Colors.grey,
                  ),
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget buildShimmer(BuildContext context, double height, double width) {
    return Shimmer.fromColors(
      child: Container(
        width: width,
        height: height,
        color: Colors.grey,
      ),
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
    );
  }
}
