
import 'package:black_jack/ui/black_jack/table_screen.dart';
import 'package:black_jack/ui/home/user_image_widget.dart';
import 'package:black_jack/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'bottom_navigation_bar.dart';
import 'home_menu_card.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2)
  )..repeat();

  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: FloatingActionButton(
            elevation: 5,
            backgroundColor: Colors.green,
            child: SvgPicture.asset("assets/svg/cards.svg",
              width: 35,
              color: Colors.black45,
            ),
            tooltip: "Jogar",
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TableScreen()));
            },
          ),
        ),

        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/table_bg.jpeg"),
                    fit: BoxFit.cover
                )
              ),

              child: Column(
                children: [

                  const SizedBox(height: 50,),
                  UserImageWidget(controller: _controller),

                  const SizedBox(height: 10,),

                  Text("Celso Ricardi",
                    style: AppStyles.body22White54
                  ),
                  const SizedBox(height: 8,),

                  Text("Seu Saldo",
                      style: AppStyles.bodyWhite54Space),
                  const SizedBox(height: 3,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    decoration: AppStyles.borderRadius12White54,
                    child: Text("R\$ 25,99",
                      style: AppStyles.body25White54Bold
                    ),
                  ),

                  const SizedBox(height: 15,),
                  const Divider(color: Colors.white54,),

                  Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          children: [

                            HomeMenuCard(
                              title: "Créditos",
                              icon: Icons.monetization_on_outlined,
                              onTap: (){},
                            ),

                            HomeMenuCard(
                              title: "Apostas",
                              icon: Icons.description_outlined,
                              onTap: (){},
                            ),

                            HomeMenuCard(
                              title: "Estatisticas",
                              icon: Icons.graphic_eq_outlined,
                              onTap: (){},
                            ),

                            HomeMenuCard(
                              title: "Ajuda",
                              icon: Icons.help_outline_outlined,
                              onTap: (){},
                            ),

                            HomeMenuCard(
                              title: "Perfil",
                              icon: Icons.person_outline,
                              onTap: (){},
                            ),


                          ],
                        ),
                      )
                  ),

                   SizedBox(height: 56,)
                ],
              ),
            ),

            CustomBottomNavigation()

          ],
        ),
      ),
    );
  }
}




