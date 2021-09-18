import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../index.dart';

/// hello
class ChannelWidget extends GetView<HomeController> {
  final String title;
  final String topic;
  final String content;
  final RxString url;
  final void Function(String, String)? b1Clicked;
  final void Function(String, String)? b2Clicked;
  final void Function(String, String)? onChange;

  ChannelWidget({
    required this.title,
    required this.topic,
    required this.content,
    required this.url,
    required this.b1Clicked,
    required this.b2Clicked,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    var topicController = TextEditingController();
    topicController.text = topic;
    var contentController = TextEditingController();
    contentController.text = content;
    topicController.addListener(() {
      onChange!(topicController.text.trim(), contentController.text.trim());
    });
    contentController.addListener(() {
      onChange!(topicController.text.trim(), contentController.text.trim());
    });

    controller.initTextController();
    return Center(
      child: Card(
        elevation: 5.0, //设置阴影
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child: Container(
          width: 370,
          // height: 500,
          child: Column(
            children: [
              Text(
                title,
                textAlign: TextAlign.left,
              ),
              TextField(
                autofocus: false,
                controller: topicController,
                decoration: InputDecoration(
                    labelText: "主题",
                    hintText: "你好",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10.0),
                    floatingLabelBehavior: FloatingLabelBehavior.always),
              ),
              TextField(
                autofocus: false,
                controller: contentController,
                decoration: InputDecoration(
                    labelText: topic,
                    hintText: content,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10.0),
                    floatingLabelBehavior: FloatingLabelBehavior.always),
              ),
              Divider(),
              Obx((){
                return TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10.0),
                        labelText: "链接",
                        hintText: url.value,
                        floatingLabelBehavior: FloatingLabelBehavior.always));
              }),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                IconButton(
                  icon: Icon(Icons.copy),
                  color: Colors.blue,
                  onPressed: (){
                    b1Clicked!(topicController.text, contentController.text);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  color: Colors.blue,
                  onPressed:(){
                    b2Clicked!(topicController.text, contentController.text);
                  },
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
