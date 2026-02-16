import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Home_Page/home_page.dart';
import '../we_are_working/we_are_working.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController mobileController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void login() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login Successful")),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UnderDevelopmentPage()),
      );
    }
  }

  void skipLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const home_page()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(
                              fontSize: size.width * 0.075, // responsive text
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),
                          ),

                          SizedBox(height: size.height * 0.05),
                          TextFormField(
                            controller: mobileController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            decoration: InputDecoration(
                              hintText: "Enter Mobile Number",
                              prefixText: "+91 ",
                              suffixIcon: const Icon(
                                Icons.phone_android,
                                color: Color(0xFF1565C0),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: size.height * 0.022,
                                horizontal: 15,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Color(0xFF1565C0), width: 2),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter mobile number";
                              }
                              if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                                return "Enter valid 10 digit number";
                              }
                              if (!RegExp(r'^[6-9]').hasMatch(value)) {
                                return "Must start with 6,7,8 or 9";
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: size.height * 0.035),

                          SizedBox(
                            width: double.infinity,
                            height: size.height * 0.065,
                            child: ElevatedButton(
                              onPressed: login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1565C0),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: size.width * 0.045,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.03),
              child: GestureDetector(
                onTap: skipLogin,
                child: Text(
                  "Skip Guest Login →",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: size.width * 0.04,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
