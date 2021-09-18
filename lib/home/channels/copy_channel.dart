import 'channel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:yell/home/controller.dart';
import 'package:yell/home/utils/commnUtils.dart';

class CopyChannel extends GetView<HomeController> {
  final log = Logger();
  var url = "".obs;
  @override
  Widget build(BuildContext context) {
    url.value = "${controller.state.url}/${controller.state.alias}/${controller.state.topic}/${controller.state.content}/cp";
    return ChannelWidget(
      title: "点击消息复制内容",
      topic: "你好",
      content: "世界",
      url: url,
      b1Clicked: nb1onPressed,
      b2Clicked: nb2onPressed,
      onChange: onChange,
    );
  }
  nb1onPressed(topic, content) {
    log.i("topic: $topic, content: $content");
    Clipboard.setData(ClipboardData(text: url.value));
    showToast("$url copied to clipboard");
    log.i("$url copied to clipboard");
  }

  nb2onPressed(topic, content) {
    launchURL(url.value);
    log.i("send");
  }

  onChange(topic, content) {
    log.i("topic: $topic, content: $content");
    controller.state.topic = topic;
    controller.state.content = content;
    url.value = "${controller.state.url}/${controller.state.alias}/${controller.state.topic}/${controller.state.content}/cp";
  }
}