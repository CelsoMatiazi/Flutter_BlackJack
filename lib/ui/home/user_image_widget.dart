import 'package:flutter/material.dart';
import 'dart:math';

class UserImageWidget extends StatelessWidget {
  const UserImageWidget({
    Key? key,
    required AnimationController controller,
  }) : _controller = controller, super(key: key);

  final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [


        AnimatedBuilder(
          animation: _controller,
          builder: (_,child){
            return Transform.rotate(
              angle: _controller.value * 2 * pi,
              child: child,
            );
          },
          child: Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(70),
                gradient: LinearGradient(
                    colors: [
                      // Colors.indigo[700]!,
                      // Colors.blue,
                      // Colors.blue[300]!

                      Colors.green[900]!,
                      Colors.green,
                      //Colors.green[300]!
                    ]

                )
            ),
          ),
        ),


        Container(
          width: 125,
          height: 125,
          decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(70)
          ),

          child: Icon(
            Icons.person,
            size: 100,
            color: Colors.white38,
          ),
        ),


        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            alignment: Alignment.center,
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(25)
            ),

            child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: (){},
                icon: Icon(
                  Icons.camera_enhance,
                  size: 25,
                  color: Colors.white54,
                )
            ),
          ),
        ),

      ],
    );
  }
}
