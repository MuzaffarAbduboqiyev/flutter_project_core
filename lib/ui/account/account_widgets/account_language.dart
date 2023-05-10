import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';

class LanguageWidget extends StatefulWidget {
  const LanguageWidget({Key? key}) : super(key: key);

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  bool uzb = false;
  bool rus = false;
  bool eng = false;

  _locale() {
    if (context.locale.languageCode == "uz") {
      uzb = true;
    } else if (context.locale.languageCode == "ru") {
      rus = true;
    } else if (context.locale.languageCode == "en") {
      eng = true;
    } else {
      return null;
    }
  }

  @override
  void didChangeDependencies() {
    setState(() {
      _locale();
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Radio(
                      value: uzb,
                      groupValue: true,
                      activeColor: Colors.orange,
                      onChanged: (value) {
                        setState(() {
                          uzb = true;
                          rus = false;
                          eng = false;
                        });
                      }),
                  Expanded(child: Text(translate("language.uzb"))),
                  Image.asset("assets/img/uzb.png",
                      fit: BoxFit.cover, width: 50, height: 30),
                ],
              ),
              Row(
                children: [
                  Radio(
                      value: rus,
                      groupValue: true,
                      activeColor: Colors.orange,
                      onChanged: (value) {
                        setState(() {
                          uzb = false;
                          rus = true;
                          eng = false;
                        });
                      }),
                  Expanded(child: Text(translate("language.rus"))),
                  Image.asset("assets/img/rus.png",
                      fit: BoxFit.cover, width: 50, height: 30),
                ],
              ),
              Row(
                children: [
                  Radio(
                      value: eng,
                      groupValue: true,
                      activeColor: Colors.orange,
                      onChanged: (value) {
                        setState(() {
                          uzb = false;
                          rus = false;
                          eng = true;
                        });
                      }),
                  Expanded(child: Text(translate("language.eng"))),
                  Image.asset("assets/img/eng.png",
                      fit: BoxFit.cover, width: 50, height: 30),
                ],
              ),
            ],
          ),
          backgroundColor: getCurrentTheme(context).dialogBackgroundColor,
          actions: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                translate("no"),
                style: getCurrentTheme(context).textTheme.displayMedium,
              ),
            ),
            const SizedBox(width: 16),
            InkWell(
              onTap: () => _buttonLocale(),
              child: Text(
                translate("yes"),
                style: getCurrentTheme(context).textTheme.displayMedium,
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }

  _buttonLocale() {
    if (uzb) {
      context.setLocale(const Locale('uz', 'UZ'));
      Navigator.pop(context);
    } else if (rus) {
      context.setLocale(const Locale('ru', 'RU'));
      Navigator.pop(context);
    } else if (eng) {
      context.setLocale(const Locale('en', 'EN'));
      Navigator.pop(context);
    } else {
      return null;
    }
  }
}
