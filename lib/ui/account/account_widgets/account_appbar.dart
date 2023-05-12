import 'package:delivery_service/controller/account_controller/account_bloc.dart';
import 'package:delivery_service/controller/account_controller/account_event.dart';
import 'package:delivery_service/controller/app_controller/app_bloc.dart';
import 'package:delivery_service/controller/app_controller/app_event.dart';
import 'package:delivery_service/ui/account/account_widgets/account_language.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountAppBar extends StatefulWidget {
  final String userName;
  final String userSurname;

  const AccountAppBar({
    Key? key,
    required this.userName,
    required this.userSurname,
  }) : super(key: key);

  @override
  State<AccountAppBar> createState() => _AccountAppBarState();
}

class _AccountAppBarState extends State<AccountAppBar> {
  bool colour = false;

  _getUserInfo() {
    context.read<AccountBloc>().add(AccountGetUserInfoEvent());
  }

  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _getUserInfo();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/img/avatar.svg",
          width: 48.0,
          height: 48.0,
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: widget.userName.isNotEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.userName.toString(),
                      style: getCurrentTheme(context).textTheme.bodyLarge,
                    ),
                    Text(
                        widget.userSurname.toString(),
                      style: getCurrentTheme(context).textTheme.bodyLarge,
                    ),
                  ],
                )
              : Text(
                  "ArtTemplate",
                  style: getCurrentTheme(context).textTheme.bodyLarge,
                ),
        ),
        const SizedBox(width: 8),
        InkWell(
          onTap: _buttonColor,
          child: colour
              ? Icon(
                  Icons.dark_mode_outlined,
                  color: getCurrentTheme(context).iconTheme.color,
                  size: 26,
                )
              : Icon(
                  Icons.wb_sunny_outlined,
                  color: getCurrentTheme(context).iconTheme.color,
                  size: 26,
                ),
        ),
        const SizedBox(width: 16),
        InkWell(
          onTap: _buttonLanguage,
          child: const Icon(Icons.language, size: 26),
        ),
      ],
    );
  }

  _buttonColor() {
    colour = !colour;
    context.read<AppBloc>().add(AppChangeThemeEvent());
  }

  _buttonLanguage() {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor:
          getCurrentTheme(context).dialogBackgroundColor.withOpacity(0.6),
      builder: (context) => const LanguageWidget(),
    );
  }

  @override
  dispose() {
    super.dispose();
  }
}
