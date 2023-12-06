import 'package:flutter/material.dart';
import '../common/color_extension.dart';

enum RoundButtonType { bgGradient, bgSGradient, textGradient }

class RoundButton extends StatelessWidget {
  final String title;
  final RoundButtonType type;
  final VoidCallback onPressed;
  final double fontSize;
  final double elevation;
  final bool isLoading;

  final FontWeight fontWeight;

  const RoundButton({
    super.key,
    required this.title,
    this.type = RoundButtonType.bgGradient,
    this.fontSize = 16,
    this.elevation = 1,
    this.fontWeight = FontWeight.w700,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: type == RoundButtonType.bgSGradient
                ? TColor.secondaryG
                : TColor.primaryG,
          ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: type == RoundButtonType.bgGradient ||
                  type == RoundButtonType.bgSGradient
              ? const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 0.5,
                      offset: Offset(0, 0.5))
                ]
              : null),
      child: MaterialButton(
        onPressed: isLoading ? null : onPressed,
        height: 50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        textColor: TColor.primaryColor1,
        minWidth: double.maxFinite,
        elevation: type == RoundButtonType.bgGradient ||
                type == RoundButtonType.bgSGradient
            ? 0
            : elevation,
        color: type == RoundButtonType.bgGradient ||
                type == RoundButtonType.bgSGradient
            ? Colors.transparent
            : TColor.white,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (isLoading)
              SizedBox(
                height: 26,
                width: 26,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  color: TColor.white,
                  backgroundColor: TColor.secondaryColor1,
                ),
              ),
            if (!isLoading) // Only show text if not loading
              type == RoundButtonType.bgGradient ||
                      type == RoundButtonType.bgSGradient
                  ? Text(title,
                      style: TextStyle(
                          color: TColor.white,
                          fontSize: fontSize,
                          fontWeight: fontWeight))
                  : ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) {
                        return LinearGradient(
                                colors: TColor.primaryG,
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight)
                            .createShader(Rect.fromLTRB(
                                0, 0, bounds.width, bounds.height));
                      },
                      child: Text(title,
                          style: TextStyle(
                              color: TColor.primaryColor1,
                              fontSize: fontSize,
                              fontWeight: fontWeight)),
                    ),
          ],
        ),
      ),
    );
  }
}
