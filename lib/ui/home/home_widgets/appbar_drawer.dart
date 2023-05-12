import 'package:delivery_service/controller/app_controller/app_bloc.dart';
import 'package:delivery_service/controller/app_controller/app_event.dart';
import 'package:delivery_service/ui/widgets/dialog/confirm_dialog.dart';
import 'package:delivery_service/util/service/route/route_names.dart';
import 'package:delivery_service/util/service/route/route_observable.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/styles.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeUserDrawer extends StatefulWidget {
  final Function goBack;
  final String userName;
  final String userSurname;

  const HomeUserDrawer({
    Key? key,
    required this.goBack,
    required this.userName,
    required this.userSurname,
  }) : super(key: key);

  @override
  State<HomeUserDrawer> createState() => _HomeUserDrawerState();
}

class _HomeUserDrawerState extends State<HomeUserDrawer> {
  bool colour = false;

  _buttonColor() {
    colour = !colour;
    context.read<AppBloc>().add(AppChangeThemeEvent());
  }

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
    return Drawer(
      elevation: 0.0,
      backgroundColor: getCurrentTheme(context).backgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: SvgPicture.asset(
              "assets/img/avatar.svg",
            ),
            accountName: Text(
              widget.userName.isNotEmpty ? widget.userName : "Name...",
              style: getCustomStyle(
                  context: context, textSize: 15, weight: FontWeight.w500),
            ),
            accountEmail: Text(
                widget.userSurname.isNotEmpty
                    ? widget.userSurname
                    : "Surname...",
                style: getCustomStyle(
                    context: context, textSize: 15, weight: FontWeight.w500)),
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border(
                bottom: BorderSide(width: 1.0, color: hintColor),
              ),
            ),
            margin: EdgeInsets.zero,
            otherAccountsPictures: [
              InkWell(
                onTap: _buttonColor,
                child: colour
                    ? const Icon(
                        Icons.wb_sunny_outlined,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.dark_mode_outlined,
                        color: Colors.white,
                      ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          ListTile(
            onTap: () {
              pushNewScreen(context, profileScreen, navbarStatus: false);
            },
            leading: Icon(
              Icons.person_outline,
              color: getCurrentTheme(context).iconTheme.color,
              size: 28,
            ),
            title: Text(
              translate("drawer.profile"),
              style: getCurrentTheme(context).textTheme.displayMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: hintColor,
            ),
          ),
          Divider(color: hintColor),
          ListTile(
            onTap: () {
              pushNewScreen(context, favoritesScreen,
                  navbarStatus: false, arguments: {"go_back": widget.goBack});
            },
            leading: Icon(
              Icons.favorite_border,
              color: getCurrentTheme(context).iconTheme.color,
              size: 28,
            ),
            title: Text(
              translate("drawer.favorites"),
              style: getCurrentTheme(context).textTheme.displayMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: hintColor,
            ),
          ),
          Divider(color: hintColor),
          ExpandableNotifier(
            child: ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  tapBodyToCollapse: true,
                  hasIcon: false,
                ),
                header: ListTile(
                  leading: Icon(
                    Icons.language,
                    color: getCurrentTheme(context).iconTheme.color,
                  ),
                  title: Text(
                    translate("drawer.til"),
                    style: getCurrentTheme(context).textTheme.displayMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  trailing: Icon(
                    Icons.expand_more,
                    color: getCurrentTheme(context).iconTheme.color,
                  ),
                ),
                collapsed: Container(),
                expanded: Container(),
                builder: (_, collapsed, expanded) {
                  return Expandable(
                    collapsed: Divider(color: hintColor),
                    expanded: Column(
                      children: [
                        Divider(color: hintColor),
                        ListTile(
                          title: Text(translate("language.uzb")),
                          trailing: Radio(
                              value: uzb,
                              groupValue: true,
                              activeColor: Colors.orange,
                              onChanged: (value) {
                                rus = false;
                                eng = false;
                                if (uzb = true) {
                                  showConfirmDialog(
                                    context: context,
                                    title: translate("language.uzb"),
                                    content: translate("drawer.choose"),
                                    confirm: () => _buttonLocale(),
                                  );
                                } else if (rus = false) {
                                  return;
                                } else if (eng = false) {
                                  return;
                                }
                              }),
                        ),
                        Divider(color: hintColor),
                        ListTile(
                          title: Text(translate("language.rus")),
                          trailing: Radio(
                              value: rus,
                              groupValue: true,
                              activeColor: Colors.orange,
                              onChanged: (value) {
                                uzb = false;
                                eng = false;
                                if (uzb = false) {
                                  return;
                                } else if (rus = true) {
                                  showConfirmDialog(
                                    context: context,
                                    title: translate("language.rus"),
                                    content: translate("drawer.choose"),
                                    confirm: () => _buttonLocale(),
                                  );
                                } else if (eng = false) {
                                  return;
                                }
                              }),
                        ),
                        Divider(color: hintColor),
                        ListTile(
                          title: Text(translate("language.eng")),
                          trailing: Radio(
                              value: eng,
                              groupValue: true,
                              activeColor: Colors.orange,
                              onChanged: (value) {
                                uzb = false;
                                rus = false;
                                if (uzb = false) {
                                  return;
                                } else if (rus = false) {
                                  return;
                                } else if (eng = true) {
                                  showConfirmDialog(
                                    context: context,
                                    title: translate("language.eng"),
                                    content: translate("drawer.choose"),
                                    confirm: () => _buttonLocale(),
                                  );
                                }
                              }),
                        ),
                        Divider(color: hintColor),
                      ],
                    ),
                    theme: const ExpandableThemeData(crossFadePoint: 0),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buttonLocale() async {
    setState(() {
      if (uzb) {
        context.setLocale(const Locale('uz', 'UZ'));
      } else if (rus) {
        context.setLocale(const Locale('ru', 'RU'));
      } else if (eng) {
        context.setLocale(const Locale('en', 'EN'));
      } else {
        return;
      }
    });
  }
}
