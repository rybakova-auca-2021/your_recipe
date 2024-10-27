import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_route/annotations.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.person_outline, color: Colors.black),
          onPressed: () {
            //todo
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black),
            onPressed: () {
              // todo
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              //todo
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            CircleAvatar(
              radius: 50.r,
              backgroundImage: const NetworkImage('https://i.ibb.co/m8CpW33/profile-pic.jpg'),
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
            ProfileDropdownField(
              label: 'Language',
              value: 'English',
              onChanged: (newValue) {
                // todo
              },
            ),
            SizedBox(height: 16.h),
            ProfileOptionRow(
              label: 'Meal plan',
              onTap: () {
                // todo
              },
            ),
            ProfileOptionRow(
              label: 'Saved recipes',
              onTap: () {
                //todo
              },
            ),
            Spacer(),
            LogoutButton(onPressed: () {
              // todo
            }),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}

class ProfileDetailField extends StatelessWidget {
  final String label;
  final IconData icon;
  final String value;

  const ProfileDetailField({
    Key? key,
    required this.label,
    required this.icon,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.grey),
              SizedBox(width: 8.w),
              Text(value, style: TextStyle(fontSize: 16.sp)),
            ],
          ),
        ),
      ],
    );
  }
}

class ProfileDropdownField extends StatelessWidget {
  final String label;
  final String value;
  final void Function(String?) onChanged;

  const ProfileDropdownField({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            items: ['English', 'Russian']
                .map((lang) => DropdownMenuItem(
              value: lang,
              child: Text(lang, style: TextStyle(fontSize: 16.sp)),
            ))
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

class ProfileOptionRow extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const ProfileOptionRow({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
            Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LogoutButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.orange, backgroundColor: Colors.white, side: BorderSide(color: Colors.orange),
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: Text(
          'Logout',
          style: TextStyle(fontSize: 18.sp, color: Colors.orange),
        ),
      ),
    );
  }
}
