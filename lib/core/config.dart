/// Alamat situs web Django (PWS) yang menyediakan web service.
///
/// Default ke deployment PWS. Untuk server lokal:
///   flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000   (emulator Android)
///   flutter run -d chrome --dart-define=API_BASE_URL=http://127.0.0.1:8000
const String apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'https://adinata-alaudin51-foodwaste.pws.cs.ui.ac.id',
);
