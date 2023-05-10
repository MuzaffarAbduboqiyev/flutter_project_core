import 'package:delivery_service/controller/otp_controller/otp_bloc.dart';
import 'package:delivery_service/controller/otp_controller/otp_event.dart';
import 'package:delivery_service/controller/otp_controller/otp_state.dart';
import 'package:delivery_service/util/extensions/string_extension.dart';
import 'package:delivery_service/util/service/translator/translate_service.dart';
import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/styles.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_builder/timer_builder.dart';

class OtpTimerWidget extends StatefulWidget {
  final String phoneNumber;

  const OtpTimerWidget({required this.phoneNumber, Key? key}) : super(key: key);

  @override
  State<OtpTimerWidget> createState() => _OtpTimerWidgetState();
}

class _OtpTimerWidgetState extends State<OtpTimerWidget> {
  late DateTime alert;

  @override
  void initState() {
    super.initState();
    alert = DateTime.now().add(const Duration(seconds: 60));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtpBloc, OtpState>(
      builder: (context, state) => TimerBuilder.scheduled(
        [alert],
        builder: (context) {
          var now = DateTime.now();
          var reached = now.compareTo(alert) >= 0;
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Text(
                  translate("verification.otp").toCapitalized(),
                  style: getCustomStyle(
                    context: context,
                    textSize: 14,
                    weight: FontWeight.w400,
                    color: reached ? errorTextColor : hintColor,
                  ),
                  textAlign: TextAlign.end,
                  maxLines: 1,
                ),
              ),
              const SizedBox(width: 8),
              !reached
                  ? TimerBuilder.periodic(const Duration(seconds: 1),
                      alignment: Duration.zero, builder: (context) {
                      var now = DateTime.now();
                      var remaining = alert.difference(now);
                      return Text(
                        _formatDuration(remaining),
                        style: getCurrentTheme(context).textTheme.bodyLarge,
                        maxLines: 1,
                      );
                    })
                  : InkWell(
                      onTap: () => _buttonResend(state),
                      child: Text(
                        translate("verification.resend").toUpperCase(),
                        style: getCustomStyle(
                          context: context,
                          textSize: 16,
                          weight: FontWeight.w500,
                          color: blueTextColor,
                        ),
                        maxLines: 1,
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }

  _buttonResend(state) {
    context
        .read<OtpBloc>()
        .add(OtpResendEvent(phoneNumber: widget.phoneNumber));
    setState(() {
      if (state.otpStatus == OtpStatus.resend) {
        alert = DateTime.now().add(const Duration(seconds: 60));
      }
    });
  }

  _formatDuration(Duration duration) {
    String f(int n) {
      return n.toString().padLeft(2, '0');
    }

    duration += const Duration(microseconds: 999999);
    return "${f(duration.inMinutes)}:${f(duration.inSeconds % 60)}";
  }
}
