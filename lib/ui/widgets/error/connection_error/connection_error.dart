import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/styles.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';

class ConnectionErrorWidget extends StatelessWidget {
  final Function refreshFunction;

  const ConnectionErrorWidget({required this.refreshFunction, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: getCurrentTheme(context).backgroundColor,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/img/connection_error.png"),
              const SizedBox(
                height: 24,
              ),
              Text(
                translate("error.no_internet_connection"),
                style: getCurrentTheme(context).textTheme.displayMedium,
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () => refreshFunction.call(),
                child: Container(
                  decoration: BoxDecoration(
                    color: getCurrentTheme(context).backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 1,
                      color: getCurrentTheme(context).primaryColor,
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: translate("error.refresh"),
                            style: getCustomStyle(
                              context: context,
                              weight: FontWeight.w700,
                            ),
                          ),
                          WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Icon(
                                  Icons.cached_outlined,
                                  color:
                                      getCurrentTheme(context).iconTheme.color,
                                  size: 24,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
