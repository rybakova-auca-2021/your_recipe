import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileDropdownField extends StatelessWidget {
  final String label;
  final String value;
  final void Function(String?) onChanged;

  const ProfileDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

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
