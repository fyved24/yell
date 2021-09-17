import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yell/home/channels/touch_copy_channel.dart';
import 'package:yell/home/controller.dart';

import 'channels/normal_channel.dart';

class ChannelListWidget extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView(
        children: [
          NormalChannelWidget(
            title: "你好",
            content: "世界",
          ),
          TouchCopyChannelWidget(
            title: "你好",
            content: "世界",
          ),

        ],
      ),
    );
  }
}
