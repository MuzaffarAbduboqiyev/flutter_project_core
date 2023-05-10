import 'package:delivery_service/controller/welcome_controller/welcome_bloc.dart';
import 'package:delivery_service/controller/welcome_controller/welcome_event.dart';
import 'package:delivery_service/controller/welcome_controller/welcome_state.dart';
import 'package:delivery_service/ui/welcome_number/welcome_widgets/welcome_image.dart';
import 'package:delivery_service/ui/widgets/loading/loader_dialog.dart';
import 'package:delivery_service/util/extensions/string_extension.dart';
import 'package:delivery_service/util/service/route/route_names.dart';
import 'package:delivery_service/util/service/route/route_observable.dart';
import 'package:delivery_service/util/service/singleton/singleton.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/styles.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WelcomeBloc(
        WelcomeState.initial(),
        welcomeRepository: singleton(),
      ),
      child: const WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late MaskTextInputFormatter maskFormatter;

  @override
  void initState() {
    maskFormatter = MaskTextInputFormatter(
        mask: "(##) ### ## ##", filter: {"#": RegExp(r'[0-9]')});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WelcomeBloc, WelcomeState>(
      listener: (context, state) {
        if (state.welcomeStatus == WelcomeStatus.loading) {
          showLoadingDialog();
        } else {
          hideLoadingDialog();
          if (state.welcomeStatus == WelcomeStatus.loaded) {
            pushNewScreen(context, otpVerificationScreen,
                navbarStatus: false,
                arguments: {
                  "phone_number": state.phoneNumber,
                });
          } else if (state.welcomeStatus == WelcomeStatus.error) {
            showErrorDialog(errorMessage: state.error);
          }
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  const WelcomeImage(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 2.5),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: getCurrentTheme(context).backgroundColor,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            translate("welcome.welcome").toCapitalized(),
                            style:
                                getCurrentTheme(context).textTheme.displayLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          translate("welcome.text").toCapitalized(),
                          style: getCurrentTheme(context).textTheme.labelLarge,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 40),
                        TextField(
                          onChanged: (onChanged) {
                            context.read<WelcomeBloc>().add(
                                  WelcomeNumberListenEvent(
                                    phoneNumber:
                                        maskFormatter.unmaskText(onChanged),
                                  ),
                                );
                          },
                          inputFormatters: [maskFormatter],
                          decoration: InputDecoration(
                            labelText:
                                translate("welcome.number").toCapitalized(),
                            prefixText: "+998 ",
                            border: const OutlineInputBorder(),
                            labelStyle:
                                getCurrentTheme(context).textTheme.labelMedium,
                            prefixStyle:
                                getCurrentTheme(context).textTheme.bodyMedium,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                          ),
                          style: getCurrentTheme(context).textTheme.bodyLarge,
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 42),
                        _buttonCart(),
                        const SizedBox(height: 40),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buttonCart() {
    return BlocBuilder<WelcomeBloc, WelcomeState>(
      builder: (context, state) => GestureDetector(
        onTap: () => (state.buttonStatus) ? _button(state) : null,
        child: Container(
          height: 53,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: getContainerDecoration(
            context,
            fillColor: state.buttonStatus ? buttonColor : cardBackgroundColor,
          ),
          child: Text(
            translate("welcome.continue").toUpperCase(),
            style: getCustomStyle(
              context: context,
              textSize: 15,
              weight: FontWeight.w500,
              color: state.buttonStatus ? lightTextColor : textColor,
            ),
          ),
        ),
      ),
    );
  }

  _button(state) {
    context
        .read<WelcomeBloc>()
        .add(WelcomeCheckButtonEvent(phoneNumber: state.phoneNumber));
  }
}
