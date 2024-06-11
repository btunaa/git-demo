// user_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:app/user_model.dart';
import 'package:app/user_service.dart';

class UserDetailScreen extends StatefulWidget {
  final int userId;

  const UserDetailScreen({super.key, required this.userId});

  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  late Future<UsersModelData?> user;

  @override
  void initState() {
    super.initState();
    user = UserService().fetchUser(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Detail'),
      ),
      body: FutureBuilder<UsersModelData?>(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('An error occurred'),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            final user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.avatar ?? ''),
                    radius: 50,
                  ),
                  const SizedBox(height: 16),
                  Text('${user.firstName ?? ''} ${user.lastName ?? ''}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(height: 8),
                  Text(user.email ?? '', style: const TextStyle(fontSize: 16)),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('User not found'),
            );
          }
        },
      ),
    );
  }
}
