import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class WeatherAppBar extends StatelessWidget implements PreferredSizeWidget {
  WeatherAppBar({
    Key key,
    this.search = true,
    this.onSearch,
  })  : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  final bool search;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    // final imageHeight = 48.0;
    return AppBar(
      /* centerTitle: true,
      title: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: Theme.of(context).brightness == Brightness.light
            ? Image.asset(
          'assets/flutter_europe.png',
          height: imageHeight,
          key: ValueKey('logo_image_1'),
        )
            : Image.asset(
          'assets/flutter_europe_dark.png',
          height: imageHeight,
          key: ValueKey('logo_image_2'),
        ),
      ),*/
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      brightness: Theme.of(context).brightness,
      iconTheme: Theme.of(context)
          .iconTheme
          .copyWith(color: Theme.of(context).accentColor),
      leading: Semantics(
        button: true,
        enabled: true,
        focusable: true,
        child: Tooltip(
          message: 'Search for location',
          child: Container(
            child: IconButton(
              color: Theme.of(context).accentColor,
              icon: Icon(Icons.search),
              onPressed: onSearch,
            ),
          ),
        ),
      ),
      actions: <Widget>[
        ToggleLayoutButton(),
      ],
    );
  }

  @override
  final Size preferredSize;
}

class ToggleLayoutButton extends StatelessWidget {
  const ToggleLayoutButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: true,
      focusable: true,
      hint: 'Change the Unit of Weather',
      child: Tooltip(
        message: 'Change the Unit of Weather',
        child: IconButton(
          color: Theme.of(context).accentColor,
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
      ),
    );
  }
}
