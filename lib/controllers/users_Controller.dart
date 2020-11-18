import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:test_fetching_users/data/models/user_Model.dart';
import 'package:test_fetching_users/screens/userListHorizontal_Screen.dart';

//Данный класс отвечает за всю бизнес логику проекта
class UsersController extends GetxController {
  //Переменные
  static const String _baseURL = 'https://randomuser.me/api?results=10';
  List<UserModel> usersList = [];
  ScrollController scrollController = ScrollController();
  PageController pageController;

  //Методы
  //Метод вытягивания пользователей из сети
  void fetchUsers() async {
    try {
      http.Response response = await http.get(_baseURL);
      loadingAnimation();
      //Добавление загруженные пользователей из response.body в userList
      List decodedBody = jsonDecode(response.body)["results"];
      for (Map<String, dynamic> user in decodedBody) {
        usersList.add(UserModel.fromJson(user));
      }
      update();
    } catch (e) {
      loadingError();
    }
  }

//Данные метод вызывается в UserListScreen при создании экземпляра класса контроллера
  @override
  void onInit() {
    fetchUsers();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        fetchUsers();
      }
    });

    super.onInit();
  }

//Метод анимации загрузки. Вызывает snackbar
  loadingAnimation() {
    Get.snackbar('', '',
        titleText: Center(
          child: Text(
            'Loading new users',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
        ),
        showProgressIndicator: true,
        duration: Duration(seconds: 1),
        animationDuration: Duration(milliseconds: 500));
  }

//Сообщение об ошибке во время загрузки
  void loadingError() {
    if (!Get.isSnackbarOpen) {
      Get.snackbar('Loading error', 'Data was not fetched',
          margin: EdgeInsets.fromLTRB(5, 0, 5, 20),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[300],
          animationDuration: Duration(seconds: 1),
          duration: Duration(seconds: 30),
          mainButton: FlatButton(
            onPressed: () {
              fetchUsers();
              Get.back();
            },
            child: Text('Repeat'),
          ));
    }
  }

//Метод, который вызывается при выборе пользователя в списке на экране UserListScreen
  selectUserPage(int userIndex) {
    pageController = PageController(
      initialPage: userIndex,
    );
    pageController.addListener(() {
      if (pageController.position.pixels ==
          pageController.position.maxScrollExtent) {
        fetchUsers();
      }
    });
    Get.to(UserListHorizontal(),
        transition: Transition.fade,
        duration: Duration(milliseconds: 250),
        curve: Curves.easeIn);
  }
}
