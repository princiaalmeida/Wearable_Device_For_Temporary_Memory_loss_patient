import 'package:flutter/material.dart';
import 'vitals_controller.dart';

class VitalsScreen extends StatefulWidget {
  const VitalsScreen({Key? key}) : super(key: key);

  @override
  State<VitalsScreen> createState() => _VitalsScreenState();
}

class _VitalsScreenState extends State<VitalsScreen> {
  final VitalsController _controller = VitalsController();

  @override
  Widget build(BuildContext context) {
    final Color purpleStart = const Color(0xFFDAD7FE);
    final Color purpleEnd = const Color(0xFFF5E9FC);
    final Color purpleAccent = Colors.deepPurpleAccent;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Real-Time Vitals Monitoring'),
        backgroundColor: purpleAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [purpleStart, purpleEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
          child: StreamBuilder<double?>(
            stream: _controller.heartRateStream,
            builder: (context, hrSnapshot) {
              return StreamBuilder<double?>(
                stream: _controller.spo2Stream,
                builder: (context, spo2Snapshot) {
                  return StreamBuilder<double?>(
                    stream: _controller.tempStream,
                    builder: (context, tempSnapshot) {
                      return StreamBuilder<double?>(
                        stream: _controller.temperatureStream,
                        builder: (context, temp2Snapshot) {
                          final hr = hrSnapshot.data;
                          final spo2 = spo2Snapshot.data;
                          // Use whichever is present, temp or temperature
                          final temp = tempSnapshot.data ?? temp2Snapshot.data;

                          String? alertMsg;
                          if (hr != null && (hr < 60 || hr > 100)) {
                            alertMsg = "⚠️ Heart Rate abnormal!";
                          } else if (spo2 != null && spo2 < 92) {
                            alertMsg = "⚠️ SpO2 abnormal!";
                          } else if (temp != null && (temp > 38 || temp > 36)) {
                            alertMsg = "⚠️ Temperature abnormal!";
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _VitalsCard(
                                title: 'Heart Rate',
                                value: hr,
                                icon: Icons.favorite,
                                iconColor: Colors.redAccent,
                                suffix: 'bpm',
                                bgColor: Colors.pink.shade50,
                              ),
                              _VitalsCard(
                                title: 'Blood Oxygen (SpO2)',
                                value: spo2,
                                icon: Icons.bloodtype,
                                iconColor: Colors.blueAccent,
                                suffix: '%',
                                bgColor: Colors.blue.shade50,
                              ),
                              _VitalsCard(
                                title: 'Body Temperature',
                                value: temp,
                                icon: Icons.thermostat,
                                iconColor: Colors.orange,
                                suffix: '°C',
                                bgColor: Colors.orange.shade50,
                                decimal: true,
                              ),
                              if (alertMsg != null)
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 14),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent.withOpacity(0.14),
                                    borderRadius: BorderRadius.circular(17),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.redAccent.withOpacity(0.09),
                                        blurRadius: 14,
                                        spreadRadius: 2,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.error, color: Colors.red, size: 29),
                                      const SizedBox(width: 18),
                                      Expanded(
                                        child: Text(
                                          alertMsg,
                                          style: const TextStyle(
                                            color: Colors.red,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _VitalsCard extends StatelessWidget {
  final String title;
  final double? value;
  final IconData icon;
  final Color iconColor;
  final String suffix;
  final Color bgColor;
  final bool decimal;

  const _VitalsCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
    required this.suffix,
    required this.bgColor,
    this.decimal = false,
  });

  @override
  Widget build(BuildContext context) {
    String label;
    if (value != null) {
      label = decimal ? '${value!.toStringAsFixed(1)} $suffix'
          : '${value!.toStringAsFixed(0)} $suffix';
    } else {
      label = 'Loading...';
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: bgColor.withOpacity(0.15),
            blurRadius: 12,
            spreadRadius: 1,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 32),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w700,
                fontSize: 19,
              ),
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: iconColor,
              fontWeight: FontWeight.bold,
              fontSize: 19,
            ),
          ),
        ],
      ),
    );
  }
}
