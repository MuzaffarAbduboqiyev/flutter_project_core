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
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(
        ProfileState.initial(),
        profileRepository: singleton(),
      )..add(ProfileGetUserInfoEvent()),
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
  late MaskTextInputFormatter maskFormatter;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    maskFormatter = MaskTextInputFormatter(
        mask: "(##) ### ## ##", filter: {"#": RegExp(r'[0-9]')});

    super.initState();
  }

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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProfileImage(),
                const SizedBox(height: 42),
                TextField(
                  onChanged: (name) {
                    context
                        .read<ProfileBloc>()
                        .add(ListenNameEvent(name: name));
                  },
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: (state.userName.isNotEmpty)
                        ? state.userName
                        : translate("profile.name"),
                    suffixIcon: const Icon(Icons.check),
                    prefixStyle: getCurrentTheme(context).textTheme.bodyMedium,
                    labelStyle: getCurrentTheme(context).textTheme.labelMedium,
                  ),
                  style: getCurrentTheme(context).textTheme.bodyLarge,
                  keyboardType: TextInputType.name,
                  minLines: 1,
                ),
                const SizedBox(height: 25),
                TextField(
                  onChanged: (surname) {
                    context
                        .read<ProfileBloc>()
                        .add(ListenSurnameEvent(surname: surname));
                  },
                  controller: surnameController,
                  decoration: InputDecoration(
                    labelText: (state.userSurname.isNotEmpty)
                        ? state.userSurname
                        : translate("profile.surname"),
                    suffixIcon: const Icon(Icons.check),
                    prefixStyle: getCurrentTheme(context).textTheme.bodyMedium,
                    labelStyle: getCurrentTheme(context).textTheme.labelMedium,
                  ),
                  style: getCurrentTheme(context).textTheme.bodyLarge,
                  keyboardType: TextInputType.name,
                  minLines: 1,
                ),
                const SizedBox(height: 25),
                TextField(
                  controller: phoneController,
                  inputFormatters: [maskFormatter],
                  decoration: InputDecoration(
                    prefixText: "+998 ",
                    labelText: (state.phoneNumber.isNotEmpty)
                        ? "+${state.phoneNumber}"
                        : translate("profile.phone"),
                    suffixIcon: const Icon(Icons.check),
                    prefixStyle: getCurrentTheme(context).textTheme.bodyMedium,
                    labelStyle: getCurrentTheme(context).textTheme.labelMedium,
                  ),
                  style: getCurrentTheme(context).textTheme.bodyLarge,
                  keyboardType: TextInputType.phone,
                  minLines: 1,
                ),
                const SizedBox(height: 32),
                InkWell(
                  onTap: _buttonCart,
                  child: Container(
                    height: 53,
                    width: double.infinity,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(16),
                    decoration: getContainerDecoration(
                      context,
                      fillColor:
                          (state.name.isNotEmpty && state.surname.isNotEmpty)
                              ? buttonColor
                              : cardBackgroundColor,
                    ),
                    child: Text(
                      translate("profile.save").toUpperCase(),
                      style: getCustomStyle(
                        context: context,
                        textSize: 15,
                        weight: FontWeight.w500,
                        color:
                            (state.name.isNotEmpty && state.surname.isNotEmpty)
                                ? backgroundColor
                                : textColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buttonCart() {
    context.read<ProfileBloc>().add(
          ProfileSetUserInfoEvent(
            userName: nameController.text,
            userSurname: surnameController.text,
            phoneNumber: phoneController.text,
          ),
        );
    Navigator.pop(context);
  }
}
