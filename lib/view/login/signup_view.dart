import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cp_fitness_app/view/login/complete_profile_view.dart';
import 'package:cp_fitness_app/view/login/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../common/color_extension.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/round_textfield.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  String name = "";
  String lastName = "";
  String email = "";
  String password = "";
  bool isLoading = false;
  final GlobalKey<FormState> _formkeysignup = GlobalKey<FormState>();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  bool isCheck = false;
  bool showPassword = false;
  void togglePasswordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  Future<void> register() async {
    if (txtName.text.isEmpty ||
        txtPassword.text.isEmpty ||
        txtEmail.text.isEmpty ||
        txtLastName.text.isEmpty) {
      showSnackBar(
        context,
        "Please fill in all fields...!",
      );
      return;
    }
  if (!isCheck) {
    showSnackBar(context, "Please accept our Terms and Privacy to continue.");
    return;
  }
    try {
      setState(() {
        isLoading = true;
      });

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(password: password, email: email);

      // Save user details including name to Firebase or your database
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': name,
        'email': email,
        'lastName': lastName,

        // Add other user details if needed
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar((SnackBar(
            dismissDirection: DismissDirection.up,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
            backgroundColor: TColor.primaryColor1,
            content: const Text(
              "Registered Successfully",
              style: TextStyle(
                fontSize: 20,
              ),
            ))));
      }
      if (mounted) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const CompleteProfileView()));
      }
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'weak-password':
          if (context.mounted) {
            showSnackBar(context, "Password provided is too weak");
          }
          break;
        case 'email-already-in-use':
          if (context.mounted) {
            showSnackBar(context, "Account already exists!");
          }
          break;
        case 'invalid-email':
          if (context.mounted) {
            showSnackBar(context, " email address is not valid.");
          }
          break;
        case 'operation-not-allowed':
          if (context.mounted) {
            showSnackBar(context,
                "Enable email/password accounts in the Firebase Console, under the Auth tab.");
          }

        default:
          // Handle other FirebaseException codes here
          break;
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formkeysignup,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Hey there,",
                    style: TextStyle(color: TColor.gray, fontSize: 16),
                  ),
                  Text(
                    "Create an Account",
                    style: TextStyle(
                        color: TColor.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                  RoundTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your first name.";
                      }
                      return null;
                    },
                    controller: txtName,
                    hitText: "First Name",
                    icon: "assets/img/user_text.png",
                  ),
                  SizedBox(
                    height: media.width * 0.04,
                  ),
                  RoundTextField(
                    controller: txtLastName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your last name.";
                      }
                      return null;
                    },
                    hitText: "Last Name",
                    icon: "assets/img/user_text.png",
                  ),
                  SizedBox(
                    height: media.width * 0.04,
                  ),
                  RoundTextField(
                    controller: txtEmail,
                    hitText: "Email",
                    icon: "assets/img/email.png",
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email.";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: media.width * 0.04,
                  ),
                  RoundTextField(
                    controller: txtPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password.";
                      }
                      return null;
                    },
                    hitText: "Password",
                    icon: "assets/img/lock.png",
                    obscureText: !showPassword,
                    rigtIcon: TextButton(
                      onPressed: () {
                        togglePasswordVisibility();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 20,
                        height: 20,
                        child: Container(
                          alignment: Alignment.center,
                          width: 20,
                          height: 20,
                          child: !showPassword
                              ? Image.asset(
                                  "assets/img/show_password.png",
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.contain,
                                  color: TColor.gray,
                                )
                              : Icon(
                                  Icons.visibility,
                                  color: TColor.primaryColor1,
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isCheck = !isCheck;
                          });
                        },
                        icon: Icon(
                          isCheck
                              ? Icons.check_box_outlined
                              : Icons.check_box_outline_blank_outlined,
                          color: isCheck ? TColor.primaryColor1 : TColor.gray,
                          size: 21,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: RichText(
                            text: TextSpan(
                              // style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: "By continuing you accept our ",
                                  style: TextStyle(
                                      color: TColor.gray,
                                      fontSize: 12,
                                      decoration: TextDecoration.none),
                                ),
                                TextSpan(
                                  text: "Privacy Policy",
                                  style: TextStyle(
                                      color: TColor.primaryColor1,
                                      fontSize: 12,
                                      decoration: TextDecoration.none),
                                ),
                                TextSpan(
                                  text: " and ",
                                  style: TextStyle(
                                      color: TColor.gray,
                                      fontSize: 12,
                                      decoration: TextDecoration.none),
                                ),
                                TextSpan(
                                  text: "Terms of Use",
                                  style: TextStyle(
                                      color: TColor.primaryColor1,
                                      fontSize: 12,
                                      decoration: TextDecoration.none),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: media.width * 0.3,
                  ),
                  RoundButton(
                    isLoading: isLoading,
                    title: "Register",
                    onPressed: () async {
                      if (_formkeysignup.currentState!.validate()) {
                        setState(() {
                          email = txtEmail.text.trim();
                          password = txtPassword.text.trim();
                          name = txtName.text.trim();
                          lastName = txtLastName.text.trim();
                        });
                      }
                      register();
                    },
                  ),
                  SizedBox(
                    height: media.width * 0.04,
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.,
                    children: [
                      Expanded(
                          child: Container(
                        height: 1,
                        color: TColor.gray.withOpacity(0.5),
                      )),
                      Text(
                        "  Or  ",
                        style: TextStyle(color: TColor.black, fontSize: 12),
                      ),
                      Expanded(
                          child: Container(
                        height: 1,
                        color: TColor.gray.withOpacity(0.5),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: media.width * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 50,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: TColor.white,
                            border: Border.all(
                              width: 1,
                              color: TColor.gray.withOpacity(0.4),
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Image.asset(
                            "assets/img/google.png",
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: media.width * 0.04,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 50,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: TColor.white,
                            border: Border.all(
                              width: 1,
                              color: TColor.gray.withOpacity(0.4),
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Image.asset(
                            "assets/img/facebook.png",
                            width: 20,
                            height: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: media.width * 0.04,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginView()));
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(
                            color: TColor.black,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Login",
                          style: TextStyle(
                              color: TColor.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: media.width * 0.04,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
      // margin: EdgeInsets.only(
      //     bottom: MediaQuery.of(context).size.width * 1.91,
      //     left: 20,
      //     right: 20),
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.redAccent,
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    ),
  );
}
