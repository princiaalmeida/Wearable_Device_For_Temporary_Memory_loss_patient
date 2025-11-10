import 'package:firebase_database/firebase_database.dart';

class VitalsController {
  final DatabaseReference _wearableRef = FirebaseDatabase.instance.ref('wearable');

  Stream<double?> get heartRateStream => _wearableRef.child('heartRate').onValue.map(
        (event) => event.snapshot.value != null ? double.tryParse(event.snapshot.value.toString()) : null,
  );

  Stream<double?> get spo2Stream => _wearableRef.child('spo2').onValue.map(
        (event) => event.snapshot.value != null ? double.tryParse(event.snapshot.value.toString()) : null,
  );

  Stream<double?> get tempStream => _wearableRef.child('temp').onValue.map(
        (event) {
      if (event.snapshot.value != null) {
        return double.tryParse(event.snapshot.value.toString());
      } else {
        return null;
      }
    },
  );

  Stream<double?> get temperatureStream => _wearableRef.child('temperature').onValue.map(
        (event) => event.snapshot.value != null ? double.tryParse(event.snapshot.value.toString()) : null,
  );
}
