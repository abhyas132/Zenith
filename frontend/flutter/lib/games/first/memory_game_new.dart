import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zenith/games/first/counter.dart';
import 'package:zenith/games/first/tile.dart';

class MemoryGame1 extends StatefulWidget {
  const MemoryGame1({Key? key}) : super(key: key);

  @override
  State<MemoryGame1> createState() => _MemoryGame1State();
}

class _MemoryGame1State extends State<MemoryGame1> {
  @override
  List<Tile> grid = [];
  int _totalNumOfTiles = 9;
  List<int> _numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  var counter;

  List<Tile> generateTiles() {
    grid.clear();
    List<Tile> gridTiles = [];
    _numbers.shuffle();
    for (int i = 0; i < _totalNumOfTiles; i++) {
      gridTiles.add(Tile(id: _numbers[i], selected: false));
    }

    grid = gridTiles;
    return gridTiles;
  }

  @override
  void initState() {
    super.initState();
    grid = generateTiles();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    counter = Provider.of<Counter>(context);
    return Container(
      padding: EdgeInsets.all(30),
      child: Consumer<Counter>(
        builder: (_, counter, __) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Tap the numbers in order (from 1 to 9)",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  fontSize: 25),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Next number to press : ${counter.getCounter < 0 ? 1 : counter.getCounter + 1}",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                GridView(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  children: counter.getCounter < 0 ? generateTiles() : grid,
                ),

                // Text(
                //   "Time Left : ${_showSecs}",
                //   textAlign: TextAlign.center,
                //   style: TextStyle(color: Colors.grey.shade700, fontSize: 20),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
