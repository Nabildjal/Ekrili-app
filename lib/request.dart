import 'package:flutter/material.dart';

class request extends StatefulWidget {
  const request({super.key});

  @override
  State<request> createState() => _requestState();
}

class _requestState extends State<request> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
  backgroundColor: const Color(0xFF0A0A45),
  body: Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05), // softer dark card
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.orangeAccent.withOpacity(0.3)),
        ),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle_outline, size: 64, color: Colors.orangeAccent),
            const SizedBox(height: 16),
            Text(
              'Your command will be analyzed,\nthank you for your confidence!',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.orangeAccent,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  ),
);
;
  }
}