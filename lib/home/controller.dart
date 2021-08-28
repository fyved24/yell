import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:xiao_mi_push_plugin/xiao_mi_push_plugin.dart';
import 'package:random_string/random_string.dart';
import 'package:yell/home/widgets/message.dart';

import 'index.dart';

class HomeController extends GetxController {
  final logger = Logger();

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
    List? storedTodos = GetStorage().read<List>('messages');
    if (storedTodos != null) {
      state.messages = storedTodos.map((e) => Message.fromJson(e)).toList().obs;
    }
    ever(state.messages, (value) {
      print('stored');
      GetStorage().write('todos', state.messages.toList());
    });
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
          state.alias = storedAlias;
          logger.d('Alias: ' + state.alias);
          GetStorage().write('alias', storedAlias);
          logger.v("set alias");
          XiaoMiPushPlugin.setAlias(
              alias: state.alias, category: "normal_channel");
        }
      });
    } else {
      logger.i("loaded data from storage");
      state.regId = storedRegId;
      state.alias = storedAlias;
    }

    XiaoMiPushPlugin.addListener(onXiaoMiPushListener);
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
    XiaoMiPushPlugin.removeListener(onXiaoMiPushListener);

    // dispose Release object
  }

  /// 小米推送监听器
  onXiaoMiPushListener(type, params) {
    logger.i(params.toString());
  }
}
