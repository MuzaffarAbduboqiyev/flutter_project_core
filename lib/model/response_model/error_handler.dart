import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';

DataResponseModel<T> getDataResponseErrorHandler<T>(
    NetworkResponseModel response) {
  if (response.status == true && response.response != null) {
    if (response.response?.data.containsKey("message") == true) {
      return DataResponseModel.error(
          responseMessage: response.response?.data["message"]);
    } else if (response.response?.data.containsKey("error") == true) {
      return DataResponseModel.error(
          responseMessage: response.response?.data["error"]["message"]);
    } else if (response.response?.data.containsKey("message") == true) {
      return DataResponseModel.error(
          responseMessage: response.response?.data["message"]["ru"]);
    } else {
      return DataResponseModel.error(
          responseMessage: translate("error.unknown_error"));
    }
  } else if (response.errorMessage != null) {
    return DataResponseModel.error(responseMessage: response.errorMessage);
  } else {
    return DataResponseModel.error(
        responseMessage: translate("error.unknown_error"));
  }
}

SimpleResponseModel getSimpleResponseErrorHandler(
    NetworkResponseModel response) {
  if (response.status == true && response.response != null) {
    if (response.response?.data.containsKey("message") == true) {
      return SimpleResponseModel.error(
          responseMessage: response.response?.data["message"]);
    } else if (response.response?.data.containsKey("error") == true) {
      return SimpleResponseModel.error(
          responseMessage: response.response?.data["error"]["message"]);
    } else if (response.response?.data.containsKey("message") == true) {
      return SimpleResponseModel.error(
          responseMessage: response.response?.data["message"]["ru"]);
    } else {
      return SimpleResponseModel.error(
          responseMessage: translate("error.unknown_error"));
    }
  } else if (response.errorMessage != null) {
    return SimpleResponseModel.error(responseMessage: response.errorMessage);
  } else {
    return SimpleResponseModel.error(
        responseMessage: translate("error.unknown_error"));
  }
}
