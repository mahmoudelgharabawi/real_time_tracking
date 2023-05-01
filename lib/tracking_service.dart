import 'package:real_time_tracking_project/vehicle.dart';
import 'package:web_socket_channel/io.dart';

class TrackingService {
  static late IOWebSocketChannel _channel;
  static init() {
    startTracking();
  }

  static void startTracking() {
    // use 10.0.2.2 in emulator case
    // in other case use localhost
    _channel = IOWebSocketChannel.connect(
        Uri.parse('ws://10.0.2.2:8080/fakeTracking'));
  }

  static Future<void> stopTracking() async => _channel.sink.close();

  static Stream<List<Vehicle>> get nearestVehicles =>
      _channel.stream.map((event) => vehicleFromJson(event));
}
