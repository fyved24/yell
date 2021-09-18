import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xiao_mi_push_plugin/xiao_mi_push_plugin.dart';
import 'package:random_string/random_string.dart';
import 'package:xiao_mi_push_plugin/xiao_mi_push_plugin_listener.dart';
import 'package:yell/home/utils/commnUtils.dart';
import 'package:yell/home/widgets/message.dart';

import 'index.dart';

class HomeController extends GetxController {
  final logger = Logger();
  var topicController = TextEditingController();
  var contentController = TextEditingController();

  HomeController();

  /// Responsive member variables

  final state = HomeState();

  /// Member variables

  /// event

  // tap
  void handleTap(int index) {
    Get.snackbar(
      "Title",
      "Message",
    );
  }

  /// The life cycle

  /// Called immediately after allocation in widget memory.
  /// You can use it to initialize something for the controller.
  @override
  void onInit() async {
    List? storedMessages = GetStorage().read<List>('messages');
    String? url = GetStorage().read('url');
    if (storedMessages != null) {
      state.messages =
          storedMessages.map((e) => Message.fromJson(e)).toList().obs;
    }
    if (url != null) {
      state.url.value = url;
    }
    ever(state.messages, (value) {
      logger.i('stored messages length: ${state.messages.length}');
      GetStorage().write('messages', state.messages.toList());
    });
    ever(state.url, (value) {
      logger.i('stored url: $url');
      GetStorage().write('url', state.url.value);
    });
    String? storedAlias = GetStorage().read("alias");
    String? storedRegId = GetStorage().read("regId");
    if (storedRegId == null) {
      logger.d("onInit");
      XiaoMiPushPlugin.init(
          appId: "2882303761520026355", appKey: "5812002676355")
          .then((value) {
        logger.d("init then");
        XiaoMiPushPlugin.getRegId().then((value) {
          logger.d("getRegId then");
          if (value != null) {
            logger.d("getRegId value: " + value);
            state.regId = value;
            logger.d("RegId: " + state.regId);
            GetStorage().write('RegId', state.regId);
          } else {
            logger.e('回调怎么会是空的呢？');
          }
        });
        if (storedAlias == null) {
          storedAlias = randomAlpha(10);
        }
        state.alias = storedAlias;
        logger.d('Alias: ' + state.alias);
        GetStorage().write('alias', storedAlias);
        logger.v("set alias");
        XiaoMiPushPlugin.setAlias(
            alias: state.alias, category: "normal_channel");
      });
    } else {
      logger.i("loaded data from storage");
      state.regId = storedRegId;
      state.alias = storedAlias;
    }
    super.onInit();

    // new Object
    // Initial static data
  }

  ///Called 1 frame after onInit(). This is the ideal place to enter
  ///Navigation events, such as snackbar, dialog or new route, or
  ///async Asynchronous request.
  @override
  void onReady() {
    super.onReady();


    XiaoMiPushPlugin.addListener(onMessageArrived);
    XiaoMiPushPlugin.addListener(onClicked);
  }

  /// Called before the [onDelete] method. [onClose] may be used
  /// Process the resources used by the controller. Just like closing events,
  /// Or the stream before the controller is destroyed.
  /// Or dispose of objects that may cause some memory leaks,
  /// such asTextEditingControllers, AnimationControllers.
  /// It may also be useful to save some data on disk.
  @override
  void onClose() {
    super.onClose();
    // 1 stop & close Close object
    // 2 save Persistent data
  }

  ///dispose Release memory
  @override
  void dispose() {
    super.dispose();
    XiaoMiPushPlugin.removeListener(onMessageArrived);
    XiaoMiPushPlugin.removeListener(onClicked);
    // dispose Release object
  }

  // 消息到达
  onMessageArrived(type, params) {
    if (type == XiaoMiPushListenerTypeEnum.NotificationMessageArrived) {
      logger.i("${jsonEncode(params)}");
      logger.i("${params.topic}");
      logger.i("${params.description}");
      logger.i("params");
      logger.i("$params");
      state.messages
          .add(Message(topic: params.topic, content: params.description));
    }
  }
  // 点击消息
  onClicked(type, params) async {
    if (type == XiaoMiPushListenerTypeEnum.NotificationMessageClicked) {
      logger.i("${jsonEncode(params)}");
      int action = int.parse(params.extra.action);
      logger.i("action: $action");
      switch(action) {
        case 1:
          await Clipboard.setData(ClipboardData(text: params.content));
          showToast("payload copied to clipboard!");
          logger.i("payload copied to clipboard!");
          break;
        case 2:
          var url = "http://${params.content}";
          await canLaunch(url) ? await launch(url) : throw 'Could not launch ${url}';
          break;
        default:
          return;
      }
    }
  }

  initTextController() {
    // topicController.text = "主题";
    // contentController.text = "内容";

    topicController.addListener(() {
      state.topic = topicController.text.trim();
      print(state.topic);
    });
    contentController.addListener(() {
      state.content = contentController.text.trim();
      print(state.content);
    });
  }
}
