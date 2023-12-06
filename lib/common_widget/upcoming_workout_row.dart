import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class UpcomingWorkoutRow extends StatefulWidget {
  final Map wObj;
  const UpcomingWorkoutRow({super.key, required this.wObj});

  @override
  State<UpcomingWorkoutRow> createState() => _UpcomingWorkoutRowState();
}

class _UpcomingWorkoutRowState extends State<UpcomingWorkoutRow> {
  bool positive = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: TColor.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)]),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                widget.wObj["image"].toString(),
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.wObj["title"].toString(),
                  style: TextStyle(
                      color: TColor.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  widget.wObj["time"].toString(),
                  style: TextStyle(
                    color: TColor.gray,
                    fontSize: 10,
                  ),
                ),
              ],
            )),
            CustomAnimatedToggleSwitch<bool>(
              current: positive,
              values: const [false, true],
              dif: 0.0,
              indicatorSize: const Size.square(25.0),
              animationDuration: const Duration(milliseconds: 400),
              animationCurve: Curves.linear,
              onChanged: (b) => setState(() => positive = b),
              iconBuilder: (context, local, global) {
                return const SizedBox();
              },
              defaultCursor: SystemMouseCursors.click,
              onTap: () => setState(() => positive = !positive),
              iconsTappable: false,
              wrapperBuilder: (context, global, child) {
                Color backgroundColor = positive
                    ? TColor.primaryColor1
                    : Colors.white; // Choose colors based on the state.

                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                        left: 7.0,
                        right: 7.0,
                        height: 25.0,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            gradient: LinearGradient(colors: [
                              backgroundColor,
                              backgroundColor
                            ]), // Use the chosen color here.
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50.0)),
                          ),
                        )),
                    child,
                  ],
                );
              },
              foregroundIndicatorBuilder: (context, global) {
                Color foregroundColor = positive
                    ? Colors.white
                    : TColor
                        .secondaryColor1; // Choose colors based on the state.

                return SizedBox.fromSize(
                  size: const Size(10, 10),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      // color: TColor.white,
                      color: foregroundColor, // Use the chosen color here.

                      borderRadius:
                          const BorderRadius.all(Radius.circular(50.0)),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black38,
                            spreadRadius: 0.08,
                            blurRadius: 1.5,
                            offset: Offset(0.3, 0.10))
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ));
  }
}
