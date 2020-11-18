import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_fetching_users/screens/userList_Screen.dart';

void main() {
  runApp(MyApp());
}

//RU
/*Данный проект сделан при помощи библиотеки/package'а GetX. 
Он отвечает за Dependecy injection, routing и state management.
Все данные из сети вытягиваются при помощи библиотеки http.dart.
*/

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*GetMaterialApp заменяет MaterialApp дабы активировать
    маршрутизацию/routing внутри проекта при помощи 'Get.to(), Get.back() итд'
    */
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: UserListScreen(),
    );
  }
}
