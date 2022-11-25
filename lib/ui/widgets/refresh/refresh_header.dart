import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

getRefreshHeader() {
  return ClassicHeader(
    refreshingText: translate("refresh.refreshing"),
    completeText: translate("refresh.completed"),
    failedText: translate("refresh.failed"),
    releaseText: translate("refresh.release"),
    idleText: translate("refresh.idle"),
  );
}
