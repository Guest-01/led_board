import 'package:flutter/material.dart';
import 'package:led_board/led_screen.dart';
import 'package:led_board/widgets/color_circle_row.dart';

class MakeScreen extends StatefulWidget {
  const MakeScreen({
    super.key,
  });

  @override
  State<MakeScreen> createState() => _MakeScreenState();
}

class _MakeScreenState extends State<MakeScreen> {
  TextEditingController controller = TextEditingController();
  List<Color> colorList = [Colors.black, Colors.white, Colors.amber];
  late Color textColor;
  late Color backgroundColor;

  @override
  void initState() {
    // TODO: 저장된 마지막 값 불러오기
    super.initState();
    controller.text = "";
    textColor = Colors.white;
    backgroundColor = Colors.black;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Placeholder(
                  color: Colors.grey,
                  strokeWidth: 2,
                  child: SizedBox(
                    width: 360,
                    height: 50,
                    child: Center(child: Text('Google Ads')),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: backgroundColor,
                  ),
                  child: Center(
                    child: Text(
                      controller.text,
                      style: TextStyle(color: textColor, fontSize: 56),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
                const Text('미리보기'),
                const SizedBox(height: 10),
                TextField(
                  controller: controller,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    hintText: '전광판에 보여줄 내용을 입력해주세요',
                    isDense: true,
                  ),
                  onChanged: (text) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 10),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 6,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('글자색'),
                        ColorCircleRow(
                          initial: textColor,
                          colorList: colorList,
                          onChange: (color) {
                            textColor = color;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 6,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('배경색'),
                        ColorCircleRow(
                          initial: backgroundColor,
                          colorList: colorList,
                          onChange: (color) {
                            backgroundColor = color;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text('TODO: 글꼴, 글자크기, 흐르는 속도, 마지막 값 기억'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue.shade700,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LedScreen(
                          backgroundColor: backgroundColor,
                          textColor: textColor,
                          content: controller.text,
                        ),
                      ),
                    );
                  },
                  child: const Text('시작'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
