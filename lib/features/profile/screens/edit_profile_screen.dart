import 'dart:io';

import 'package:corre_aqui/features/profile/controllers/profile_controller.dart';
import 'package:corre_aqui/features/profile/domain/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';

/**
 * @author Giovane Neves
 * @since v0.0.1
 */
class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  bool isMale = true;
  String imageUrl = "";

  @override
  void initState() {
    super.initState();
    final supabase = Supabase.instance.client;
    String? userId = supabase.auth.currentUser?.id;
    if (userId != null) {
      final profileController = Get.find<ProfileController>();
      final profile = profileController.getProfileByUserId(userId);
      _nameController.text = profile.name;
      _phoneController.text = profile.phone ?? '--';
      imageUrl = profile.imageUrl;
    }
  }

  Future<void> _pickAndUploadImage(ProfileController profileController, String userId) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    final supabase = Supabase.instance.client;
    final file = File(pickedFile.path);
    final fileExt = pickedFile.path.split('.').last;
    final fileName = 'profile_$userId.$fileExt';

    try {
      final storagePath = 'profile_pics/$fileName';
      await supabase.storage.from('profile_pics').upload(storagePath, file, fileOptions: const FileOptions(upsert: true));

      final newImageUrl = supabase.storage.from('profile_pics').getPublicUrl(storagePath);

      setState(() {
        imageUrl = newImageUrl;
      });

      profileController.update();

    } catch (e) {
      Get.snackbar("Erro", "Falha ao enviar a imagem: $e", backgroundColor: Colors.red, colorText: Colors.white);
      print("$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (profileController) {
      final supabase = Supabase.instance.client;
      String? userId = supabase.auth.currentUser?.id;
      Profile profile = profileController.getProfileByUserId(userId);

      return Scaffold(
        appBar: AppBar(
          title: const Text("Editar Perfil"),
          backgroundColor: Colors.redAccent,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.red.shade700, Colors.redAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () => _pickAndUploadImage(profileController, userId!),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: imageUrl.isNotEmpty
                                ? NetworkImage(imageUrl)
                                : const AssetImage('assets/profile.jpg') as ImageProvider,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          profile.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: "Nome"),
                      ),
                      const SizedBox(height: 18,),
                      TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(labelText: "Telefone"),
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            profileController.updateProfile(
                              _nameController.text,
                              _phoneController.text,
                              imageUrl,
                            );
                            Get.back();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Salvar",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
