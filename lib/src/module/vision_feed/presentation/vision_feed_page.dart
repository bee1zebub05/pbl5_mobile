import 'package:flutter/material.dart';


class VisionFeedPage extends StatelessWidget {
  const VisionFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 64,
                color: Colors.red,
              ),
              Container(
                height: 640,
                color: Colors.green,
              ),
              Container(
                height: 330,
                color: Colors.blue,
              )
            ],
          ),
        )
      ),
    );
  }
}