import 'package:flutter/material.dart';

class iPhoneShell extends StatelessWidget {
  final Widget child;

  const iPhoneShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Container(
          width: 390, // iPhone 12 width
          height: 844, // iPhone 12 height
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Colors.black87, width: 5),
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 20,
                offset: Offset(0, 10),
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(36),
            child: child,
          ),
        ),
      ),
    );
  }
}
