import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String age,
    required String gender,
    required String phone,
    required String bloodGroup,
    required String emergencyName,
    required String emergencyPhone,
    required String address,
  }) async {
    UserCredential userCredential =
    await _auth.createUserWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;

    await _firestore.collection('patients').doc(user!.uid).set({
      'email': email,
      'name': name,
      'age': age,
      'gender': gender,
      'phone': phone,
      'blood_group': bloodGroup,
      'emergency_contact_name': emergencyName,
      'emergency_contact_phone': emergencyPhone,
      'address': address,
      'created_at': FieldValue.serverTimestamp(),
    });
  }
}
