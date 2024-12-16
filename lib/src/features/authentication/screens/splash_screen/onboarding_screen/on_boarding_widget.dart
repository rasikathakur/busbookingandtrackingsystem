import 'package:flutter/material.dart';
import '../../../../../constants/sizes.dart';
import '../../../../../constants/text_strings.dart';
import '../../../models/mode_onboarding.dart';

class OnBoardingPageWidget extends StatelessWidget {
  const OnBoardingPageWidget({
    super.key,
    required this.model,
  });

  final onBoardingmodel model;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(tDefaultSize),
      color: model.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: AssetImage(model.image),
            height: size.height*0.4,
            width: 600,
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              Text(model.title, style: Theme.of(context).textTheme.headline5,textAlign: TextAlign.center,),
              Text(model.subTitle,style: Theme.of(context).textTheme.headline1,textAlign: TextAlign.center,),
            ],
          ),
          Text(onBoardingCounter1, style: Theme.of(context).textTheme.headline6,),
          SizedBox(height: 80.0,)
        ],
      ),
    );
  }
}