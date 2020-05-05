import 'package:consumo_web/constants/colors.dart';
import 'package:consumo_web/providers/list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsContainer extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final Widget content;
  final String title;

  DetailsContainer({Key key, @required this.content, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: this._scaffoldKey,
      backgroundColor: AppColors.alabaster,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.tundora,
            ),
            onPressed: () => Navigator.pop(context)),
        title: Text(
          this.title,
          style: TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: AppColors.tundora,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: this.content,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.ocean_green,
        onPressed: () {},
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }
}
