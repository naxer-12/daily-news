import 'package:intl/intl.dart';

extension DateFormatter on String {
  String getPublishedDate() {
    String date = this.isEmpty
        ? ""
        : DateFormat("dd MMM 'at' hh:mm a")
            .format(DateFormat("yyyy-MM-dd'T'hh:mm:ssZ").parse(this));
    return date;
  }
}
