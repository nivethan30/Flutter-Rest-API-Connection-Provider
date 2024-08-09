import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import '../providers/theme_provider.dart';
import '../providers/user_provider.dart';
import '../model/user.dart';
import 'dart:math' as math;

import '../utils/theme.dart';

class UsersMain extends StatefulWidget {
  const UsersMain({super.key});

  @override
  State<UsersMain> createState() => _UsersMainState();
}

class _UsersMainState extends State<UsersMain> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).getAllUsers(null);
    });
    super.initState();
  }

  List<String> names = [
    "Andrew",
    "James",
    "William",
    "Michael",
    "Johnny",
    "Wilson",
    "Logan",
    "Tony",
    "Steve"
  ];

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rest API Calling'),
        actions: [
          IconButton(
              tooltip: "Change Theme",
              onPressed: () {
                themeProvider.toggleTheme();
              },
              icon: themeProvider.themeData == AppTheme.light()
                  ? const Icon(
                      Icons.brightness_4,
                      color: Colors.black,
                    )
                  : const Icon(
                      Icons.brightness_7,
                      color: Colors.white,
                    )),
          const SizedBox(width: 20),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
              onPressed: () async {
                await userProvider.getAllUsers(null);
              },
              child: const Text('Fetch Data Without Delay')),
          ElevatedButton(
              onPressed: () async {
                await userProvider.getAllUsers(3);
              },
              child: const Text('Fetch Data With Delay')),
          userProvider.isLoading
              ? Center(
                  child: LoadingAnimationWidget.stretchedDots(
                      color: themeProvider.themeData == AppTheme.light()
                          ? Colors.deepPurple
                          : Colors.white,
                      size: 40),
                )
              : userProvider.isError
                  ? Center(
                      child: Text(userProvider.errorMessage),
                    )
                  : Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: userProvider.users.length,
                        itemBuilder: (context, index) {
                          UserModel user = userProvider.users[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Card(
                              color: themeProvider.themeData == AppTheme.light()
                                  ? Colors.grey.shade100
                                  : Colors.grey.shade700,
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 50,
                                  foregroundImage: NetworkImage(user.avatar),
                                ),
                                title:
                                    Text("${user.firstName} ${user.lastName}"),
                                subtitle: Text(user.email),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          updateUser(
                                              userProvider, user.firstName);
                                        },
                                        icon: const Icon(Icons.edit)),
                                    IconButton(
                                        onPressed: () {
                                          deleteUser(
                                              userProvider, user.firstName);
                                        },
                                        icon: const Icon(Icons.delete))
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
        ],
      ),
      floatingActionButton: userProvider.isLoading
          ? const SizedBox()
          : FloatingActionButton(
              onPressed: () {
                addUser(userProvider);
              },
              child: const Icon(Icons.add),
            ),
    );
  }

  Future<void> addUser(UserProvider userProvider) async {
    final random = math.Random();
    final String name = names[random.nextInt(names.length)];
    final bool status = await userProvider.addUser(name);
    if (status) {
      showAlert(
          type: QuickAlertType.success, title: "$name Added Successfully");
    } else {
      showAlert(type: QuickAlertType.error, title: "Failed To Add User");
    }
  }

  Future<void> updateUser(UserProvider userProvider, String name) async {
    final bool status = await userProvider.updateUser(name);
    if (status) {
      showAlert(
          type: QuickAlertType.success, title: "$name Updated Successfully");
    } else {
      showAlert(type: QuickAlertType.error, title: "Failed To Update User");
    }
  }

  Future<void> deleteUser(UserProvider userProvider, String name) async {
    final bool status = await userProvider.deleteUser();
    if (status) {
      showAlert(
          type: QuickAlertType.success, title: "$name Deleted Successfully");
    } else {
      showAlert(type: QuickAlertType.error, title: "Failed To Delete User");
    }
  }

  showAlert({required QuickAlertType type, required String title}) {
    QuickAlert.show(context: context, type: type, title: title);
  }
}
