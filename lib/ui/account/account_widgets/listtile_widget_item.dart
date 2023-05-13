import 'package:delivery_service/util/theme/colors.dart';
import 'package:delivery_service/util/theme/theme_methods.dart';
import 'package:flutter/material.dart';

class ListTileWidgetItem extends StatelessWidget {
  final Function onTap;
  final String title;
  final IconData icons;

  const ListTileWidgetItem({
    required this.onTap,
    required this.title,
    required this.icons,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 8 ,
      contentPadding: const EdgeInsets.only(left: 0.0, top: 8),
      onTap: () => onTap(),
      leading: Icon(
        icons,
        size: 28,
        color: getCurrentTheme(context).iconTheme.color,
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title, style: getCurrentTheme(context).textTheme.bodyLarge),
              Icon(Icons.chevron_right_outlined,
                  color: getCurrentTheme(context).iconTheme.color),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
      subtitle: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: lightHintColor),
          ),
        ),
      ),
    );
  }
}
