import "package:flutter/material.dart";
import 'package:psr_base/index.dart' show FontModels, ButtonModules;
import 'package:psr_base/ui_related/space_between.dart';

class Question extends StatelessWidget {
  final String label;
  const Question({
    Key? key,
    this.label = "آیا میخواهید از برنامه خارج شوید؟",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 280,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 1.5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          intermediate(10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontFamily: FontModels.yekan,
              color: Color(0xFF4C4D52),
            ),
          ),
          intermediate(5),
          Row(
            children: [
              limitWidth(10),
              Expanded(
                child: ButtonModules(
                  label: "بلی",
                  color: const Color(0xFF00809A),
                  onTap: () => Navigator.pop(context, true),
                ),
              ),
              limitWidth(10),
              Expanded(
                child: ButtonModules(
                  label: "خیر",
                  color: const Color(0xFF00809A),
                  onTap: () => Navigator.pop(context, false),
                ),
              ),
              limitWidth(10),
            ],
          ),
        ],
      ),
    );
  }
}
