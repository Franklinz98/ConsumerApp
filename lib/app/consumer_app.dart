import 'package:consumo_web/constants/colors.dart';
import 'package:consumo_web/screens/auth/auth.dart';
import 'package:flutter/material.dart';

class ConsumerApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mostaza',
      theme: ThemeData(
        primaryColor: AppColors.ocean_green,
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500,
            color: AppColors.tundora,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.tundora, width: 2.0),
            //  when the TextFormField in focused
          ),
          border: OutlineInputBorder(),
        ),
      ),
      /* home: ChangeNotifierProvider<ListModel>(
        create: (context) => model,
        child: MainContainer(model: model,),
      ), */
      home: Auth(),
    );
  }
}
