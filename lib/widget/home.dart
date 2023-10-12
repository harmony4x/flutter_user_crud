
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:user_crud/model/user.dart';
import 'package:user_crud/services/user_api.dart';
import 'package:user_crud/utils/showNontification.dart';
import 'package:user_crud/widget/modal_create.dart';

import 'card_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<User> users = [];
  bool isLoad = true;
  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Danh sách người dùng',
            style: TextStyle(fontSize: 30),
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context,index){
            final user = users[index];
            final email = user.email;
            final imageUrl = user.image;
            final name = user.name;
            final id = user.id;
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(id:id,fetchUsers: fetchUsers())));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal:20),
                child: Container(
                  height: 80,
                  width: double.infinity,
                  // margin: const EdgeInsets.only(bottom: 10),
                  decoration:  BoxDecoration(
                    color: const Color(0xfffdf2f9),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(imageUrl),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),

                                Text(
                                  email,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            )
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.edit),
                            Icon(Icons.delete),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        ),

        floatingActionButton: FloatingActionButton(

          onPressed: () {
            showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top:Radius.circular(20))
                ),
                isScrollControlled: true,
                context: context,
                builder: (BuildContext content) {
                  return ModalBottom(fetchUsers:fetchUsers());
                }

            );
          },
          child: const Icon(Icons.add, size: 30,),
        ),
      ),
    );
  }

  Future<void> fetchUsers() async {
    final response  = await UserApi.fetchUsers();
    setState(() {
      users = response;
    });

  }
}

class DetailScreen extends StatefulWidget {
  const DetailScreen( {super.key, required this.id, required this.fetchUsers});

  final Future<void> fetchUsers;


  final String id;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  Map<String,dynamic> user = {};
  XFile ? selectImage;

  String name = '';

  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if(widget.id != null) {
      detailUser();
    }
  }

  Future<void> detailUser() async {
    final response  = await UserApi.detailUser(widget.id);
    final Map<String,dynamic> converse = {};
    response.forEach((key, value) {
      converse[key.toString()] = value;
    });
    setState(() {
      user = converse['metadata'];
      name = user['name'];
    });

  }

  void _handleOnSubmit (name,password)  async {
    if(name.isEmpty ) {
      return;
    }
    final response  = await UserApi.updateUser(widget.id ,name,password);
    final Map<String,dynamic> converse = {};
    response.forEach((key, value) {
      converse[key.toString()] = value;
    });
    widget.fetchUsers;
    if(converse['metadata']['modifiedCount'] ==1 && converse['status'] == 200) {

      NontifiCation.showSuccessNotification(context);
    }

  }

  Future<void> showUserNameDialogAlert(BuildContext context) {

    nameController.text = name;

    void _handleOnClick (BuildContext context) async {

      if(name.isEmpty) {
        return;
      }

      setState(() {
        name = nameController.value.text.toString();
      });

      Navigator.pop(context);

    }

    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: const Text('Cập nhật tên người dùng'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,

              )
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () {
            Navigator.pop(context);
          }, child: const Text('Hủy')),
          TextButton(onPressed: ()  => _handleOnClick(context), child: const Text('Cập nhật'))
        ],
      );
    });
  }

  Future _pickImageFromGallery () async {
    final XFile? returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 100);
    if(returnedImage == null) return;
    setState(() {
      selectImage = XFile(returnedImage.path);
    });
  }


  @override
  Widget build(BuildContext context) {
    final imageUrl = user?['image'] ?? '';
    final name = user?['name'] ?? '';
    final email = user?['email'] ?? '';
    final id = user?['_id'] ?? '';
    final password = user?['password'] ?? '';
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'Chi tiết người dùng',
            style: TextStyle(fontSize: 30),
          ),
          centerTitle: true,
        ),

        body:  Padding(
          padding:const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: () => _pickImageFromGallery(),
                child: Center(
                  child: Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 3,
                        color: Colors.blueGrey,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child:
                      imageUrl.toString() == "" ? const Icon(Icons.person_2_outlined) : Image.network(
                        imageUrl,
                        loadingBuilder: (context,child,loadingProgess) {
                          if(loadingProgess==null) return child;
                          return const Center(child: CircularProgressIndicator(),);
                        },
                        errorBuilder: (context,object,stack) {
                          return Container(
                            child: const Icon(Icons.error_outline,),
                          );
                        },
                      )
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: (){
                  showUserNameDialogAlert(context);
                },
                child: ReusbableRow(
                    title: 'Tên',
                    value: nameController.value.text.toString().isEmpty ? name : nameController.value.text.toString() ,
                    iconData: Icons.person_outlined,
                )
              ),
              const Divider(color: Colors.black54),

              GestureDetector(
                  onTap: (){
                    showUserNameDialogAlert(context);
                  },
                  child: ReusbableRow(
                    title: 'Mật khẩu',
                    value: passwordController.value.text.toString().isEmpty ? password : passwordController.value.text ,
                    iconData: Icons.person_outlined,
                  )
              ),
              const Divider(color: Colors.black54),

              ReusbableRow(title: 'Email', value: email, iconData: Icons.email),
              const SizedBox(height: 40),
              ElevatedButton(
                  onPressed:() => _handleOnSubmit(nameController.value.text.toString() , passwordController.value.text.toString() ),
                  child: const Text ('Cập nhật người dùng'))

            ],
          ),
        ),

      ),
    );
  }

}

class ReusbableRow extends StatelessWidget {

  final String title, value;
  final IconData iconData;

  const ReusbableRow({super.key, required this.title, required this.value, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title, style: const TextStyle(fontSize: 16),),
          leading: Icon(iconData, size: 25,),
          trailing: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 200, // Set a maximum width for the trailing widget
            ),
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

}

