import 'package:homefit/core/const/color_constants.dart';
import 'package:flutter/material.dart';

class SettingsContainer extends StatelessWidget {
  final bool withArrow;
  final Widget child;
  final Function()? onTap;

  const SettingsContainer({
    super.key,
    this.withArrow = false,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: ColorConstants.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(
                ColorConstants.textBlack.r.toInt(),
                ColorConstants.textBlack.g.toInt(),
                ColorConstants.textBlack.b.toInt(),
                0.12,
              ),
              blurRadius: 5.0,
              spreadRadius: 1.1,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(40),
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(child: child),
                  if (withArrow)
                    Icon(
                      Icons.arrow_forward_ios,
                      color: ColorConstants.primaryColor,
                      size: 20,
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
