import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../common/color_extension.dart';
import '../../common_widget/round_button.dart';
import '../main_tab/main_tab_view.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  String userName = "";
  String userLastName = "";

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  void fetchUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        userName = userSnapshot['name'];
        userLastName = userSnapshot['lastName'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: media.width,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: media.width * 0.1,
                ),
                Image.asset(
                  "assets/img/welcome.png",
                  width: media.width * 0.75,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(
                  height: media.width * 0.1,
                ),
                Text(
                  "Welcome,",
                  style: TextStyle(
                      color: TColor.primaryColor1,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  "$userName $userLastName",
                  style: TextStyle(
                      color: TColor.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  "You are all set now, let’s reach your\ngoals together with us",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: TColor.gray, fontSize: 12),
                ),
                SizedBox(
                  height: media.width * 0.3,
                ),
                RoundButton(
                    title: "Go To Home",
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainTabView()));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
