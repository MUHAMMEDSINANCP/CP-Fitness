import 'package:cp_fitness_app/view/main_tab/select_view.dart';
import 'package:cp_fitness_app/view/workout_tracker/workout_tracker_view.dart';
import 'package:flutter/material.dart';
import '../../common/colo_extension.dart';
import '../../common_widget/tab_button.dart';
import '../home/home_view.dart';
import '../photo_progress/photo_progress_view.dart';
import '../profile/profile_view.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int selectTab = 0;
  final PageStorageBucket pageBucket = PageStorageBucket();
  Widget currentTab = const HomeView();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: PageStorage(bucket: pageBucket, child: currentTab),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SizedBox(
          width: 60,
          height: 60,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WorkoutTrackerView(),
                ),
              );
            },
            child: Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: TColor.primaryG,
                  ),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.elliptical(20, 30),
                      bottomRight: Radius.elliptical(20, 30)),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 2,
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Icon(
                  Icons.search_rounded,
                  color: TColor.white,
                  size: 35,
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: BottomAppBar(
            child: Container(
          decoration: BoxDecoration(color: TColor.white, boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 2, offset: Offset(0, -2))
          ]),
          height: kToolbarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TabButton(
                  icon: "assets/img/home_tab.png",
                  selectIcon: "assets/img/home_tab_select.png",
                  isActive: selectTab == 0,
                  onTap: () {
                    selectTab = 0;
                    currentTab = const HomeView();
                    if (mounted) {
                      setState(() {});
                    }
                  }),
              TabButton(
                  icon: "assets/img/activity_tab.png",
                  selectIcon: "assets/img/activity_tab_select.png",
                  isActive: selectTab == 1,
                  onTap: () {
                    selectTab = 1;
                    currentTab = const SelectView();
                    if (mounted) {
                      setState(() {});
                    }
                  }),
              const SizedBox(
                width: 40,
              ),
              TabButton(
                  icon: "assets/img/camera_tab.png",
                  selectIcon: "assets/img/camera_tab_select.png",
                  isActive: selectTab == 2,
                  onTap: () {
                    selectTab = 2;
                    currentTab = const PhotoProgressView();
                    if (mounted) {
                      setState(() {});
                    }
                  }),
              TabButton(
                  icon: "assets/img/profile_tab.png",
                  selectIcon: "assets/img/profile_tab_select.png",
                  isActive: selectTab == 3,
                  onTap: () {
                    selectTab = 3;
                    currentTab = const ProfileView();
                    if (mounted) {
                      setState(() {});
                    }
                  })
            ],
          ),
        )),
      ),
    );
  }
}
