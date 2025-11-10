import 'package:flutter/material.dart';
import 'alert_controller.dart';

class AlertScreen extends StatefulWidget {
  const AlertScreen({Key? key}) : super(key: key);

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> with TickerProviderStateMixin {
  final AlertController _controller = AlertController();

  String? editingKey;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  Future<void> _showContactDialog({String? key, String? name, String? number}) async {
    nameController.text = name ?? '';
    numberController.text = number ?? '';
    editingKey = key;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(key == null ? 'Add Emergency Contact' : 'Edit Emergency Contact'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: numberController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (editingKey == null) {
                  await _controller.addContact(nameController.text, numberController.text);
                } else {
                  await _controller.editContact(editingKey!, nameController.text, numberController.text);
                }
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
    editingKey = null;
    nameController.clear();
    numberController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final Color purpleStart = const Color(0xFFDAD7FE);
    final Color purpleEnd = const Color(0xFFF5E9FC);
    final Color purpleAccent = Colors.deepPurpleAccent;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fall Detection Alerts'),
        backgroundColor: purpleAccent,
        elevation: 1,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [purpleStart, purpleEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 28),
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 18),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StreamBuilder<bool>(
                      stream: _controller.fallDetectedStream,
                      builder: (context, snapshot) {
                        final fallDetected = snapshot.data == true;
                        if (fallDetected) {
                          return StreamBuilder<String>(
                            stream: _controller.fallAlertStream,
                            builder: (context, alertSnapshot) {
                              final alertText = (alertSnapshot.data?.isNotEmpty == true)
                                  ? alertSnapshot.data!
                                  : "Fall Detected!";
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(vertical: 9, horizontal: 4),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade100.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.redAccent.withOpacity(0.18),
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                    )
                                  ],
                                ),
                                child: ListTile(
                                  leading: const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 34),
                                  title: Text(
                                    "⚠️ $alertText",
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Immediate attention may be needed.',
                                    style: TextStyle(
                                      color: Colors.red.shade800,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            "No falls detected. Patient is safe.",
                            style: TextStyle(
                              color: Colors.green.shade700,
                              fontSize: 18,
                              letterSpacing: 0.5,
                            ),
                          ),
                        );
                      },
                    ),

                    // Emergency Contact List Section (unchanged)
                    Padding(
                      padding: const EdgeInsets.only(top: 24, left: 8, right: 8, bottom: 7),
                      child: Row(
                        children: [
                          const Text(
                            "Emergency Contacts",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline, color: Colors.deepPurple),
                            onPressed: () => _showContactDialog(),
                          ),
                        ],
                      ),
                    ),
                    StreamBuilder<List<Map<String, dynamic>>>(
                      stream: _controller.contactsStream,
                      builder: (context, snapshot) {
                        final contacts = snapshot.data ?? [];
                        return Column(
                          children: [
                            for (var contact in contacts)
                              Card(
                                elevation: 4,
                                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                                color: Colors.deepPurple[50],
                                child: ListTile(
                                  leading: const Icon(Icons.phone, color: Colors.deepPurpleAccent),
                                  title: Text(contact['name']),
                                  subtitle: Text(contact['number']),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit, color: Colors.orange),
                                        onPressed: () => _showContactDialog(
                                            key: contact['key'],
                                            name: contact['name'],
                                            number: contact['number']),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete, color: Colors.red),
                                        onPressed: () => _controller.deleteContact(contact['key']),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            if (contacts.isEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 12, bottom: 10),
                                child: Text(
                                  "No emergency contacts saved.",
                                  style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
                                ),
                              ),
                          ],
                        );
                      },
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
