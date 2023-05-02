import 'package:delivery_service/controller/otp_controller/otp_bloc.dart';
import 'package:delivery_service/controller/otp_controller/otp_event.dart';
import 'package:delivery_service/controller/otp_controller/otp_state.dart';
import 'package:delivery_service/ui/verification_otp/otp_timer.dart';
import 'package:delivery_service/ui/widgets/appbar/simple_appbar.dart';
import 'package:delivery_service/ui/widgets/loading/loader_dialog.dart';
import 'package:delivery_service/util/extensions/string_extension.dart';
import 'package:delivery_service/util/service/singleton/singleton.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/decorations.dart';
import 'package:delivery_service/util/theme/styles.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String phoneNumber;

  const OtpVerificationScreen({required this.phoneNumber, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpBloc(
        OtpState.initial(),
        otpRepository: singleton(),
      ),
      child: OtpVerificationPage(phoneNumber: phoneNumber),
    );
  }
}

class OtpVerificationPage extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationPage({required this.phoneNumber, Key? key})
      : super(key: key);

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpBloc, OtpState>(
      listener: (context, state) {
        if (state.otpStatus == OtpStatus.loading) {
          showLoadingDialog();
        } else {
          hideLoadingDialog();
          if (state.otpStatus == OtpStatus.loaded) {
            Navigator.of(context).popUntil((route) => route.isFirst);
          } else if (state.otpStatus == OtpStatus.error) {
            showErrorDialog(errorMessage: state.error);
          }
        }
      },
      child: Scaffold(
        appBar: simpleAppBar(
          context,
          translate("verification.verification").toCapitalized(),
        ),
        backgroundColor: getCurrentTheme(context).backgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 105),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  translate("verification.text"),
                  style: getCustomStyle(
                    context: context,
                    textSize: 15,
                    weight: FontWeight.w500,
                    color: hintColor,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "+998 ${widget.phoneNumber}",
                  style: getCustomStyle(
                    context: context,
                    textSize: 15,
                    weight: FontWeight.w500,
                    color: hintColor,
                  ),
                ),
                const SizedBox(height: 24.0),
                OTPTextField(
                  onChanged: (onChanged) {
                    setState(() {
                      context.read<OtpBloc>().add(
                            OtpListenCodeEvent(
                              phoneCode: onChanged,
                            ),
                          );
                    });
                  },
                  length: 4,
                  width: MediaQuery.of(context).size.width,
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldWidth: 60.0,
                  fieldStyle: FieldStyle.box,
                  outlineBorderRadius: 14,
                  contentPadding: const EdgeInsets.all(16),
                  otpFieldStyle: OtpFieldStyle(
                    errorBorderColor: buttonColor,
                    focusBorderColor: buttonColor,
                    enabledBorderColor: hintColor,
                  ),
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 16),
                OtpTimerWidget(phoneNumber: widget.phoneNumber),
                const SizedBox(height: 52.0),
                _buttonCart(widget),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buttonCart(OtpVerificationPage widget) {
    return BlocBuilder<OtpBloc, OtpState>(
      builder: (context, state) => GestureDetector(
        onTap: () => (state.buttonStatus) ? _button(state) : null,
        child: Container(
          height: 53,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: getContainerDecoration(
            context,
            fillColor: (state.buttonStatus) ? buttonColor : cardBackgroundColor,
          ),
          child: Text(
            translate("verification.verify").toUpperCase(),
            style: getCustomStyle(
              context: context,
              textSize: 15,
              weight: FontWeight.w500,
              color: (state.buttonStatus) ? lightTextColor : textColor,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ),
    );
  }

  _button(state) {
    context.read<OtpBloc>().add(OtpCheckButtonEvent(
        phoneNumber: widget.phoneNumber, phoneCode: state.phoneCode));
  }
}
