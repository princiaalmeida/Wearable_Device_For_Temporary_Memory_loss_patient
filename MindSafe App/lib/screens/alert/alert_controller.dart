import 'package:firebase_database/firebase_database.dart';

class AlertController {
  // Fall detection reference
  final DatabaseReference _fallDetectedRef = FirebaseDatabase.instance.ref('wearable/fallDetected');
  final DatabaseReference _fallAlertRef = FirebaseDatabase.instance.ref('alerts/fall');

  // Stream for boolean at /wearable/fallDetected
  Stream<bool> get fallDetectedStream => _fallDetectedRef.onValue
      .map((event) => event.snapshot.value == true);

  // Stream for human-readable message at /alerts/fall (returns "" if not present)
  Stream<String> get fallAlertStream => _fallAlertRef.onValue
      .map((event) => event.snapshot.value?.toString() ?? '');

  // --- Emergency Contact Streams/Methods: unchanged ---
  final DatabaseReference _contactsRef = FirebaseDatabase.instance.ref('emergency_contacts');

  Stream<List<Map<String, dynamic>>> get contactsStream => _contactsRef.onValue.map((event) {
    final data = event.snapshot.value;
    if (data is Map<dynamic, dynamic>) {
      return data.entries.map((e) {
        return {
          'key': e.key as String,
          'name': e.value['name'] ?? '',
          'number': e.value['number'] ?? '',
        };
      }).toList();
    }
    return [];
  });

  Future<void> addContact(String name, String number) async {
    await _contactsRef.push().set({'name': name, 'number': number});
  }

  Future<void> editContact(String key, String name, String number) async {
    await _contactsRef.child(key).set({'name': name, 'number': number});
  }

  Future<void> deleteContact(String key) async {
    await _contactsRef.child(key).remove();
  }
}
