import 'package:delivery_service/controller/account_controller/account_bloc.dart';
import 'package:delivery_service/controller/account_controller/account_event.dart';
import 'package:delivery_service/controller/account_controller/account_state.dart';
import 'package:delivery_service/ui/account/account_widgets/account_appbar.dart';
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

class AccountScreen extends StatelessWidget {
  final Function goBack;

  const AccountScreen({Key? key, required this.goBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountBloc(
        AccountState.initial(),
        accountRepository: singleton(),
      ),
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
    return Scaffold(
      backgroundColor: getCurrentTheme(context).backgroundColor,
      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const AccountAppBar(),
              const SizedBox(height: 42.0),
              ListTileWidgetItem(
                title: translate("account.orders"),
                icons: Icons.list_alt_outlined,
                onTap: () {
                  pushNewScreen(context, ordersScreen, navbarStatus: false);
                },
              ),
              (state.token == true)
                  ? ListTileWidgetItem(
                      title: translate("account.profile"),
                      icons: Icons.person_outline,
                      onTap: () {
                        pushNewScreen(
                          context,
                          profileScreen,
                          navbarStatus: false,
                        );
                      })
                  : Container(),
              ListTileWidgetItem(
                title: translate("account.favorites"),
                icons: Icons.favorite_border,
                onTap: () {
                  print("ffffffffffffffffffffffffffffffffffffffffffff");
                  pushNewScreen(context, favoritesScreen,
                      navbarStatus: false,
                      arguments: {
                        "go_back": widget.goBack,
                      });
                },
              ),
              ListTileWidgetItem(
                title: translate("account.offers"),
                icons: Icons.local_offer_outlined,
                onTap: () {
                  pushNewScreen(context, offersPromosScreen,
                      navbarStatus: false);
                },
              ),
              // ListTileWidgetItem(
              //   title: translate("account.payments"),
              //   icons: Icons.credit_card,
              //   onTap: () {
              //     pushNewScreen(context, paymentsScreen, navbarStatus: false);
              //   },
              // ),
              ListTileWidgetItem(
                title: translate("account.location"),
                icons: Icons.location_on_outlined,
                onTap: () {
                  pushNewScreen(context, locationScreen, navbarStatus: false);
                },
              ),
              const SizedBox(height: 50),
              InkWell(
                onTap: () => (state.token)
                    ? _buttonSignoUt(state)
                    : _buttonSignoIn(state),
                child: Container(
                  height: 53,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: getContainerDecoration(
                    context,
                    fillColor: getCurrentTheme(context).cardColor,
                  ),
                  child: Text(
                    (state.token)
                        ? translate("account.signout").toUpperCase()
                        : translate("account.signoin").toUpperCase(),
                    style: getCurrentTheme(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  _buttonSignoIn(AccountState state) {
    if (state.token.toString().isNotEmpty) {
      pushNewScreen(context, welcomeScreen, navbarStatus: false);
    }
  }

  _buttonSignoUt(AccountState state) {
    showConfirmDialog(
      context: context,
      title: translate("account.dialog"),
      content: "",
      confirm: () {
        context
            .read<AccountBloc>()
            .add(AccountDeleteToken(deleteToken: state.token));
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
