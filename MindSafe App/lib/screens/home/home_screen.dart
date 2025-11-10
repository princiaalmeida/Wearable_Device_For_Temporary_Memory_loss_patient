import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  // Soft purple gradient colors
  final Color purpleStart = const Color(0xFFDAD7FE);
  final Color purpleEnd = const Color(0xFFF5E9FC);
  final Color purpleAccent = Colors.deepPurpleAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient background (matches GPS Tracking image theme)
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [purpleStart, purpleEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 17),
                  children: [
                    _MenuCard(
                      icon: Icons.location_on,
                      label: "GPS Tracking",
                      color: purpleAccent,
                      onTap: () => Navigator.pushNamed(context, '/gps'),
                    ),
                    const SizedBox(height: 28),
                    _MenuCard(
                      icon: Icons.monitor_heart_outlined,
                      label: "Check Vitals",
                      color: purpleAccent,
                      onTap: () => Navigator.pushNamed(context, '/vitals'),
                    ),
                    const SizedBox(height: 28),
                    _MenuCard(
                      icon: Icons.access_alarm_rounded,
                      label: "Medicine Reminder",
                      color: purpleAccent,
                      onTap: () => Navigator.pushNamed(context, '/reminder'),
                    ),
                    const SizedBox(height: 28),
                    _MenuCard(
                      icon: Icons.warning_amber_rounded,
                      label: "Emergency Alert",
                      color: purpleAccent,
                      onTap: () => Navigator.pushNamed(context, '/alert'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent.withOpacity(0.87),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurpleAccent.withOpacity(0.09),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.health_and_safety, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 20),
          const Expanded(
            child: Text(
              "Mind Safe",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 28,
                letterSpacing: 0.7,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Removed profile circle avatar for cleaner app bar
        ],
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  const _MenuCard({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      shadowColor: color.withOpacity(0.22),
      borderRadius: BorderRadius.circular(23),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(23),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(23),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 36),
              const SizedBox(width: 22),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
