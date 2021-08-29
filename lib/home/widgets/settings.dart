import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yell/home/controller.dart';

class SettingsWidget extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    var urlController = TextEditingController();
    urlController.text = controller.state.url.value;
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        TextField(
            controller: urlController,
            decoration: InputDecoration(
                labelText: "服务器链接", hintText: "https://api.ironz.cn")),
        Container(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: (){
                controller.state.url.value = urlController.text.trim();
                Get.back();
              },
              child: Text("设置"),
              style: ButtonStyle(

              )
          ),
        )
      ]),
    );
  }
}
