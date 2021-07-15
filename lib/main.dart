// @dart=2.9
import 'package:flutter/material.dart';
import 'package:lojavirtual/models/cart_model.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/screens/category_screen.dart';
import 'package:lojavirtual/screens/home_screen.dart';
import 'package:lojavirtual/screens/login_screen.dart';
import 'package:lojavirtual/screens/signup_screen.dart';
import 'package:lojavirtual/tabs/home_tab.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
        model: UserModel(),
        child: ScopedModelDescendant<UserModel>(
          builder: (context, child, model){
            return ScopedModel<CartModel>(
              model: CartModel(model),
              child: MaterialApp(
                  title: 'Flutter´s Clothing',
                  theme: ThemeData(
                      primarySwatch: Colors.purple,
                      primaryColor: Colors.deepPurple
                  ),
                  debugShowCheckedModeBanner: false,
                  home: HomeScreen()

              ),
            );
          }
        ),

        );
  }
}
