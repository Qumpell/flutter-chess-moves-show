import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';

void main() {
  runApp(const MainApp());
}

class MovesController extends GetxController {
  final moveName = ''.obs;
  // final chessboard = ''.obs;
  final chessboard = "".obs;

  void updateChessboard(String newMove) {
    moveName.value = newMove;
    moveName.refresh();
  }

  MovesController(String chessboardNumber) {
    chessboard.value = chessboardNumber;
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            color: Colors.amber,
            child: Row(
              children: const [
                Expanded(child: ChessboardSection(chessboardNumber: "1")),
                VerticalDivider(
                  width: 1.5,
                  color: Colors.orange,
                  thickness: 1.5,
                ),
                Expanded(child: ChessboardSection(chessboardNumber: "2"))
              ],
            ),
          )),
    );
  }
}

class ButtonPage extends StatelessWidget {
  final String chessboardNumber;
  final TextEditingController _textEditingController = TextEditingController();
  ButtonPage({super.key, required this.chessboardNumber});
  final Chess chess = Chess();
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: Colors.orangeAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 300,
              child: TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                    labelText: "Enter fen",
                    floatingLabelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
                    labelStyle: TextStyle(color: Colors.white)),
                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                  onPressed: () {
                    Get.back(result: _textEditingController.text);
                  },
                  style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Colors.indigo)),
                  child: const Text("Update moves")),
            ),
            ElevatedButton(
                onPressed: () {
                  _textEditingController.text = chess.generate_fen();
                },
                style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Colors.red)),
                child: const Text("Default fen")),
          ],
        ),
      ),
    );
  }
}

class ChessboardSection extends StatelessWidget {
  final String chessboardNumber;
  const ChessboardSection({super.key, required this.chessboardNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GetX<MovesController>(
            tag: chessboardNumber,
            init: MovesController(chessboardNumber),
            builder: ((controller) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ChessBoard(
                    controller: ChessBoardController.fromFEN(controller.moveName.value),
                    size: 300,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35, top: 10, right: 20),
                    child: Text(
                      controller.moveName.value,
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final result = await Get.to(() => ButtonPage(chessboardNumber: chessboardNumber));
                      controller.updateChessboard(result);
                    },
                    style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith((states) => Colors.green),
                        backgroundColor: MaterialStateColor.resolveWith((states) => Colors.black)),
                    child: Text("$chessboardNumber szachownica"),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
