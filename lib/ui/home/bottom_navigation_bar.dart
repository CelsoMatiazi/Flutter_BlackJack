import 'package:black_jack/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_controller.dart';


class CustomBottomNavigation extends StatelessWidget {
  CustomBottomNavigation({
    Key? key,

  }) : super(key: key);

  void selectedTab(context, index){
    var menuIndex = Provider.of<HomeController>(context, listen: false);
    menuIndex.bottomNavController(index);
  }
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        child: Container(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){selectedTab(context, 0);},
                    child: Container(
                      alignment: Alignment.center,
                      height: 55,
                      decoration: BoxDecoration(
                          border: BorderDirectional(
                              top: BorderSide(
                                  color: Colors.white30
                              )
                          )
                      ),
                      child: Consumer<HomeController>(
                        builder: (_,value,__) {
                          return Text("HOME",
                              style: value.menuIndex == 0
                                  ? AppStyles.bottomNavSelected
                                  : AppStyles.bottomNavUnselected
                          );
                        },
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: 70,
                  height: 37,
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.4),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100),
                    ),),),

                Expanded(
                  child: GestureDetector(
                    onTap: (){selectedTab(context, 1);},
                    child: Container(
                        alignment: Alignment.center,
                        height: 55,
                        decoration: BoxDecoration(
                            border: BorderDirectional(
                                top: BorderSide(
                                    color: Colors.white30
                                )
                            )
                        ),
                        child: Consumer<HomeController>(
                          builder: (_,value, __) {
                            return Text("MENU",
                                style: value.menuIndex == 1
                                    ? AppStyles.bottomNavSelected
                                    : AppStyles.bottomNavUnselected
                            );
                          },
                        ),
                    ),
                  ),
                )
              ],
            )

        ),
      ),
    );
  }
}
