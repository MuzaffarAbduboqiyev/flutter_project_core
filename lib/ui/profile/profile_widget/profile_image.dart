import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        "assets/img/user_avatar.svg",
        width: 130.0,
        height: 130.0,
      ),
    );
  }
}
