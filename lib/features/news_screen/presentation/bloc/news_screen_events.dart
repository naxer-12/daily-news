
import 'package:flutter/widgets.dart';

abstract class NewsEvent {}

class FetchNewsHeadLineEvent extends NewsEvent {
  final BuildContext context;

  FetchNewsHeadLineEvent(this.context);

}
