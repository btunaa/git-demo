import 'package:flutter/material.dart';
import 'package:app/user_model.dart';
import 'package:app/user_service.dart';

class UserDetailScreen extends StatefulWidget {
  final int
      userId; //kullanicinin id numarasina göre kullanici bilgilerini getirecek.

  const UserDetailScreen({super.key, required this.userId});

  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  late Future<UsersModelData?>
      user; //kullanicinin bilgilerini getirdigim degisken

  @override
  void initState() {
    super.initState();
    user = UserService()
        .fetchUser(widget.userId); //kullanici bilgilerini cekiyorum
  }

  @override
  Widget build(BuildContext context) {
    //kullanici detaylarini gosteren bolum
    return Scaffold(
      appBar: AppBar(
        title: const Text('kullanici detaylari'),
      ),
      body: FutureBuilder<UsersModelData?>(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            //veri yukleniyorsa yukleme animasyonu gozukur
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('hata oluştu'),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            final user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Hero(
                      tag: 'avatar_${user.id}',
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(user.avatar ?? ''),
                        radius: 50,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child:
                        Text('${user.firstName ?? ''} ${user.lastName ?? ''}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            )),
                  ),
                  const SizedBox(height: 8),
                  //verileri siraladigimiz bolum
                  Center(
                    child: Text(user.email ?? '',
                        style: const TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(height: 16),
                  Text('ID: ${user.id ?? ''}',
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text('First Name: ${user.firstName ?? ''}',
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text('Last Name: ${user.lastName ?? ''}',
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text('Email: ${user.email ?? ''}',
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text('Avatar: ${user.avatar ?? ''}',
                      style: const TextStyle(fontSize: 16)),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('kullanici bulunamadi'),
            );
          }
        },
      ),
    );
  }
}
