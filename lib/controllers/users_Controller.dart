import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:test_fetching_users/data/models/user_Model.dart';
import 'package:test_fetching_users/screens/user_ListHorizontal_Screen.dart';

//Данный класс отвечает за всю бизнес логику проекта
//This class is whole app business logic
class UsersController extends GetxController {
  //Переменные
  static const String _baseURL = 'https://randomuser.me/api?results=10';
  List<UserModel> usersList = [];
  ScrollController scrollController = ScrollController();
  PageController pageController;

  //Методы
  //Methods

  //Метод вытягивания пользователей из сети
  //User data fetch method
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
//Method calls in UserListScreen while creating instance of controller class
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
//Loading animation method together with a snackbar
  loadingAnimation() {
    Get.snackbar('', '',
        titleText: Center(
          child: Text(
            'Loading new users',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
        ),
        showProgressIndicator: true,
        duration: Duration(milliseconds: 750),
        animationDuration: Duration(milliseconds: 400));
  }

//Сообщение об ошибке во время загрузки
//Loading error message
  void loadingError() {
    if (!Get.isSnackbarOpen) {
      Get.snackbar('Loading error', 'Data wasnt fetched',
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
//This particular method is called when any user is selected on UserListScreen
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
