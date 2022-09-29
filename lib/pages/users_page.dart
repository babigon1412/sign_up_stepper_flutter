import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepper_flutter/models/stepper_models.dart';
import 'package:stepper_flutter/providers/stepper_providers.dart';
import 'package:stepper_flutter/utils/app_colors.dart';
import 'package:stepper_flutter/utils/dimensions.dart';

class UsersPage extends StatefulWidget {
  UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.bgColor,
        elevation: 0,
        centerTitle: true,
        title: Container(
          height: Dimensions.ten,
          width: Dimensions.ten * 10,
          padding: EdgeInsets.all(Dimensions.ten * 1.5),
          margin: EdgeInsets.only(bottom: Dimensions.ten * 1.5),
          decoration: BoxDecoration(
            color: AppColor.buttonColor,
            borderRadius: BorderRadius.circular(Dimensions.ten * 2),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.ten * 2),
        color: AppColor.bgColor,
        child: Column(
          children: [
            SizedBox(height: Dimensions.ten * 2),
            Text(
              'Users Database',
              style: TextStyle(
                color: AppColor.buttonColor,
                fontSize: Dimensions.ten * 1.7,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Dimensions.ten),
            Text(
              'This is the list of registered users.',
              style:
                  TextStyle(color: Colors.grey, fontSize: Dimensions.ten * 1.5),
            ),
            SizedBox(height: Dimensions.ten * 5),
            Expanded(
              child: Consumer(
                builder: (context, StepperProvider provider, child) {
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: provider.users.length,
                    itemBuilder: (BuildContext context, int index) {
                      StepperModels users = provider.users[index];
                      return Container(
                        height: Dimensions.ten * 14,
                        width: Dimensions.screenWidth,
                        padding: EdgeInsets.all(Dimensions.ten * 1.5),
                        margin: EdgeInsets.only(bottom: Dimensions.ten * 1.5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(Dimensions.ten * 2),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 3,
                              offset: const Offset(0, 5),
                              color: Colors.grey.withOpacity(0.15),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  users.username.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: Dimensions.ten * 1.6,
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.textColor,
                                  ),
                                ),
                                const Icon(Icons.keyboard_arrow_down_sharp)
                              ],
                            ),
                            Container(
                              height: Dimensions.ten * 7.5,
                              width: Dimensions.screenWidth,
                              padding: EdgeInsets.all(Dimensions.ten * 1),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(
                                    Dimensions.ten * 1.25),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.mark_email_read_rounded,
                                        color: AppColor.iconColor,
                                      ),
                                      SizedBox(width: Dimensions.ten * 1.5),
                                      Text(users.email),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.vpn_key,
                                        color: AppColor.iconColor,
                                      ),
                                      SizedBox(width: Dimensions.ten * 1.5),
                                      Text(users.password),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
