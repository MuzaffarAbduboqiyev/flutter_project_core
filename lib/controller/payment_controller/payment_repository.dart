import 'package:delivery_service/model/local_database/moor_database.dart';
import 'package:delivery_service/model/order_model/payment_model.dart';
import 'package:delivery_service/model/payment_model/payment_network_service.dart';
import 'package:delivery_service/model/response_model/error_handler.dart';
import 'package:delivery_service/model/response_model/network_response_model.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class PaymentRepository {
  /// order payment
  Future<DataResponseModel<List<PaymentModel>>> getPaymentCheck();

  Future<SimpleResponseModel> getOrdersRequest({
    required int locationId,
    required int shippingId,
    required int paymentId,
  });
}

class PaymentRepositoryImpl extends PaymentRepository {
  final PaymentNetworkService paymentNetworkService;
  final MoorDatabase moorDatabase;

  PaymentRepositoryImpl({
    required this.paymentNetworkService,
    required this.moorDatabase,
  });

  @override
  Future<DataResponseModel<List<PaymentModel>>> getPaymentCheck() async {
    try {
      final response = await paymentNetworkService.getPaymentCheckUrl();
      if (response.status && response.response != null) {
        if (response.response?.data.containsKey("data") == true) {
          final List<PaymentModel> paymentModel =
              parsePaymentModel(response.response?.data["data"]);
          print("${paymentModel.length}");
          return DataResponseModel.success(model: paymentModel);
        } else {
          return getDataResponseErrorHandler<List<PaymentModel>>(response);
        }
      } else {
        return getDataResponseErrorHandler<List<PaymentModel>>(response);
      }
    } catch (error) {
      return DataResponseModel.error(responseMessage: error.toString());
    }
  }

  @override
  Future<SimpleResponseModel> getOrdersRequest(
      {required int locationId,
      required int shippingId,
      required int paymentId}) async {
    try {
      final body = {
        "address_id": locationId,
        "shipping_method_id": shippingId,
        "payment_method_id": paymentId,
      };
      final response =
          await paymentNetworkService.getPaymentRequestUrl(body: body);
      if (response.status && response.response != null) {
        if (response.response?.data.containsKey("invoice") == true) {
          final Uri uris = Uri.parse("${response.response?.data["invoice"]}");
          await _launchUrl("$uris");
          await moorDatabase.clearProductCart();
          return SimpleResponseModel.success();
        } else {
          return getSimpleResponseErrorHandler(response);
        }
      } else {
        return getSimpleResponseErrorHandler(response);
      }
    } catch (error) {
      return SimpleResponseModel.error(responseMessage: error.toString());
    }
  }

  Future<void> _launchUrl(String url) async {
    final Uri urls = Uri.parse(url);

    if (!await launchUrl(
      urls,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Can not launch url";
    }
  }
}
