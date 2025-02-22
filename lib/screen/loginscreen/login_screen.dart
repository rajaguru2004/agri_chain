import 'package:flutter/material.dart';
import 'package:grocery_store_app/utils/colors.dart';

import '../../model/controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: primaryColors,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.06,
                vertical: screenHeight * 0.04,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Logo
                    Center(
                      child: Image.asset(
                        "asset/splash_logo.png",
                        height: screenHeight * 0.3,
                        width: screenWidth * 0.6,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    // Text Headers
                    const Column(
                      children: [
                        Text(
                          'Login Account',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Please login to your \n account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 60,
                    ),

                    // Input Fields
                    Column(
                      children: [
                        CustomTextField(
                          onChanged: (String text) {
                            email = text;
                          },
                          hintlabel: 'Enter Email or Phone Number',
                          label: 'Enter Email or Phone Number',
                          icon: const Icon(Icons.mail),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        CustomTextField(
                          onChanged: (String text) {
                            password = text;
                          },
                          label: 'Enter the Password',
                          icon: const Icon(
                            Icons.remove_red_eye_sharp,
                            color: Color(0xff303030),
                          ),
                          hintlabel: 'Enter the Password',
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Login Button
                    Row(
                      children: [
                        CustomBottomButton(
                          label: 'Log In',
                          color: Colors.white,
                          onPressed: () async {
                            await loginUser(context, email, password);
                            await fetchItemDetails();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CustomBottomButton extends StatelessWidget {
  const CustomBottomButton({
    super.key,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  final String label;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Expanded(
      flex: 1,
      child: TextButton(
        onPressed: onPressed,
        child: Container(
          width: screenWidth * 0.9,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: color,
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: primaryColors,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.label,
      required this.icon,
      required this.hintlabel,
      required this.onChanged});

  final String label;
  final String hintlabel;
  final Icon icon;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: screenWidth * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xffF0F1F1),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 6),
            child: TextField(
              onChanged: onChanged,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintlabel,
                hintStyle: const TextStyle(color: Color(0xff969696)),
                suffixIcon: icon,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
