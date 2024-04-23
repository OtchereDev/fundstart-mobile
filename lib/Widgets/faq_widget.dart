import 'package:crowdfunding/AppTheme/app_config.dart';
import 'package:flutter/material.dart';

class FaqWidget extends StatelessWidget {
  const FaqWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
       ...List.generate(questions.length, (index) =>  Padding(
         padding: const EdgeInsets.only(bottom:15.0),
         child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.WHITE,
              boxShadow: [
                BoxShadow(
                  color: AppColors.BLACK.withOpacity(0.2),
                  offset: Offset(1,1)
                ),
                 BoxShadow(
                  color: AppColors.BLACK.withOpacity(0.2),
                  offset: Offset(-0.5,-0.5)
                )
              ]
            ),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(child: Icon(Icons.keyboard_arrow_down),backgroundColor: AppColors.ASH.withOpacity(0.5),),
              title: Text(questions[index]),
            ),
          ),
       ))
      ],
    );
  }
}

List<String> questions =[
  "What is Fundstart about?",
  "What problem does Fundstart solve?",
  "How does Fundstart make money?",
  "How much funding are you seeking and what will it be used for?"
];