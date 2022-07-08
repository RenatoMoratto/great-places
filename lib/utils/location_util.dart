import 'package:flutter_dotenv/flutter_dotenv.dart';

class LocationUtil {
  static String generateLocationPreviewImage({
    required double latitude,
    required double longitude,
  }) {
    String googleApiKey = dotenv.get(
      'GOOGLE_API_KEY',
      fallback: 'Google API KEY not found',
    );
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$googleApiKey';
  }
}
