import 'dart:async';
import 'package:bustracking/choose.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);


  @override
  _LoadPageState createState() => _LoadPageState();
}

class _LoadPageState extends State<LoadingPage> with SingleTickerProviderStateMixin {


  String? str11, str22, str33;

  List<String> icons = [
    'assets/ic1.png',
    'assets/ic2.png',
    'assets/ic3.png',
  ];

  int currentIndex = 0;
  Timer? _timer;

  void changeIcon() {
    setState(() {
      currentIndex = (currentIndex + 1) % icons.length;
    });
  }

  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % icons.length;
      });
    });

    // Delay for 2 seconds and then navigate to the second page.
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(settings: RouteSettings(arguments: [str11,str22]),builder: (context) => ChoosePage()),
      );

    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     List<Object?> arguments = ModalRoute.of(context)!.settings.arguments as List<Object?>;
     str11 = arguments[0] as String;
     str22 = arguments[1] as String;
    return Container(
      color: Colors.white,
      child: Center(
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          child: Image.asset(
            icons[currentIndex],
            key: ValueKey<String>(icons[currentIndex]),
          ),
        ),
      ),
    );
  }
}
