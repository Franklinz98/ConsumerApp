import 'package:consumo_web/backend/auth.dart' as backend;
import 'package:consumo_web/backend/courses.dart';
import 'package:consumo_web/constants/colors.dart';
import 'package:consumo_web/providers/auth_provider.dart';
import 'package:consumo_web/providers/list_provider.dart';
import 'package:consumo_web/screens/widgets/container/landing_page.dart';
import 'package:consumo_web/screens/widgets/content_list.dart';
import 'package:consumo_web/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainContainer extends StatefulWidget {
  final AuthProvider authState;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  MainContainer({Key key, @required this.authState}) : super(key: key);

  @override
  _MainContainerState createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  FutureBuilder futureBuilder;
  Future<List> futureList;

  @override
  void initState() {
    super.initState();
    // load data on startup
    _readPreferences();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return !widget.authState.isLogged
        ? LandingPage(authState: widget.authState)
        : Consumer<ListProvider>(builder: (context, lists, child) {
            if (futureList == null) {
              futureList = fetchCourses(
                  widget.authState.username, widget.authState.token, '1');
            }
            _futureBuilder(lists);
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
                name: widget.authState.name,
                email: widget.authState.email,
                coursesOnTap: () {
                  setState(() {
                    futureList = fetchCourses(
                        widget.authState.username, widget.authState.token, '1');
                  });
                  /* fetchCourses(widget.authState.username,
                          widget.authState.token, '1')
                      .then((val) {
                    lists.changeList(0, val[2]);
                  }); */
                },
                professorsOnTap: () {
                  lists.changeList(1, List());
                  widget._scaffoldKey.currentState.openEndDrawer();
                },
                studentsOnTap: () {
                  lists.changeList(2, List());
                  widget._scaffoldKey.currentState.openEndDrawer();
                },
                onLogOff: () {
                  _removePreferences();
                  widget.authState.disconnect();
                },
              ),
              body:
                  /* ContentList(
                scaffoldKey: widget._scaffoldKey,
                model: lists,
              ), */
                  futureBuilder,
              floatingActionButton: FloatingActionButton(
                backgroundColor: AppColors.ocean_green,
                onPressed: () {},
                tooltip: 'Add',
                child: Icon(Icons.add),
              ),
            );
          });
  }

  // Read user data
  _readPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "none";
    // Check token
    backend.checkToken(token)
        // if it's valid, load data
        .then((isValid) {
      if (isValid) {
        print("k");
        String name = prefs.getString('name');
        String username = prefs.getString('username');
        String email = prefs.getString('email');
        widget.authState.connect(name, email, username, token);
        futureList = fetchCourses(username, token, '1');
      } else {
        print("bruh");
        widget.authState.disconnect();
      }
    })
        // if not, set state to disconnected
        .catchError((error) {
      widget.authState.disconnect();
    });
  }

// Remove user data after logoff
  _removePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('name');
    prefs.remove('username');
    prefs.remove('email');
  }

  _futureBuilder(ListProvider model) {
    futureBuilder = FutureBuilder<List>(
      // Future: HTTP Request
      future: futureList,
      builder: (context, snapshot) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          widget._scaffoldKey.currentState.openEndDrawer();
        });
        // Succesful request: bind data
        if (snapshot.hasData) {
          model.changeList(0, snapshot.data[2]);
          return ContentList(
            scaffoldKey: widget._scaffoldKey,
            model: model,
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              "ACEPTAR",
              style: TextStyle(
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          );
        }
        // By default, show a loading spinner.
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.ocean_green),
          ),
        );
      },
    );
  }
}
