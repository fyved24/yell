import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiao_mi_push_plugin/xiao_mi_push_plugin.dart';

import 'index.dart';
import 'widgets/widgets.dart';

class HomePage extends GetView<HomeController> {
  // Content page
  Widget _buildView() {
    return NotifyChannelWidget(
      title: "你好",
      content: "世界",
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(title: Text(controller.state.title)),
      body: _buildView(),
      drawer: HistoryListWidget(),
    );
  }
}
