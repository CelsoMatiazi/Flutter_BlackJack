
import 'package:black_jack/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Future<void> gameMessageSimple({
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
                    color: Colors.green[900],
                    borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white54, width: 5)
                ),
                child: Center(
                  child: Text(message, style: TextStyle(
                    fontSize: 22,
                    color: Colors.white54
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
}

Future<void> gameMessage({
  required BuildContext context,
  required String message,
  required bool isWin
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
              contentPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              content: Container(
                padding: EdgeInsets.all(10),
                  height: 300,
                  width: 270,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white30, width: 3)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Container(
                        height: 120,
                        child: Stack(
                          children: [
                            if(isWin)
                            Lottie.asset("assets/animations/bg_win.json", fit: BoxFit.cover),
                            if(isWin)
                            Lottie.asset("assets/animations/cards_2.json", fit: BoxFit.cover),
                            if(!isWin)
                            Lottie.asset("assets/animations/bg_loser.json", fit: BoxFit.cover),
                          ],
                        ),
                      ),

                      SizedBox(height: 15,),
                      Text("Black Jack", style: AppStyles.bodyBlack54Space,),
                      SizedBox(height: 5,),
                      Text(message,
                        textAlign: TextAlign.center,
                        style: AppStyles.body14Black54,
                      ),

                      SizedBox(height: 10,),
                      Container(
                        width: 170,
                        child: ElevatedButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: Text("Continuar")
                        ),
                      )

                    ],
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
}