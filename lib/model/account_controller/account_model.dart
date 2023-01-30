
import 'package:delivery_service/util/service/network/network_service.dart';

abstract class AccountNetworkService {}

class AccountNetworkServiceImpl extends AccountNetworkService {
  final NetworkService networkService;

  AccountNetworkServiceImpl({required this.networkService});
}
