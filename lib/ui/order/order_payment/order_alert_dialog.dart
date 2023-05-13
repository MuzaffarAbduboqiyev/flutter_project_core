import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';

class OrderAlertDialog extends StatefulWidget {
  const OrderAlertDialog({Key? key}) : super(key: key);

  @override
  State<OrderAlertDialog> createState() => _OrderAlertDialogState();
}

class _OrderAlertDialogState extends State<OrderAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: getCurrentTheme(context).backgroundColor,
    );
  }
}
/*
Center(
                child: AlertDialog(
                  backgroundColor: getCurrentTheme(context).backgroundColor,
                  shadowColor: Colors.black,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  title: Column(children: [
                    Center(
                      child: Text(
                        translate("Payment").toCapitalized(),
                        style: getCurrentTheme(context).textTheme.displayLarge,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 350.0,
                      width: 300.0,
                      child: ScrollConfiguration(
                        behavior: CustomScrollBehavior(),
                        child: ListView.builder(
                          itemCount: state.paymentModel.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () =>
                                _paymentButton(state.paymentModel[index]),
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              decoration: getContainerDecoration(context),
                              child: ListTile(
                                leading:
                                    const Icon(Icons.credit_card, size: 42),
                                title: Text(state.paymentModel[index].name),
                                subtitle:
                                    Text(state.paymentModel[index].description),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
 */
