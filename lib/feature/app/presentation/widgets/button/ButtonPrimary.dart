
import 'package:flutter/material.dart';
import 'package:notes_app/feature/app/presentation/widgets/button/customCPI.dart';


class ButtonPrimary extends StatelessWidget {
  final VoidCallback onPressed;
  final VoidCallback? onPressedDisabled;
  final String title;
  final double width;
  final double height;
  final Color color;
  final Color? colorDisabled;
  final TextStyle? titleStyle;
  final bool loading;
  final bool disabled;
  final double radius;

  const ButtonPrimary({Key? key,
    required this.onPressed,
    this.onPressedDisabled,
    required this.title,
    this.width = 312,
    this.height = 44,
    this.color = const Color(0xff5A00E6),
    this.titleStyle,
    this.colorDisabled = const Color(0xFF97A0B0),
    this.loading = false,
    this.disabled = false,
    this.radius = 8,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: disabled ? color.withOpacity(0.3) : color,
                // disabledForegroundColor: const Color(0xFF97A0B0),
                disabledBackgroundColor: colorDisabled,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(radius)))),
            onPressed: disabled ? onPressedDisabled : onPressed,
            child: loading
                ? loadingBox()
                : Text(
              title,
              style: titleStyle ?? const  TextStyle(
                  fontSize: 14, color: Colors.white),
            )));
  }

  Widget loadingBox() =>
      const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 2.5,
        ),
      );
}

class ButtonSecondary extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final double width;
  final double height;
  final bool? disable;
  final bool? loading;
  final double sizeLoading;
  final VoidCallback? onDisablePressed;
  final Color color;
  final Color borderColor;
  final double radius;
  final TextStyle? titleStyle;

  const ButtonSecondary({
    Key? key,
    required this.onPressed,
    required this.title,
    this.width = 312,
    this.loading = false,
    this.disable = false,
    this.onDisablePressed,
    this.sizeLoading = 30.0,
    this.height = 44,
    this.radius = 8,
    this.color = const Color(0xffFFFFFF),
    this.borderColor = const Color(0xffDFE4E8),
    this.titleStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: color,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: borderColor),
                  borderRadius: BorderRadius.all(Radius.circular(radius)))),
          onPressed: disable == true || loading == true
              ? onDisablePressed ?? () {}
              : onPressed ?? () {},
          child: loading == true
              ? Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            padding: EdgeInsets.zero,
            child: CustomCPI(
              strokeWidth: 2.5,
              heightCPI: sizeLoading,
              widthCPI: sizeLoading,
              height: sizeLoading,
              width: sizeLoading,
              color: Colors.white,
            ),
          )
              : Center(
            child: Text(title, style: titleStyle ?? const TextStyle(fontSize: 14, color:  Color(0xFF344563))),
          ),
        ));
  }
}

class ButtonLeftIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final double width;
  final double height;
  final VoidCallback? onDisablePressed;
  final bool? disable;
  final bool loading;
  final Color color;
  final Color colorLoading;
  final Color borderColor;
  final double sizeLoading;
  final Widget? child;
  final Widget icon;
  final TextStyle? titleStyle;

  const ButtonLeftIcon({Key? key,
    required this.onPressed,
    required this.title,
    this.width = 312,
    this.disable = false,
    this.child,
    this.loading = false,
    this.onDisablePressed,
    this.sizeLoading = 30.0,
    this.height = 44,
    this.titleStyle,
    this.color = const Color(0xff4589FF),
    this.colorLoading = const Color(0xff4589FF),
    this.borderColor = const Color(0xff4589FF),
    this.icon = const Icon(Icons.ac_unit)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            elevation: 0,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: borderColor),
                borderRadius: const BorderRadius.all(Radius.circular(8))),
          ),
          onPressed: disable == true || loading == true
              ? onDisablePressed ?? () {}
              : onPressed ?? () {},
          child: loading
              ? Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            padding: EdgeInsets.zero,
            child: CustomCPI(
              strokeWidth: 2.5,
              heightCPI: sizeLoading,
              widthCPI: sizeLoading,
              height: sizeLoading,
              width: sizeLoading,
              color: colorLoading,
            ),
          )
              : Row(
            children: [
              icon,
              const SizedBox(
                width: 5,
              ),
              Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: Text(title, style: titleStyle,)),
            ],
          ),
        ));
  }
}
