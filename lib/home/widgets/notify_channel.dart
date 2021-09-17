import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

import '../index.dart';

/// hello
class NotifyChannelWidget extends GetView<HomeController> {
  final String title;
  final String content;

  NotifyChannelWidget({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    var log = Logger();
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
              TextField(
                autofocus: false,
                controller: controller.topicController,
                decoration: InputDecoration(
                    labelText: "主题",
                    hintText: title,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10.0),
                    floatingLabelBehavior: FloatingLabelBehavior.always),
              ),
              TextField(
                autofocus: false,
                controller: controller.contentController,
                decoration: InputDecoration(
                    labelText: "内容",
                    hintText: content,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10.0),
                    floatingLabelBehavior: FloatingLabelBehavior.always),
              ),
              Divider(),
              Obx(() {
                return TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10.0),
                        labelText: "链接",
                        hintText:
                            "${controller.state.url}/${controller.state.alias}/${controller.state.topic}/${controller.state.content}",
                        floatingLabelBehavior: FloatingLabelBehavior.always));
              }),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                IconButton(
                  icon: Icon(Icons.copy),
                  color: Colors.blue,
                  onPressed: () {
                    var url = "${controller.state.url}/${controller.state.alias}/${controller.state.topic}/${controller.state.content}";
                    Clipboard.setData(ClipboardData(text: url));
                    Fluttertoast.showToast(
                        msg: "$url copied to clipboard",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black45,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    log.i("$url copied to clipboard");
                  },
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  color: Colors.blue,
                  onPressed: () {
                    var url =
                        "${controller.state.url}/${controller.state.alias}/${controller.state.topic}/${controller.state.content}";
                    launchURL(url);
                    log.i("send");
                  },
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }

  void launchURL(url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}
