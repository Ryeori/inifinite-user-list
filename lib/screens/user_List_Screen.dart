import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_fetching_users/controllers/users_Controller.dart';
import 'package:test_fetching_users/utils/textStyles.dart';

class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Создаем экземпляр контроллера
    //Instantiates a controller
    UsersController usersController = Get.put(UsersController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daniil Shulgin'.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        //GetBuilder позволяет перестраивать виджеты в зависимости от изменений
        // определенного контроллера,который подключен к билдеру.
        //GetBuilder allows to rebuild widgets based on Controller internal changes
        child: GetBuilder<UsersController>(
          builder: (_) {
            return ListView.builder(
              controller: usersController.scrollController,
              itemCount: usersController.usersList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    usersController.selectUserPage(index);
                  },
                  child: Card(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 2.5,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(usersController
                                .usersList[index].picture.thumbnail),
                          ),
                          SizedBox(
                            width: Get.width * 0.05,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Данные значения Text() виджетов являются
                                //соединение текстовых данных пользователя
                                //Text() data is a concatination of user's fields
                                Text(
                                  '${usersController.usersList[index].name.first.toString()}'
                                  ' '
                                  '${usersController.usersList[index].name.last.toString()}',
                                  style: mainTextStyle,
                                ),

                                Text(
                                    '${usersController.usersList[index].location.postcode}'
                                            ' '
                                            '${usersController.usersList[index].location.city}'
                                            ', '
                                            '${usersController.usersList[index].location.street.number}'
                                            ' '
                                            '${usersController.usersList[index].location.street.name}'
                                        .toString(),
                                    style: secondaryTextStyle)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
