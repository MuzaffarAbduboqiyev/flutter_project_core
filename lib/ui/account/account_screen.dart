import 'package:delivery_service/controller/account_controller/account_bloc.dart';
import 'package:delivery_service/controller/account_controller/account_event.dart';
import 'package:delivery_service/controller/account_controller/account_state.dart';
import 'package:delivery_service/ui/account/account_widgets/account_language.dart';
import 'package:delivery_service/ui/account/account_widgets/account_null.dart';
import 'package:delivery_service/ui/account/account_widgets/listtile_widget_item.dart';
import 'package:delivery_service/ui/widgets/dialog/confirm_dialog.dart';
import 'package:delivery_service/util/service/route/route_names.dart';
import 'package:delivery_service/util/service/route/route_observable.dart';
import 'package:delivery_service/util/service/singleton/singleton.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountScreen extends StatelessWidget {
  final Function goBack;

  const AccountScreen({Key? key, required this.goBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountBloc(
        AccountState.initial(),
        accountRepository: singleton(),
      )..add(AccountGetUserInfoEvent()),
      child: AccountPage(goBack: goBack),
    );
  }
}

class AccountPage extends StatefulWidget {
  final Function goBack;

  const AccountPage({Key? key, required this.goBack}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  _getTokenInfo() {
    context.read<AccountBloc>().add(AccountTokenInfoEvent());
    context.read<AccountBloc>().add(AccountGetUserInfoEvent());
  }

  @override
  void initState() {
    _getTokenInfo();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _getTokenInfo();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant AccountPage oldWidget) {
    _getTokenInfo();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) => (state.token == true)
          ? Scaffold(
              appBar: AppBar(
                  centerTitle: false,
                  toolbarHeight: 75.0,
                  elevation: 1.0,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/img/avatar.svg",
                        width: 48.0,
                        height: 48.0,
                      ),
                      const SizedBox(width: 16),
                      (state.userName.isNotEmpty)
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.userName.toString(),
                                  style: getCurrentTheme(context)
                                      .textTheme
                                      .bodyLarge,
                                ),
                                Text(
                                  state.userSurname.toString(),
                                  style: getCurrentTheme(context)
                                      .textTheme
                                      .bodyLarge,
                                ),
                              ],
                            )
                          : Text(
                              "ArtTemplate",
                              style: getCurrentTheme(context)
                                  .textTheme
                                  .displayMedium,
                            ),
                    ],
                  )),
              backgroundColor: getCurrentTheme(context).backgroundColor,
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTileWidgetItem(
                        title: translate("account.orders"),
                        icons: Icons.list_alt_outlined,
                        onTap: () {
                          pushNewScreen(context, ordersScreen,
                              navbarStatus: false);
                        },
                      ),
                      ListTileWidgetItem(
                          title: translate("account.profile"),
                          icons: Icons.person_outline,
                          onTap: () {
                            pushNewScreen(context, profileScreen,
                                navbarStatus: false);
                          }),
                      ListTileWidgetItem(
                        title: translate("account.favorites"),
                        icons: Icons.favorite_border,
                        onTap: () {
                          pushNewScreen(context, favoritesScreen,
                              navbarStatus: false,
                              arguments: {"go_back": widget.goBack});
                        },
                      ),
                      ListTileWidgetItem(
                        title: translate("account.location"),
                        icons: Icons.location_on_outlined,
                        onTap: () {
                          pushNewScreen(context, locationScreen,
                              navbarStatus: false);
                        },
                      ),
                      ListTileWidgetItem(
                        title: translate("account.language"),
                        icons: Icons.language,
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: false,
                              backgroundColor: Colors.transparent,
                              builder: (context) => const LanguageWidget());
                        },
                      ),
                      Expanded(child: Container()),
                      InkWell(
                        onTap: () => _buttonSignoUt(state),
                        child: Container(
                          height: 53,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: getContainerDecoration(
                            context,
                            fillColor: getCurrentTheme(context).cardColor,
                          ),
                          child: Text(
                            translate("account.signout").toUpperCase(),
                            style:
                                getCurrentTheme(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                    ]),
              ),
            )
          : const AccountNull(),
    );
  }

  _buttonSignoUt(AccountState state) {
    showConfirmDialog(
      context: context,
      title: translate("account.dialog"),
      content: "",
      confirm: () {
        context.read<AccountBloc>().add(
              AccountDeleteToken(
                deleteToken: state.token,
                deleteName: state.userName,
                deleteSurname: state.userSurname,
              ),
            );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
