// lib/iphone_shell.dart
import 'package:flutter/material.dart';

class iPhoneShell extends StatelessWidget {
  final Widget child;
  const iPhoneShell({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final dw = sw.clamp(290.0, 330.0);
    final dh = dw * (844 / 390);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: dw,
              height: dh,
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(color: Colors.grey.shade400, width: 2),
                borderRadius: BorderRadius.circular(48),
                boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 16, offset: Offset(0, 10))],
              ),
            ),
            Positioned(right: -6, top: dh * 0.33, child: Container(width: 4, height: dh * 0.08, decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.circular(2)))),
            Positioned(left: -6, top: dh * 0.24, child: Column(children: [
              Container(width: 4, height: dh * 0.05, margin: EdgeInsets.only(bottom: 10), decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.circular(2))),
              Container(width: 4, height: dh * 0.05, decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.circular(2))),
            ])),
            Positioned(left: -6, top: dh * 0.19, child: Container(width: 4, height: 20, decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.circular(2)))),
            Positioned(top: 2, left: 2, right: 2, bottom: 2, child: ClipRRect(borderRadius: BorderRadius.circular(40), child: Container(color: Colors.white, child: child))),
            Positioned(top: 0, left: (dw - 140) / 2, child: Container(width: 140, height: 30, decoration: BoxDecoration(color: Colors.black, border: Border.all(color: Colors.grey.shade400, width: 2), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))))),
            Positioned(bottom: 10, left: (dw - 80) / 2, child: Container(width: 80, height: 6, decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(3)))),
          ],
        ),
      ),
    );
  }
}
