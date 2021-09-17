import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yell/home/controller.dart';

import 'notify_channel.dart';

class ChannelListWidget extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NotifyChannelWidget(
          title: "你好",
          content: "世界",
        ),
      ],
    );
  }
}
