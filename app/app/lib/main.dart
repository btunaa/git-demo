import 'package:flutter/material.dart';
import 'package:app/user_model.dart';
import 'package:app/user_service.dart';
import 'package:app/user_detail_screen.dart';

void main() => runApp(const MyApp()); // myapp widget'ini calistirir

class MyApp extends StatefulWidget {
  // myapp ana widgetimiz
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserService _service = UserService();
  bool isLoading = true;
  List<UsersModelData> users = []; // kullanici listesi

  //initstate metodu cagrilip fetchusers metodunu baslat
  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  //fetchusers metodu api'den asenkron olarak kullanicilari ceker
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
      title: 'Material App', //kok widget
      home: Scaffold(
        // gorsel yapi
        appBar: AppBar(
          //ustteki uyguluma cubugu
          title: const Text('Kullanici Listesi'),
        ),
        body: isLoading //alttaki durumlara gore icerikleri degisir
            ? const Center(
                child: CircularProgressIndicator(), //yukleniyorken
              )
            : users.isNotEmpty
                ? ListView.builder(
                    //liste olusturma
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return ListTile(
                        //kullanicilar icin satir olusturma
                        title: Text(
                            "${user.firstName ?? ''} ${user.lastName ?? ''}"),
                        subtitle: Text(user.email ?? ''),
                        leading: Hero(
                          //hero animasyon gecisi
                          tag: 'avatar_${user.id}',
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(user.avatar ?? ''),
                          ),
                        ),
                        onTap: () {
                          //tiklayinca detayli bilgi ekranına gecer
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
