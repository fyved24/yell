import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yell/home/controller.dart';
import 'package:yell/home/utils/commnUtils.dart';

import 'channels/normal_channel.dart';

class ChannelListWidget extends GetView<HomeController> {
  var log = Logger();
  var url = "".obs;

  @override
  Widget build(BuildContext context) {
    url.value = "${controller.state.url}/${controller.state.alias}/${controller.state.topic}/${controller.state.content}";
    return Scrollbar(
      child: ListView(
        children: [
          NormalChannelWidget(
            title: "你好",
            content: "世界",
            url: url,
            b1Clicked: nb1onPressed,
            b2Clicked: nb2onPressed,
            onChange: onChange,
          ),
        ],
      ),
    );
  }

  nb1onPressed(topic, content) {
    log.i("topic: $topic, content: $content");
    var url =
        "${controller.state.url}/${controller.state.alias}/${controller.state.topic}/${controller.state.content}";
    Clipboard.setData(ClipboardData(text: url));
    showToast("$url copied to clipboard");
    log.i("$url copied to clipboard");
  }

  nb2onPressed(topic, content) {
    var url =
        "${controller.state.url}/${controller.state.alias}/${controller.state.topic}/${controller.state.content}";
    launchURL(url);
    log.i("send");
  }

  onChange(topic, content) {
    log.i("topic: $topic, content: $content");
    controller.state.topic = topic;
    controller.state.content = content;
    url.value = "${controller.state.url}/${controller.state.alias}/${controller.state.topic}/${controller.state.content}";
  }

  void launchURL(url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}
