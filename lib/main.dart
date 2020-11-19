import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_fetching_users/screens/user_List_Screen.dart';

void main() {
  runApp(MyApp());
}

//RU
/*Данный проект сделан при помощи библиотеки/package'а GetX. 
Он отвечает за Dependecy injection, routing и state management.
Все данные из сети вытягиваются при помощи библиотеки http.dart.

//En 
This project is based on GetX package, it resposible for app 
Dependency injection, Routing and State management.
All data fetches via http package
*/
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //RU
    /*GetMaterialApp заменяет MaterialApp дабы активировать
    маршрутизацию/routing внутри проекта при помощи 'Get.to(), Get.back() итд'

    //EN
    GetMaterial app allows us to user GetX routing with the Get.to(), Get.back() methods
    */
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: UserListScreen(),
    );
  }
}
