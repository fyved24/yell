import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yell/home/widgets/message.dart';

class HomeState {
  HomeState() {
    ever(_regId, (value) {
      print('stored');
      if (value != null && value != "") {
        GetStorage().write('regId', _regId.toString());
      }
    });
    ever(_alias, (value) {
      print('stored');
      if (value != null && value != "") {
        GetStorage().write('alias', _alias.toString());
      }
    });
  }

  // title
  final _title = "".obs;

  set title(value) => this._title.value = value;

  get title => this._title.value;

  var _regId = "".obs;

  set regId(value) => this._regId.value = value;

  get regId => this._regId.value;

  var _alias = "".obs;

  set alias(value) => this._alias.value = value;

  get alias => this._alias.value;

  var messages = <Message>[].obs;
}
