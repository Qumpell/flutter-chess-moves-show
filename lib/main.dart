import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MainApp());
}

class MovesController extends GetxController {
  final moveName = ''.obs;
  final chessboard = 0.obs;

  void updateChessboard(String newMove) {
    moveName.value = newMove;
    moveName.refresh();
  }

  MovesController(int chessboardNumber) {
    chessboard.value = chessboardNumber;
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Widget chessboardSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GetX<MovesController>(
            tag: "1",
            init: MovesController(1),
            builder: ((controller) {
              return Column(
                children: <Widget>[
                  Text(
                    controller.moveName.value,
                    style: TextStyle(fontSize: 24),
                  )
                ],
              );
            }),
          ),
        ],
      ),
    );

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ElevatedButton(
              onPressed: () async {
                final result =
                    await Get.to(() => ButtonPage(chessboardNumber: 1));
              },
              child: Text("Pierwsza szachownica")),
        ],
      ),
    );

    return GetMaterialApp(
      home: Scaffold(
          body: ListView(
        children: [
          chessboardSection,
          buttonSection,
        ],
      )),
    );
  }
}

class ButtonPage extends StatelessWidget {
  final int chessboardNumber;
  final TextEditingController _textEditingController = TextEditingController();
  ButtonPage({required this.chessboardNumber});
  final MovesController movesController = Get.put(MovesController(1));
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 300,
        height: 300,
        child: Column(
          children: <Widget>[
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(labelText: "Enter fen"),
            ),
            ElevatedButton(
                onPressed: () {
                  movesController.updateChessboard(_textEditingController.text);
                  Get.back(result: "WElcome back");
                },
                child: Text("Update moves"))
          ],
        ),
      ),
    );
  }
}
