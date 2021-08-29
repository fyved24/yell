import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yell/home/widgets/message.dart';

class HomeState {
  HomeState() {
    ever(_regId, (value) {
      print('stored regId');
      if (value != null && value != "") {
        GetStorage().write('regId', _regId.toString());
      }
    });
    ever(_alias, (value) {
      print('stored alias');
      if (value != null && value != "") {
        GetStorage().write('alias', _alias.toString());
      }
    });
  }
  var url = "https://api.ironz.cn".obs;

  // title
  final _title = "".obs;
  var _regId = "".obs;

  var _alias = "".obs;
  var _topic = "主题".obs;
  var _content = "内容".obs;

  set title(value) => this._title.value = value;

  get title => this._title.value;

  set regId(value) => this._regId.value = value;

  get regId => this._regId.value;

  set alias(value) => this._alias.value = value;

  get alias => this._alias.value;

  set topic(value) => this._topic.value = value;

  get topic => this._topic.value;

  set content(value) => this._content.value = value;

  get content => this._content.value;

  var messages = <Message>[
  ].obs;
}
