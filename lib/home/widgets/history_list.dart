import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yell/home/controller.dart';

class HistoryListWidget extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      child: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 200.0,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Obx(() =>
                    Text(controller.state.alias,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ))),
              ),
            ),
            Container(
                height: double.maxFinite,
                child: Obx(() {
                  return ListView.separated(
                    itemCount: controller.state.messages.length,
                    separatorBuilder: (_, __) => Divider(),
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          title: Text('${controller.state.messages[index].title}'),
                          subtitle: Text('${controller.state.messages[index].content}'),
                          trailing: Icon(Icons.copy),
                          onTap: () {});
                    },
                  );
                })),
          ],
        ),
      ),
    );
  }
}
