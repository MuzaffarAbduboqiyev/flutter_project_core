import 'package:delivery_service/controller/profile_controller/profile_bloc.dart';
import 'package:delivery_service/controller/profile_controller/profile_event.dart';
import 'package:delivery_service/controller/profile_controller/profile_state.dart';
import 'package:delivery_service/ui/profile/profile_widget/profile_image.dart';
import 'package:delivery_service/ui/widgets/appbar/simple_appbar.dart';
import 'package:delivery_service/util/service/singleton/singleton.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/styles.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(
        ProfileState.initial(),
        profileRepository: singleton(),
      ),
      child: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(context, translate("profile.profile")),
      backgroundColor: getCurrentTheme(context).backgroundColor,
      body: SingleChildScrollView(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const ProfileImage(),
                const SizedBox(height: 30),
                TextField(
                  onChanged: (onChanged) {},
                  cursorColor: textColor,
                  decoration: InputDecoration(
                    suffixIcon: const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Icon(Icons.check),
                    ),
                    labelStyle: getCurrentTheme(context).textTheme.labelMedium,
                    labelText: translate("profile.name").toUpperCase(),
                    contentPadding: EdgeInsets.zero,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: getCurrentTheme(context).dividerColor),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: getCurrentTheme(context).dividerColor),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  onChanged: (onChanged) {},
                  cursorColor: textColor,
                  decoration: InputDecoration(
                    suffixIcon: const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Icon(Icons.check),
                    ),
                    labelText: translate("profile.email").toUpperCase(),
                    labelStyle: getCurrentTheme(context).textTheme.labelMedium,
                    contentPadding: EdgeInsets.zero,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: getCurrentTheme(context).dividerColor),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: getCurrentTheme(context).dividerColor),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  onChanged: (onChanged) {},
                  cursorColor: textColor,
                  decoration: InputDecoration(
                    suffixIcon: const Padding(
                      padding: EdgeInsets.only(left: 24),
                      child: Icon(Icons.check),
                    ),
                    labelText: translate("profile.phone").toUpperCase(),
                    labelStyle: getCurrentTheme(context).textTheme.labelMedium,
                    contentPadding: EdgeInsets.zero,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: getCurrentTheme(context).dividerColor),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: getCurrentTheme(context).dividerColor),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 50),
                InkWell(
                  onTap: _buttonCart(state),
                  child: Container(
                    height: 53,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: getContainerDecoration(
                      context,
                      fillColor: getCurrentTheme(context).indicatorColor,
                    ),
                    child: Text(translate("profile.save").toUpperCase(),
                        style: getCustomStyle(
                            context: context, color: lightTextColor)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buttonCart(ProfileState state) {}
}
