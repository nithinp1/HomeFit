import 'package:homefit/core/const/color_constants.dart';
import 'package:homefit/core/const/path_constants.dart';
import 'package:flutter/material.dart';

class SettingsTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String placeHolder;

  const SettingsTextField({
    super.key,
    required this.controller,
    this.obscureText = false,
    required this.placeHolder,
  });

  @override
  SettingsTextFieldState createState() => SettingsTextFieldState();
}

class SettingsTextFieldState extends State<SettingsTextField> {
  final focusNode = FocusNode();
  bool stateObscureText = false;

  @override
  void initState() {
    super.initState();

    stateObscureText = widget.obscureText;
  }

  @override
  void didUpdateWidget(covariant SettingsTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    stateObscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              _createSettingsTextField(),
              if (widget.obscureText) ...[
                Positioned(
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: _createShowEye(),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _createSettingsTextField() {
    return TextField(
      focusNode: focusNode,
      controller: widget.controller,
      obscureText: stateObscureText,
      style: TextStyle(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        hintText: widget.placeHolder,
        hintStyle: TextStyle(color: ColorConstants.grey, fontSize: 16),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
    );
  }

  Widget _createShowEye() {
    return GestureDetector(
      onTap: () {
        setState(() {
          stateObscureText = !stateObscureText;
        });
      },
      child: Image(
        image: AssetImage(PathConstants.eye),
        color:
            widget.controller.text.isNotEmpty
                ? ColorConstants.primaryColor
                : ColorConstants.grey,
      ),
    );
  }
}
