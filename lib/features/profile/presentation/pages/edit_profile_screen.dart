import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_route/annotations.dart';
import '../widgets/profile_detail_field.dart';

@RoutePage()
class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () { Navigator.pop(context); },
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 60.r,
                  backgroundImage: const NetworkImage('https://i.ibb.co/m8CpW33/profile-pic.jpg'),
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
                    onPressed: () {
                      //todo
                    },
                    padding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              "kxmillx",
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24.h),
            const ProfileDetailField(
              label: 'Your Email',
              icon: Icons.email_outlined,
              value: 'xxx@gmail.com',
            ),
            SizedBox(height: 16.h),
            const ProfileDetailField(
              label: 'Your Username',
              icon: Icons.email_outlined,
              value: 'kxmillx',
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // todo
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.orange,
                  backgroundColor: Colors.orange,
                  side: BorderSide(color: Colors.orange),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  'Edit',
                  style: TextStyle(fontSize: 18.sp, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20.h)
          ],
        ),
      ),
    );
  }
}
