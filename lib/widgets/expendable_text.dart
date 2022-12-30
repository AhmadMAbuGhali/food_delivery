import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/small_text.dart';

class ExpendableText extends StatefulWidget {
  final String text;
  const ExpendableText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpendableText> createState() => _ExpendableTextState();
}

class _ExpendableTextState extends State<ExpendableText> {
  late String firstHalf;
  late String secondHalf;

  bool isHiddenText = true;

  double textHeight = Dimensions.screenHeight / 5.63;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(
              text: firstHalf,
              size: Dimensions.font16,
              color: AppColors.paraColor)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmallText(
                    height: 1.8,
                    color: AppColors.paraColor,
                    size: Dimensions.font20,
                    text: isHiddenText
                        ? firstHalf + "...."
                        : firstHalf + secondHalf),
                InkWell(
                  onTap: () {
                    setState(() {
                      isHiddenText = !isHiddenText;
                    });
                  },
                  child: Row(children: [
                    SmallText(
                      size: Dimensions.font16,
                      text: isHiddenText ? "Show more" : "Show less",
                      color: AppColors.mainColor,
                    ),
                    Icon(
                      isHiddenText
                          ? Icons.arrow_drop_down
                          : Icons.arrow_drop_up,
                      color: AppColors.mainColor,
                    )
                  ]),
                ),
              ],
            ),
    );
  }
}
