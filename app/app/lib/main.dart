import 'package:flutter/material.dart';
import 'package:app/user_model.dart';
import 'package:app/user_service.dart';
import 'package:app/user_detail_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserService _service = UserService();
  bool isLoading = true;
  List<UsersModelData> users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    final fetchedUsers = await _service.fetchUsers();
    if (fetchedUsers != null && fetchedUsers.data != null) {
      setState(() {
        users = fetchedUsers.data!;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : users.isNotEmpty
                ? ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return ListTile(
                        title: Text(
                            "${user.firstName ?? ''} ${user.lastName ?? ''}"),
                        subtitle: Text(user.email ?? ''),
                        leading: Hero(
                          tag: 'avatar_${user.id}',
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(user.avatar ?? ''),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  UserDetailScreen(userId: user.id!),
                            ),
                          );
                        },
                      );
                    },
                  )
                : const Center(
                    child: Text("Bir sorun oluştu.."),
                  ),
      ),
    );
  }
}
