import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: StackedShiftCards(),
      ),
    );
  }
}

class StackedShiftCards extends StatefulWidget {
  @override
  _StackedShiftCardsState createState() => _StackedShiftCardsState();
}

class _StackedShiftCardsState extends State<StackedShiftCards> {
  final List<Widget> cards = [
    CardItem(color: Colors.red),
    CardItem(color: Colors.blue),
    CardItem(color: Colors.purple),
    CardItem(color: Colors.orange),
    CardItem(color: Colors.yellow),
    CardItem(color: Colors.green),
    CardItem(color: Colors.brown),
    CardItem(color: Colors.grey),
    CardItem(color: Colors.black),
    CardItem(color: Colors.blueGrey),
    CardItem(color: Colors.orangeAccent),
    CardItem(color: Colors.greenAccent),
    CardItem(color: Colors.teal),
    CardItem(color: Colors.green),
    CardItem(color: Colors.brown),
    CardItem(color: Colors.grey),
    CardItem(color: Colors.black),
    CardItem(color: Colors.blueGrey),
    CardItem(color: Colors.orangeAccent),
    CardItem(color: Colors.greenAccent),
    CardItem(color: Colors.teal),
  ];

  List<Widget> positionedCards = [];
  late int frontCardIndex;

  void positionCards() {
    final List<Widget> tempList = [];
    for (int i = 0; i < cards.length; i++) {
      print(i);
      tempList.add(_cardWrapper(top: i * 45, i: i));
    }
    positionedCards = tempList;
    setState(() {});
  }

  Widget _cardWrapper({required int i, required double top}) {
    return Positioned(
      top: top,
      child: InkWell(
        onTap: () {
          try {
            if (i == frontCardIndex) {
              print('selected $i');
              return;
            }
          } catch (e) {}
          frontCardIndex = i;

          positionCards();
          moveCardsDown(i);

          setState(() {});
        },
        child: cards[i],
      ),
    );
  }

  void moveCardsDown(int index) {
    final List<Widget> firstPart = positionedCards.sublist(0, index + 1);
    final List<Widget> shiftedPart = [];

    for (int i = index + 1; i < cards.length; i++) {
      shiftedPart.add(_cardWrapper(top: (i * 45) + 300, i: i));
    }

    final List<Widget> tempList = [...firstPart, ...shiftedPart];

    positionedCards = tempList;
  }

  @override
  void initState() {
    positionCards();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: positionedCards.length * 45 + 300,
        width: double.infinity,
        child: Stack(
          children: positionedCards,
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  const CardItem({Key? key, required this.color}) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * .8,
      height: 300,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.grey),
        ],
        color: Colors.white,
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(Icons.book, color: color),
                Text('Title card'),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: color,
            ),
          )
        ],
      ),
    );
  }
}
