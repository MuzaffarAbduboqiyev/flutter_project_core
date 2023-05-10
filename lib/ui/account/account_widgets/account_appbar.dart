import 'package:delivery_service/controller/app_controller/app_bloc.dart';
import 'package:delivery_service/controller/app_controller/app_event.dart';
import 'package:delivery_service/ui/account/account_widgets/account_language.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountAppBar extends StatefulWidget {
  const AccountAppBar({Key? key}) : super(key: key);

  @override
  State<AccountAppBar> createState() => _AccountAppBarState();
}

class _AccountAppBarState extends State<AccountAppBar> {
  bool colour = false;

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
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            "ArtTemplate",
            style: getCurrentTheme(context).textTheme.displayMedium,
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
}
