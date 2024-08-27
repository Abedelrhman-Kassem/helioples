import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/background_image.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/Widgets/profile_item.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  List<ProfileItem> items = [
    const ProfileItem(imagePath: "assets/svg_icons/profile_icon.svg", label: "Profile Information"),
    const ProfileItem(imagePath: "assets/svg_icons/history_icon.svg", label: "Orders History"),
    const ProfileItem(imagePath: "assets/svg_icons/alert_icon.svg", label: "Alerts"),
    const ProfileItem(imagePath: "assets/svg_icons/settings_icon.svg", label: "App Settings"),
    const ProfileItem(imagePath: "assets/svg_icons/help_center_icon.svg", label: "Help Center"),
    const ProfileItem(imagePath: "assets/svg_icons/chat_icon.svg", label: "Chat with Us"),
    const ProfileItem(imagePath: "assets/svg_icons/logout_icon.svg", label: "Logout"),
  ];
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: BackgroundImage()),
          CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsetsDirectional.only(
                  start: 16.w,
                  end: 16.w,
                  top: 60.h,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.arrow_back),
                          ),
                          SizedBox(width: 100.w),
                          Text(
                            "User Profile",
                            style: Styles.styles17w600interFamily,
                          ),
                          SizedBox(width: 0.w),
                        ],
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                sliver: 
                 SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => items[index],
                    childCount: items.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0, // Optional: Add spacing between items
                    mainAxisSpacing: 12.0,  // Optional: Add spacing between items
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
