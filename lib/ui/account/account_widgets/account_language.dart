import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/decorations.dart';
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
    return Container(
      decoration: BoxDecoration(
        color: getCurrentTheme(context).cardColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Expanded(child: Text(translate("language.uzb"))),
            trailing: Radio(
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
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Expanded(child: Text(translate("language.rus"))),
            trailing: Radio(
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
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Expanded(child: Text(translate("language.eng"))),
            trailing: Radio(
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
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () => _buttonLocale(),
            child: Container(
              height: 53,
              width: double.infinity,
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration:
                  getContainerDecoration(context, fillColor: buttonColor),
              child: Text(
                translate("language.confirmation"),
                style: getCurrentTheme(context).textTheme.bodyMedium,
              ),
            ),
          )
        ],
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
