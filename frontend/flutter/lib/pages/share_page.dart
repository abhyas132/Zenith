import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/foundation.dart';

class SharePage extends StatefulWidget {
  const SharePage({super.key, required this.title});

  final String title;

  @override
  State<SharePage> createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  TextEditingController controller = TextEditingController();
  Image? img;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border:
                        Border.all(color: Color.fromARGB(255, 74, 102, 225))),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "start typing here...",
                  ),
                  controller: controller,
                ),
              ),
            ),
            Container(
              width: 200,
              height: 200,
              //color: Color.fromARGB(255, 98, 205, 81),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [generateRandomColor(), generateRandomColor()],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: img ?? Container(),
            ),
            ElevatedButton(
              onPressed: _onPressedButton,
              child: const Text("share ?"),
            ),
          ],
        ),
      ),
    );
  }

  Color generateRandomColor() {
    Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }

  void getCanvasImage(String str) async {
    var l = MediaQuery.of(context).size.width;
    var builder = ParagraphBuilder(ParagraphStyle(
        fontSize: 60,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal));
    builder.addText(str);
    Paragraph paragraph = builder.build();
    paragraph.layout(ParagraphConstraints(width: l));

    final recorder = PictureRecorder();
    var newCanvas = Canvas(recorder);

    newCanvas.drawParagraph(paragraph, Offset.zero);

    final picture = recorder.endRecording();
    var res = await picture.toImage(l.toInt(), l.toInt());
    ByteData? data = await res.toByteData(format: ImageByteFormat.png);

    if (data != null) {
      img = Image.memory(Uint8List.view(data.buffer));
    }

    setState(() {});
  }

  void _onPressedButton() {
    getCanvasImage(controller.text + " 😀 🔥🔥");
  }
}
