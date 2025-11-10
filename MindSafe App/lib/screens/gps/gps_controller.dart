import 'package:firebase_database/firebase_database.dart';

class GpsController {
  final DatabaseReference _deviceMacRef = FirebaseDatabase.instance.ref('devices/watch/mac');
  final DatabaseReference _alertRef = FirebaseDatabase.instance.ref('alert');

  final DatabaseReference _latitudeRef = FirebaseDatabase.instance.ref('wearable/latitude');
  final DatabaseReference _longitudeRef = FirebaseDatabase.instance.ref('wearable/longitude');

  Stream<String?> get deviceMacStream => _deviceMacRef.onValue.map(
        (event) => event.snapshot.value?.toString(),
  );

  Stream<String?> get alertStream => _alertRef.onValue.map(
        (event) => event.snapshot.value?.toString(),
  );

  Stream<double?> get latitudeStream => _latitudeRef.onValue.map(
        (event) => event.snapshot.value != null ? double.tryParse(event.snapshot.value.toString()) : null,
  );

  Stream<double?> get longitudeStream => _longitudeRef.onValue.map(
        (event) => event.snapshot.value != null ? double.tryParse(event.snapshot.value.toString()) : null,
  );
}
