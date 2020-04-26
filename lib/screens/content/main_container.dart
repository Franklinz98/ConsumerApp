import 'package:consumo_web/constants/colors.dart';
import 'package:consumo_web/models/list_model.dart';
import 'package:consumo_web/models/user_model.dart';
import 'package:consumo_web/screens/widgets/content_list.dart';
import 'package:consumo_web/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainContainer extends StatefulWidget {
  final User user;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final ListModel model;

  MainContainer({Key key, @required this.model, @required this.user}) : super(key: key);

  @override
  _MainContainerState createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {

  @override
  Widget build(BuildContext context) {
    return Consumer<ListModel>(builder: (context, lists, child) {
      return Scaffold(
        key: widget._scaffoldKey,
        backgroundColor: AppColors.alabaster,
        appBar: AppBar(
          title: Text(
            lists.title,
            style: TextStyle(
              fontFamily: "Roboto",
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: AppColors.tundora,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        drawer: CustomDrawer(
          scaffoldKey: widget._scaffoldKey,
          name: widget.user.name,
          email: "${widget.user.username}@test.com",
          onTap1: () {
            lists.changeList(0);
            widget._scaffoldKey.currentState.openEndDrawer();
          },
          onTap2: () {
            lists.changeList(1);
            widget._scaffoldKey.currentState.openEndDrawer();
          },
          onTap3: () {
            lists.changeList(2);
            widget._scaffoldKey.currentState.openEndDrawer();
          },
        ),
        body: ContentList(
          scaffoldKey: widget._scaffoldKey,
          model: lists,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.ocean_green,
          onPressed: () {},
          tooltip: 'Add',
          child: Icon(Icons.add),
        ),
      );
    });
  }
}
