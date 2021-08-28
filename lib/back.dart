import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:xiao_mi_push_plugin/xiao_mi_push_plugin.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController controller = TextEditingController();

  Map<String, Function> methods = {};

  @override
  void initState() {
    super.initState();
    this.methods = {
      "init": () => XiaoMiPushPlugin.init(
          appId: "2882303761520026355", appKey: "5812002676355"),
      "setAlias": () =>
          XiaoMiPushPlugin.setAlias(alias: "test1", category: "test1"),
      "unsetAlias": () =>
          XiaoMiPushPlugin.unsetAlias(alias: "test1", category: "test1"),
      "getAllAlias": () async =>
      controller.text = jsonEncode(await XiaoMiPushPlugin.getAllAlias()),
      "setUserAccount": () => XiaoMiPushPlugin.setUserAccount(
          userAccount: "test", category: "test"),
      "unsetUserAccount": () => XiaoMiPushPlugin.unsetUserAccount(
          userAccount: "test", category: "test"),
      "getAllUserAccount": () async => controller.text =
          jsonEncode(await XiaoMiPushPlugin.getAllUserAccount()),
      "subscribe": () =>
          XiaoMiPushPlugin.subscribe(topic: "test", category: "test"),
      "unsubscribe": () =>
          XiaoMiPushPlugin.unsubscribe(topic: "test", category: "test"),
      "getAllTopic": () async =>
      controller.text = jsonEncode(await XiaoMiPushPlugin.getAllTopic()),
      "getRegId": () async =>
      controller.text = "${(await (XiaoMiPushPlugin.getRegId())) ?? "失败"}",
    };

    XiaoMiPushPlugin.addListener(onXiaoMiPushListener);
  }

  @override
  void dispose() {
    super.dispose();
    XiaoMiPushPlugin.removeListener(onXiaoMiPushListener);
  }

  /// 小米推送监听器
  onXiaoMiPushListener(type, params) {
    controller.text = ""
        "======================\n"
        "Listener ${type.toString().split(".")[1]}:\n"
        "--------------------------------------------\n"
        "${jsonEncode(params)}\n"
        "======================";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              TextField(
                controller: controller,
                maxLines: 10,
              ),
              Expanded(
                child: Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  children: methods.keys
                      .map(
                        (key) => OutlinedButton(
                      onPressed: methods[key] as void Function()?,
                      child: Text(key),
                    ),
                  )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}