import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:stepper_flutter/pages/users_page.dart';
import 'package:stepper_flutter/providers/stepper_providers.dart';
import 'package:stepper_flutter/utils/app_colors.dart';
import 'package:stepper_flutter/utils/dimensions.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, CupertinoPageRoute(builder: (context) => UsersPage()));
          },
          icon: Icon(
            Icons.menu_rounded,
            color: Colors.grey.shade500,
            size: Dimensions.ten * 3.25,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: Dimensions.ten),
            child: SvgPicture.asset(
              'assets/icons/notification.svg',
              color: Colors.grey.shade500,
              height: Dimensions.ten * 3.25,
            ),
          )
        ],
      ),
      body: Consumer(builder: (context, StepperProvider provider, child) {
        var users = provider.users[0];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.ten * 3),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: Dimensions.ten * 5),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          const AssetImage('assets/images/profile_3.png'),
                      radius: Dimensions.ten * 8,
                    ),
                    CircleAvatar(
                      radius: Dimensions.ten * 2.5,
                      backgroundColor: AppColor.iconColor,
                      child:
                          const Icon(Icons.mode_rounded, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.ten * 4),
                Text(
                  users.username.toUpperCase(),
                  style: TextStyle(
                    color: AppColor.buttonColor,
                    fontSize: Dimensions.ten * 1.8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Dimensions.ten * 0.5),
                Text(
                  users.email,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: Dimensions.ten * 1.5,
                  ),
                ),
                SizedBox(height: Dimensions.ten * 4),
                Container(
                  height: Dimensions.ten * 6,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 1, color: AppColor.textColor.withOpacity(0.2)),
                    ),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/account.svg',
                        height: Dimensions.ten * 2.5,
                      ),
                      SizedBox(width: Dimensions.ten * 1.5),
                      Text(
                        'Account',
                        style: TextStyle(fontSize: Dimensions.ten * 1.8),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: Dimensions.ten * 6,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 1, color: AppColor.textColor.withOpacity(0.2)),
                    ),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/phone.svg',
                        height: Dimensions.ten * 2.5,
                      ),
                      SizedBox(width: Dimensions.ten * 1.5),
                      Text(
                        'My Contact',
                        style: TextStyle(fontSize: Dimensions.ten * 1.8),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: Dimensions.ten * 6,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 1, color: AppColor.textColor.withOpacity(0.2)),
                    ),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/policy.svg',
                        height: Dimensions.ten * 2.5,
                      ),
                      SizedBox(width: Dimensions.ten * 1.5),
                      Text(
                        'Privacy & Policy',
                        style: TextStyle(fontSize: Dimensions.ten * 1.8),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: Dimensions.ten * 6,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 1, color: AppColor.textColor.withOpacity(0.2)),
                    ),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/setting.svg',
                        height: Dimensions.ten * 2.5,
                      ),
                      SizedBox(width: Dimensions.ten * 1.5),
                      Text(
                        'Setting',
                        style: TextStyle(fontSize: Dimensions.ten * 1.8),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimensions.ten * 6,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/logout.svg',
                        height: Dimensions.ten * 2.5,
                        color: Colors.red[400],
                      ),
                      SizedBox(width: Dimensions.ten * 1.5),
                      Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: Dimensions.ten * 1.8,
                          color: AppColor.iconColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
