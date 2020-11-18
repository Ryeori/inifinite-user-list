import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_fetching_users/controllers/users_Controller.dart';
import 'package:test_fetching_users/utils/textStyles.dart';

class UserListHorizontal extends GetWidget {
  //Эеземпляр контроллера
  final UsersController usersController = Get.put(UsersController());

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User detail page'),
      ),
      body: Center(
        //GetBuilder перестраивает виджеты после изменений в
        //контроллере UserController
        child: GetBuilder<UsersController>(
          builder: (_) {
            return PageView.builder(
              controller: usersController.pageController,
              pageSnapping: true,
              itemCount: usersController.usersList.length,
              itemBuilder: (BuildContext context, int index) {
                return Transform.scale(
                  scale: 0.95,
                  child: SizedBox(
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 6,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    usersController
                                        .usersList[index].picture.large,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Divider(
                                height: 20,
                              ),

                              //Текстовые поля пользователя такие, как: Имя, телефон, адрес итд
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 5, 3),
                                  child: ListView(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        //Имя
                                        child: Text(
                                          'Name: '
                                          '${usersController.usersList[index].name.first.toString()}'
                                          ' '
                                          '${usersController.usersList[index].name.last.toString()}',
                                          style: detailedField,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        //Дата рождения
                                        child: Text(
                                          'Date of birth: '
                                          '${usersController.usersList[index].dob.date.toString()}'
                                          ' (${usersController.usersList[index].dob.age.toString()} years)',
                                          style: detailedField,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        //Адрес
                                        child: Text(
                                            'Address: '
                                                    '${usersController.usersList[index].location.postcode}'
                                                    ' '
                                                    '${usersController.usersList[index].location.city}'
                                                    ', '
                                                    '${usersController.usersList[index].location.street.number}'
                                                    ' '
                                                    '${usersController.usersList[index].location.street.name}'
                                                .toString(),
                                            style: detailedField),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        //Эл.почта
                                        child: Text(
                                          'Email: '
                                          '${usersController.usersList[index].email.toString()}',
                                          style: detailedField,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        //Телефон
                                        child: Text(
                                          'Phone: '
                                          '${usersController.usersList[index].cell.toString()}',
                                          style: detailedField,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        //Национальность
                                        child: Text(
                                          'Nationality: '
                                          '${usersController.usersList[index].nat.toString()}',
                                          style: detailedField,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ))),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
