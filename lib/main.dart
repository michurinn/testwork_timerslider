import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as Rive;
import 'package:untitled/training_list_header_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled/unicorn_outline_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final PageController? controller = PageController();

  void _incrementCounter() {
    setState(() {
      if (_counter!=2){_counter++;};
      controller?.animateToPage(_counter, duration: Duration(milliseconds: 400), curve: Curves.linear);

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:
        Stack(
        children:[ PageView(
        controller: controller,
        children:[
          Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('First Screen',style: Theme.of(context).textTheme.headline4,),
           Container (
           width: 450,
           height: 500,
            child: const Rive.RiveAnimation.asset('assets/fish_instruction.riv'),
            ),
        ],
      ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Second screen',style: Theme.of(context).textTheme.headline4,),
                  Container (
                    width: 550,
                    height: 500,
                    child: const Rive.RiveAnimation.asset('assets/fish_game.riv'),
                  ),

            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                  Text('Third screen',style: Theme.of(context).textTheme.headline4,),
                  Container (
                    width: 450,
                    height: 500,
                    child: const Rive.RiveAnimation.asset('assets/norbu_test.riv'),
                  ),
            ],
          ),
        ]
      ),
          Align(
            alignment: Alignment.center,
            child: SmoothPageIndicator(
              controller: controller!, // PageController
              count: 3,
              effect: WormEffect(
                spacing: 12.0,
                dotWidth: 8.0,
                dotHeight: 8.0,
                dotColor: Colors.lightGreenAccent,
                activeDotColor: Colors.orangeAccent,
              ),
            ),),
          Align(
            alignment:Alignment.bottomCenter,
            child:UnicornOutlineButton(
            //minHeight: minHeight,
            strokeWidth: 3,
            radius: 16,
            gradient: const LinearGradient(colors: [Colors.amberAccent, Colors.deepOrange]),
            onPressed: _incrementCounter,
            child: Expanded(
              child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text("Next screen")
              ),
            ),
          ),),
    ]
      ),

    );
  }
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
