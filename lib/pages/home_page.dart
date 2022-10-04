import 'dart:async';

import 'package:email_auth/email_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:stepper_flutter/models/stepper_models.dart';
import 'package:stepper_flutter/pages/profile.dart';
import 'package:stepper_flutter/providers/stepper_providers.dart';
import 'package:stepper_flutter/utils/app_colors.dart';
import 'package:stepper_flutter/utils/dimensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentStep = 0;
  int second = 60;
  String initialEmail = '';
  String otpBox = '';
  bool isLoading = false;
  bool isDone = false;
  bool isMatch = false;
  bool isError = false;

  Timer? time;

  final _formEmail = GlobalKey<FormState>();
  final _formPassword = GlobalKey<FormState>();

  var email = TextEditingController();
  var user = TextEditingController();
  var password = TextEditingController();
  var otpBox1 = TextEditingController();
  var otpBox2 = TextEditingController();
  var otpBox3 = TextEditingController();
  var otpBox4 = TextEditingController();
  var otpBox5 = TextEditingController();
  var otpBox6 = TextEditingController();

  var emailAuth = EmailAuth(sessionName: "Sample session");

  @override
  void initState() {
    emailAuth.config({"server": "server url", "serverKey": "serverKey"});
    super.initState();
  }

  void sendOTP() async {
    var res = await emailAuth.sendOtp(recipientMail: email.text, otpLength: 6);
    if (res) {
      setState(() {
        _currentStep++;
        isLoading = false;

        second = 60;
        timerCountdown();

        shortEmail();
      });
    }
  }

  void verifyOTP(String value) {
    var res = emailAuth.validateOtp(recipientMail: email.text, userOtp: value);
    if (res) {
      setState(() {
        isDone = true;
        _currentStep++;
        isLoading = false;
        isDone = false;
        time?.cancel();
      });
    }
  }

  void timerCountdown() {
    time = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (second > 0) {
          second--;
        } else {
          setText();
          isError = true;
          time?.cancel();
        }
      });
    });
  }

  void setText() {
    setState(() {
      email = TextEditingController();
      otpBox1 = TextEditingController();
      otpBox2 = TextEditingController();
      otpBox3 = TextEditingController();
      otpBox4 = TextEditingController();
      otpBox5 = TextEditingController();
      otpBox6 = TextEditingController();
      otpBox = '';
    });
  }

  void shortEmail() {
    if (email.text.isNotEmpty) {
      String str = '${email.text[0]}${email.text[1]}***';
      bool isFound = false;

      for (int i = 0; i < email.text.length; i++) {
        if (email.text[i] == '@') {
          isFound = true;
        }
        if (isFound == true) {
          str += email.text[i];
        }
      }

      setState(() {
        initialEmail = str;
      });
    }
  }

  List<Step> stepsList() => [
        Step(
          title: const Text('Step 1'),
          content: Form(
            key: _formEmail,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Dimensions.ten * 25,
                  margin: EdgeInsets.only(
                    top: Dimensions.ten * 3,
                    bottom: Dimensions.ten * 7,
                  ),
                  child: SvgPicture.asset('assets/images/sign_in.svg'),
                ),
                Text(
                  'Welcome to Stepper !',
                  style: TextStyle(
                    color: AppColor.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: Dimensions.ten * 2.25,
                  ),
                ),
                SizedBox(height: Dimensions.ten * 0.5),
                Text(
                  'Please enter your email to sign up.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: Dimensions.ten * 1.5,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: Dimensions.ten * 3,
                    bottom: Dimensions.ten * 2,
                  ),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      blurRadius: Dimensions.ten * 2,
                      offset: const Offset(0, 15),
                      color: Colors.blue.shade50.withOpacity(0.6),
                    )
                  ]),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    controller: email,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.ten),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      RegExp regExp = RegExp(
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      }
                      if (!regExp.hasMatch(value)) {
                        return 'Invalid email';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: Dimensions.screenWidth,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColor.buttonColor,
                      padding: EdgeInsets.all(Dimensions.ten),
                      textStyle: TextStyle(
                        fontSize: Dimensions.ten * 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          Dimensions.ten,
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (_formEmail.currentState!.validate()) {
                        if (_currentStep < stepsList().length - 1) {
                          setState(() {
                            isLoading = true;
                            sendOTP();
                          });
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: Dimensions.ten * 1.5,
                        ),
                        const Text('Continue'),
                        CircleAvatar(
                          backgroundColor: AppColor.darkGreen,
                          radius: Dimensions.ten * 1.5,
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : Icon(
                                  Icons.arrow_forward_rounded,
                                  color: Colors.white.withOpacity(0.75),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Step(
          title: const Text('Step 2'),
          content: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Dimensions.ten * 2),
                Text(
                  'Email Verification',
                  style: TextStyle(
                    color: AppColor.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: Dimensions.ten * 2.25,
                  ),
                ),
                SizedBox(height: Dimensions.ten * 1.5),
                Text(
                  'Please check your email, we have sent the code to ',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: Dimensions.ten * 1.5,
                  ),
                ),
                SizedBox(height: Dimensions.ten * 0.5),
                Text(
                  initialEmail,
                  style: TextStyle(
                    color: AppColor.buttonColor,
                    fontWeight: FontWeight.bold,
                    fontSize: Dimensions.ten * 1.5,
                  ),
                ),
                SizedBox(height: Dimensions.ten * 0.5),
                Row(
                  children: [
                    Text(
                      'and it\'ll be reset in  ',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: Dimensions.ten * 1.5,
                      ),
                    ),
                    Text(
                      second.toString(),
                      style: TextStyle(
                        color: AppColor.buttonColor,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.ten * 1.5,
                      ),
                    ),
                    Text(
                      '  seconds.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: Dimensions.ten * 1.5,
                      ),
                    ),
                  ],
                ),
                isError
                    ? SizedBox(height: Dimensions.ten)
                    : const SizedBox.shrink(),
                isError
                    ? Text(
                        'The times run out, you have to send the code a again.',
                        style: TextStyle(
                          color: AppColor.iconColor,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.ten * 1.5,
                        ),
                      )
                    : const SizedBox.shrink(),
                SizedBox(height: Dimensions.ten * 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: Dimensions.ten * 4,
                      child: TextFormField(
                        controller: otpBox1,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: Dimensions.ten * 2.5),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                      ),
                    ),
                    SizedBox(width: Dimensions.ten),
                    SizedBox(
                      width: Dimensions.ten * 4,
                      child: TextFormField(
                        controller: otpBox2,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: Dimensions.ten * 2.5),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                      ),
                    ),
                    SizedBox(width: Dimensions.ten),
                    SizedBox(
                      width: Dimensions.ten * 4,
                      child: TextFormField(
                        controller: otpBox3,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: Dimensions.ten * 2.5),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                      ),
                    ),
                    SizedBox(width: Dimensions.ten),
                    SizedBox(
                      width: Dimensions.ten * 4,
                      child: TextFormField(
                        controller: otpBox4,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: Dimensions.ten * 2.5),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                      ),
                    ),
                    SizedBox(width: Dimensions.ten),
                    SizedBox(
                      width: Dimensions.ten * 4,
                      child: TextFormField(
                        controller: otpBox5,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: Dimensions.ten * 2.5),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                      ),
                    ),
                    SizedBox(width: Dimensions.ten),
                    SizedBox(
                      width: Dimensions.ten * 4,
                      child: TextFormField(
                        controller: otpBox6,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: Dimensions.ten * 2.5),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                      ),
                    ),
                    SizedBox(width: Dimensions.ten),
                  ],
                ),
                SizedBox(height: Dimensions.ten * 3),
                SizedBox(
                  width: Dimensions.screenWidth,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColor.buttonColor,
                      padding: EdgeInsets.all(Dimensions.ten),
                      textStyle: TextStyle(
                        fontSize: Dimensions.ten * 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          Dimensions.ten,
                        ), // <-- Radius
                      ),
                    ),
                    onPressed: () {
                      if (_currentStep < stepsList().length - 1) {
                        otpBox += (otpBox1.text +
                            otpBox2.text +
                            otpBox3.text +
                            otpBox4.text +
                            otpBox5.text +
                            otpBox6.text);

                        setState(() {
                          isLoading = true;
                          verifyOTP(otpBox);
                        });
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: Dimensions.ten * 1.5,
                        ),
                        const Text('Continue'),
                        CircleAvatar(
                          backgroundColor:
                              isDone ? Colors.green[800] : AppColor.darkGreen,
                          radius: Dimensions.ten * 1.5,
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : isDone
                                  ? const Icon(
                                      Icons.check_circle_outline_outlined,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Colors.white.withOpacity(0.75),
                                    ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Step(
          title: const Text('Step 3'),
          content: Center(
            child: Form(
              key: _formPassword,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: Dimensions.ten * 3,
                      bottom: Dimensions.ten * 2,
                    ),
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        blurRadius: Dimensions.ten * 2,
                        offset: const Offset(0, 15),
                        color: Colors.blue.shade50.withOpacity(0.6),
                      )
                    ]),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: user,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'User name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.ten),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter user name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: Dimensions.ten * 2),
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        blurRadius: Dimensions.ten * 2,
                        offset: const Offset(0, 15),
                        color: Colors.blue.shade50.withOpacity(0.6),
                      )
                    ]),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: password,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.ten),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                  ),
                  FlutterPwValidator(
                    successColor: AppColor.buttonColor,
                    failureColor: Colors.grey.shade400,
                    defaultColor: Colors.grey.shade400,
                    controller: password,
                    minLength: 8,
                    uppercaseCharCount: 1,
                    numericCharCount: 1,
                    specialCharCount: 1,
                    normalCharCount: 1,
                    width: Dimensions.screenWidth,
                    height: Dimensions.ten * 15,
                    onSuccess: () {
                      setState(() {
                        isMatch = true;
                      });
                    },
                    onFail: () {
                      setState(() {
                        isMatch = false;
                      });
                    },
                  ),
                  SizedBox(height: Dimensions.ten * 4),
                  SizedBox(
                    height: Dimensions.ten * 5,
                    width: Dimensions.screenWidth,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: AppColor.buttonColor,
                        padding: EdgeInsets.all(Dimensions.ten),
                        textStyle: TextStyle(
                          fontSize: Dimensions.ten * 1.5,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Dimensions.ten * 1.2,
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (_formPassword.currentState!.validate()) {
                          if (isMatch) {
                            var provider = Provider.of<StepperProvider>(context,
                                listen: false);
                            var data = StepperModels(
                                username: user.text,
                                password: password.text,
                                email: email.text);
                            provider.add(data);
                            Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const ProfilePage()),
                            );
                            setState(() {
                              second = 60;
                              isError = false;
                            });
                          }
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [Text('Complete')],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      extendBodyBehindAppBar: true,
      appBar: _currentStep > 0
          ? AppBar(
              backgroundColor: AppColor.bgColor,
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  if (_currentStep > 0) {
                    if (_currentStep == 2) {
                      setState(() {
                        setText();
                        isError = false;
                        _currentStep = 0;
                      });
                    } else {
                      setState(() {
                        setText();
                        isError = false;
                        _currentStep--;
                      });
                    }
                  }
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.black,
                ),
              ),
              title: Text(
                'Step ${_currentStep + 1}/3',
                style: TextStyle(
                    color: AppColor.buttonColor,
                    fontWeight: FontWeight.bold,
                    fontSize: Dimensions.ten * 1.6),
              ),
            )
          : AppBar(
              backgroundColor: AppColor.bgColor,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Step ${_currentStep + 1}/3',
                style: TextStyle(
                    color: AppColor.buttonColor,
                    fontWeight: FontWeight.bold,
                    fontSize: Dimensions.ten * 1.6),
              ),
            ),
      body: Container(
        height: Dimensions.screenHeight,
        width: Dimensions.screenWidth,
        margin: EdgeInsets.only(top: Dimensions.ten * 3),
        child: Stepper(
          steps: stepsList(),
          type: StepperType.horizontal,
          currentStep: _currentStep,
          elevation: 0,
          controlsBuilder: (context, details) {
            return const Text('');
          },
        ),
      ),
    );
  }
}
