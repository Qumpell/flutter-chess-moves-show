import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MainApp());
}

class MovesController extends GetxController {
  final moveName = ''.obs;
  final chessboard = 0.obs;

  void updateChessboard(String newMove) {
    moveName.value = newMove;
  }

  MovesController(int chessboardNumber) {
    chessboard.value = chessboardNumber;
  }
}





class MainApp extends StatelessWidget {


@override
  Widget build(BuildContext context){
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
                  Text(controller.moveName.value,
                  style: TextStyle(fontSize: 24),)
                ],
              );  
            }),
          ),
          
        ],
      ),
    )
  }



  @override
  Widget build(BuildContext context){
    Widget buttonSection = Container(
      child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ElevatedButton(
            onPressed: () async{
               final result = await Get.to(
                () => ButtonPage(chessboardNumber: 1)
            );
            }
          , child: Text("Pierwsza szachownica")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            chessboardSection,
            buttonSection,
          ],
        )
      ),
    );
  }
}


class ButtonPage extends StatelessWidget {
  final int chessboardNumber;
  final TextEditingController _textEditingController = TextEditingController();
  ButtonPage({required this.chessboardNumber});

  @override
  Widget build(BuildContext context){
    return Container(
      child: 
        GetX<MovesController>(
          tag: chessboardNumber.toString(),
          init: MovesController(chessboardNumber),
          builder: (controller){
            return Column(
        children: <Widget>[
          TextField(
            controller: _textEditingController,
            decoration: InputDecoration(labelText: "Enter fen"),
          ),
          ElevatedButton(onPressed: 
          (){
            controller.updateChessboard(_textEditingController.text);

          }, child: Text("Update moves"))
        ],
      ), 
          },
        )
      
      
      
    );
  }
}