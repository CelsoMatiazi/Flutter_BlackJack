
import 'package:flutter/material.dart';

Future<void> gameMessage({
  required BuildContext context,
  required String message
}){
  return showGeneralDialog(
    barrierColor: Colors.black38,
    transitionBuilder: (context, a1, a2, widget){
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              content: Container(
                height: 70,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.green[800],
                    borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green[900]!, width: 7)
                ),
                child: Center(
                  child: Text(message, style: TextStyle(
                    fontSize: 20,
                    color: Colors.white38
                  ),

                  ),
                )
              ),
            ),
          ),
        ),
      );
    },
    barrierDismissible: false,
    barrierLabel: "",
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation)  {return SizedBox();},
    context: context,
  );

  Future.delayed(Duration(seconds: 3), (){
    Navigator.of(context).pop();
  });
}