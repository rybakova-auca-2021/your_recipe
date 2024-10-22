import 'dart:convert';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:your_recipe/features/profile/domain/usecases/fetch_profile_usecase.dart';
import 'package:your_recipe/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:your_recipe/features/profile/presentation/bloc/profile_update/profile_bloc.dart';

import '../../../../core/l10n/messages_en.dart';
import '../../../../core/l10n/messages_ru.dart';

@RoutePage()
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _blocProfile = ProfileBloc(GetIt.I<FetchProfileUsecase>());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  File? _selectedImage;
  String? imageUrl;
  int? userId;

  Future<int?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

  @override
  void initState() {
    super.initState();
    _initializeProfile();
  }

  Future<void> _initializeProfile() async {
    userId = await _getUserId();
    if (userId != null) {
      _blocProfile.add(FetchProfile(userId!));
    } else {
      print("User ID not found.");
    }
  }

  Future<String?> _uploadImageToImgBB(File image) async {
    const String apiKey = '8937e8d165debe1f75719aa1b4c2ba39';
    final Uri uri = Uri.parse('https://api.imgbb.com/1/upload?key=$apiKey');
    final base64Image = base64Encode(await image.readAsBytes());

    try {
      final response = await http.post(
        uri,
        body: {'image': base64Image},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final imageUrl = data['data']['url'];
        return imageUrl;
      } else {
        print('Failed to upload image: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });

      imageUrl = await _uploadImageToImgBB(_selectedImage!);
      if (imageUrl != null) {
        print("Image URL: $imageUrl");
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    Locale currentLocale = Localizations.localeOf(context);
    bool isRussian = currentLocale.languageCode == 'ru';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: BlocConsumer<ProfileUpdateBloc, ProfileUpdateState>(
          listener: (context, state) {
            if (state is ProfileUpdateSuccess) {
              Navigator.pop(context);
            } else if (state is ProfileUpdateError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to update profile: ${state.message}')),
              );
            }
          },
          builder: (context, updateState) {
            return BlocBuilder<ProfileBloc, ProfileState>(
              bloc: _blocProfile,
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return const Center(child: CircularProgressIndicator(color: Colors.orange));
                } else if (state is ProfileFetchSuccess) {
                  final profile = state.profile;
                  emailController.text = profile.email ?? '';
                  usernameController.text = profile.username;

                  return Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 60.r,
                            backgroundImage: _selectedImage != null
                                ? FileImage(_selectedImage!)
                                : NetworkImage(profile.profilePhoto) as ImageProvider,
                          ),
                          Container(
                            width: 30.w,
                            height: 30.w,
                            decoration: const BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                              onPressed: _pickImage,
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        profile.username,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: isRussian ? messagesRu['your_email'] ?? '' : messagesEn['your_email'] ?? '',
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      TextFormField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          labelText: isRussian ? messagesRu['your_username'] ?? '' : messagesEn['your_username'] ?? '',
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            final email = emailController.text == profile.email || emailController.text.isEmpty
                                ? profile.email
                                : emailController.text;
                            final username = usernameController.text.isEmpty ? profile.username : usernameController.text;

                            context.read<ProfileUpdateBloc>().add(
                              ProfileUpdated(userId!, email, username, imageUrl ?? profile.profilePhoto),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Text(
                            isRussian ? messagesRu['edit'] ?? '' : messagesEn['edit'] ?? '',                            style: TextStyle(fontSize: 18.sp, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  );
                } else if (state is ProfileError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _blocProfile.close();
    emailController.dispose();
    usernameController.dispose();
    super.dispose();
  }
}
