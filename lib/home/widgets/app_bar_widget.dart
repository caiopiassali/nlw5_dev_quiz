import 'package:flutter/material.dart';
import 'package:nlw5_dev_quiz/core/core.dart';
import 'package:nlw5_dev_quiz/home/widgets/score_card_widget.dart';
import 'package:nlw5_dev_quiz/shared/models/user_model.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final UserModel user;

  const AppBarWidget({Key? key, required this.user}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(250);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Stack(
        children: [
          Container(
            height: 160,
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: double.maxFinite,
            decoration: BoxDecoration(gradient: AppGradients.linear),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'Olá, ',
                      style: AppTextStyles.title,
                      children: [
                        TextSpan(
                          text: user.name,
                          style: AppTextStyles.titleBold,
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(user.photoUrl),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.0, 1.0),
            child: ScoreCardWidget(
              percentage: user.score / 100,
            ),
          )
        ],
      ),
    );
  }
}
