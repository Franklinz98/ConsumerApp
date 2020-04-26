import 'package:consumo_web/constants/colors.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final title;
  final content;
  final leading;
  final onPressed;

  const ListItem(
      {Key key,
      @required this.title,
      @required this.content,
      @required this.leading,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0.00, 0.00),
              color: Colors.black.withOpacity(0.16),
              blurRadius: 10,
            ),
          ],
          borderRadius: BorderRadius.circular(4.00),
        ),
        child: ListTile(
          leading: this.leading,
          title: Text(
            this.title,
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 16,
              color: AppColors.tundora,
            ),
          ),
          subtitle: Text(
            this.content,
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 12,
              color: AppColors.edward,
            ),
          ),
          isThreeLine: true,
          dense: true,
          onTap: this.onPressed
        ),
      ),
    );
  }
}
