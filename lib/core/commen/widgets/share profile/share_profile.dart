import 'package:share_plus/share_plus.dart';

class ShareProfile {
  static void shareAuthorProfile(String userID, String userName) {
    final profileUrl = Uri(
      scheme: 'http',
      host: '192.168.0.184',
      port: 8080,
      path: '/author-profile/$userID',
      query: '@${userName.replaceAll(' ', '_')}',
    );
    SharePlus.instance.share(
      ShareParams(
        subject: 'Author Profile',
        text:
            'Check out @${userName.replaceAll(' ', '_')} on BlogNode!\n$profileUrl',
      ),
    );
  }
}
