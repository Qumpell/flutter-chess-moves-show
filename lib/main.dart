import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MainApp());
}

class MovesController extends GetxController {
  final moveName = ''.obs;
  final chessboard = '0'.obs;

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
    // Widget firstChessboardSection = Container(
    //   color: Colors.amber,
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: <Widget>[
    //       GetX<MovesController>(
    //         tag: "1",
    //         init: MovesController('1'),
    //         builder: ((controller) {
    //           return Column(
    //             children: <Widget>[
    //               Text(
    //                 controller.moveName.value,
    //                 style: const TextStyle(fontSize: 24),
    //               ),
    //               ElevatedButton(
    //                   onPressed: () async {
    //                     final result = await Get.to(() => ButtonPage(chessboardNumber: '1'));
    //                     controller.updateChessboard(result);
    //                   },
    //                   child: Text("Pierwsza szachownica")),
    //             ],
    //           );
    //         }),
    //       ),
    //     ],
    //   ),
    // );

    // Widget secondChessboardSection = Container(
    //   color: Colors.red,
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: <Widget>[
    //       GetX<MovesController>(
    //         tag: "2",
    //         init: MovesController('2'),
    //         builder: ((controller) {
    //           return Column(
    //             children: <Widget>[
    //               Text(
    //                 controller.moveName.value,
    //                 style: const TextStyle(fontSize: 24),
    //               ),
    //               ElevatedButton(
    //                   onPressed: () async {
    //                     final result = await Get.to(() => ButtonPage(chessboardNumber: '2'));
    //                     controller.updateChessboard(result);
    //                   },
    //                   child: Text("Druga szachownica")),
    //             ],
    //           );
    //         }),
    //       ),
    //     ],
    //   ),
    // );

    // Widget secondChessboardSection = Container(
    //   color: Colors.brown,
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: <Widget>[
    //       ElevatedButton(
    //           onPressed: () async {
    //             final result = await Get.to(() => ButtonPage(chessboardNumber: '1'));
    //           },
    //           // onPressed: () {
    //           //   Get.to(() => ButtonPage(chessboardNumber: '1'));
    //           // },
    //           child: Text("Pierwsza szachownica")),
    //     ],
    //   ),
    // );

    return GetMaterialApp(
      home: Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            color: Colors.amber,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.max,
              // crossAxisAlignment: CrossAxisAlignment.baseline,
              children: const [
                // firstChessboardSection,
                // secondChessboardSection,
                Expanded(child: ChessboardSection(chessboardNumber: "1")),
                VerticalDivider(
                  width: 1.5,
                  color: Colors.red,
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

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 300,
        child: Column(
          children: <Widget>[
            TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(labelText: "Enter fen"),
            ),
            ElevatedButton(
                onPressed: () {
                  Get.back(result: _textEditingController.text);
                },
                child: const Text("Update moves"))
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
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GetX<MovesController>(
            tag: chessboardNumber,
            init: MovesController(chessboardNumber),
            builder: ((controller) {
              return Column(
                children: <Widget>[
                  Text(
                    controller.moveName.value,
                    style: const TextStyle(fontSize: 24),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        final result = await Get.to(() => ButtonPage(chessboardNumber: chessboardNumber));
                        controller.updateChessboard(result);
                      },
                      child: Text("$chessboardNumber szachownica")),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
