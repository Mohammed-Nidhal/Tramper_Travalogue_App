import 'package:url_launcher/url_launcher.dart';

whatsapp(number) {
  String webUrl = 'https://api.whatsapp.com/send/?phone=$number&text=hi';
  launch(webUrl);
}

call(number) {
  String callUrl = "tel://$number";
  launch(callUrl);
}

email(email) {
  String mailUrl = "mailto:$email";
  launch(mailUrl);
}
