import 'package:delivery_service/ui/widgets/appbar/simple_appbar.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PaymentsPage();
  }
}

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({Key? key}) : super(key: key);

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getCurrentTheme(context).backgroundColor,
      appBar: simpleAppBar(context, translate("payments.payments")),
    );
  }
}
