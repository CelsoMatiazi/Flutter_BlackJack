import 'package:black_jack/utils/app_styles.dart';
import 'package:flutter/material.dart';

class HomeMenuCard extends StatelessWidget {
  const HomeMenuCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110,
        width: 140,
        decoration: AppStyles.borderRadius12White54,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
              color: Colors.white54,
              size: 54,
            ),
            const SizedBox(height: 5,),
            Text(title,
              textAlign: TextAlign.center,
              style: AppStyles.body14White60
            )
          ],
        ),
      ),
    );
  }
}