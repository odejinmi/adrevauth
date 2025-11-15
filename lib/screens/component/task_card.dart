import 'package:flutter/material.dart';

class TasksCard extends StatelessWidget {
  TasksCard({
    required this.children,
    this.hasBox=true,
    super.key,
  });
  List<Widget> children;
  final bool hasBox;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'images/Rectangle.png',
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 11),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children),
            )
          ],
        ),
        if(hasBox)
        Positioned(
          right: 0,
          top: 10  ,
          child: Image.asset(
            'images/treasureBox.png',
            width: 32  ,
            height: 32  ,
          ),
        ),
      ],
    );
  }
}
