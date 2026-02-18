import 'package:flutter/material.dart';

final colorService = ColorService();

class ColorService extends ChangeNotifier {
  int redTapCount = 0;
  int blueTapCount = 0;
  int yellowTapCount = 0;
  int greenTapCount = 0;

  void incrementRed() {
    redTapCount++;
    notifyListeners();
  }

  void incrementBlue() {
    blueTapCount++;
    notifyListeners();
  }

  void incrementGreen(){
    greenTapCount++;
    notifyListeners();
  }

  void incrementYellow(){
    yellowTapCount++;
    notifyListeners();
  }
}

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Home()),
    ),
  );
}

enum CardType { red, blue ,green,yellow}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _currentIndex == 0
              ? ColorTapsScreen(
              )
              : StatisticsScreen(
              ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.tap_and_play),
            label: 'Taps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}

class ColorTapsScreen extends StatelessWidget {
  const ColorTapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Color Taps')),
      body: Column(
        children: [
          ColorTap(type: CardType.red),
          ColorTap(type: CardType.green),
          ColorTap(type: CardType.yellow),
          ColorTap(type: CardType.blue),
        ],
      ),
    );
  }
}

class ColorTap extends StatelessWidget {
  final CardType type;

  const ColorTap({super.key, required this.type});

  Color get backgroundColor {
  switch (type) {
    case CardType.red:    return Colors.red;
    case CardType.green:  return Colors.green;
    case CardType.yellow: return Colors.yellow;
    case CardType.blue:   return Colors.blue;
  }
}

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: colorService,
      builder: (context, child) {
        final tapCount = switch (type) {
        CardType.red    => colorService.redTapCount,
        CardType.green  => colorService.greenTapCount,
        CardType.yellow => colorService.yellowTapCount,
        CardType.blue   => colorService.blueTapCount,
      };
      final onTap = switch (type) {
        CardType.red    => colorService.incrementRed,
        CardType.green  => colorService.incrementGreen,
        CardType.yellow => colorService.incrementYellow,
        CardType.blue   => colorService.incrementBlue,
      };
        return GestureDetector(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            width: double.infinity,
            height: 100,
            child: Center(
              child: Text(
                'Taps: $tapCount',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Statistics')),
      body: ListenableBuilder(
        listenable: colorService,
        builder: (context, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Red Taps: ${colorService.redTapCount}',
                    style: TextStyle(fontSize: 24)),
                Text('Green Taps: ${colorService.greenTapCount}',
                    style: TextStyle(fontSize: 24)),
                Text('Yellow Taps: ${colorService.yellowTapCount}',
                    style: TextStyle(fontSize: 24)),
                Text('Blue Taps: ${colorService.blueTapCount}',
                    style: TextStyle(fontSize: 24)),
              ],
            ),
          );
        },
      ),
    );
  }
}
