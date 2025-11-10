import 'package:flutter/material.dart';
import 'register_controller.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();
  final phoneController = TextEditingController();
  final bloodGroupController = TextEditingController();
  final emergencyContactNameController = TextEditingController();
  final emergencyContactPhoneController = TextEditingController();
  final addressController = TextEditingController();

  final RegisterController _registerController = RegisterController();

  void _onRegisterPressed() async {
    try {
      await _registerController.register(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
        age: ageController.text,
        gender: genderController.text,
        phone: phoneController.text,
        bloodGroup: bloodGroupController.text,
        emergencyName: emergencyContactNameController.text,
        emergencyPhone: emergencyContactPhoneController.text,
        address: addressController.text,
      );
      Navigator.of(context).pushNamed('/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration failed: ${e.toString()}")),
      );
    }
  }

  Widget buildCardTextField(TextEditingController controller, String hint,
      {IconData? icon, bool obscureText = false, TextInputType? keyboardType}) {
    final Color purpleAccent = Colors.deepPurpleAccent;
    return Material(
      elevation: 7,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            prefixIcon: icon != null ? Icon(icon, color: purpleAccent) : null,
            border: InputBorder.none,
            hintText: hint,
            contentPadding: const EdgeInsets.symmetric(vertical: 18),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color purpleStart = const Color(0xFFDAD7FE);
    final Color purpleEnd = const Color(0xFFF5E9FC);
    final Color purpleAccent = Colors.deepPurpleAccent;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [purpleStart, purpleEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Card(
              elevation: 13,
              margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 28),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 38, horizontal: 28),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 44,
                          width: 44,
                          decoration: BoxDecoration(
                            color: purpleAccent.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(Icons.health_and_safety, color: Colors.deepPurpleAccent, size: 29),
                        ),
                        const SizedBox(width: 13),
                        const Text(
                          "Mind Safe",
                          style: TextStyle(
                            color: Colors.deepPurpleAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 27),
                    buildCardTextField(emailController, "Email", icon: Icons.email_outlined),
                    const SizedBox(height: 15),
                    buildCardTextField(passwordController, "Password", icon: Icons.lock_outline, obscureText: true),
                    const SizedBox(height: 15),
                    buildCardTextField(nameController, "Full Name", icon: Icons.person_outline),
                    const SizedBox(height: 15),
                    buildCardTextField(ageController, "Age", icon: Icons.numbers, keyboardType: TextInputType.number),
                    const SizedBox(height: 15),
                    buildCardTextField(genderController, "Gender", icon: Icons.wc),
                    const SizedBox(height: 15),
                    buildCardTextField(phoneController, "Phone Number", icon: Icons.phone, keyboardType: TextInputType.phone),
                    const SizedBox(height: 15),
                    buildCardTextField(bloodGroupController, "Blood Group", icon: Icons.bloodtype),
                    const SizedBox(height: 15),
                    buildCardTextField(emergencyContactNameController, "Emergency Contact Name", icon: Icons.person),
                    const SizedBox(height: 15),
                    buildCardTextField(emergencyContactPhoneController, "Emergency Contact Phone", icon: Icons.phone, keyboardType: TextInputType.phone),
                    const SizedBox(height: 15),
                    buildCardTextField(addressController, "Address", icon: Icons.home_outlined),
                    const SizedBox(height: 28),
                    Material(
                      elevation: 7,
                      borderRadius: BorderRadius.circular(23),
                      child: InkWell(
                        onTap: _onRegisterPressed,
                        borderRadius: BorderRadius.circular(23),
                        child: Container(
                          height: 54,
                          decoration: BoxDecoration(
                            color: purpleAccent,
                            borderRadius: BorderRadius.circular(23),
                          ),
                          child: const Center(
                            child: Text(
                              "Register",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                letterSpacing: 0.6,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
