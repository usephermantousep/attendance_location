part of 'widgets.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController? controller;
  final bool isPassword;
  final String? hintText;
  final TextInputType keyboardType;
  final int maxLines;
  final IconData? iconPrefix;
  final IconData? iconSuffix;
  final Function()? suffixTap;
  final bool showPassword;
  final String? Function(String?)? validator;
  const TextFieldInput(
      {Key? key,
      this.controller,
      this.hintText,
      this.isPassword = false,
      this.maxLines = 1,
      required this.keyboardType,
      this.iconPrefix,
      this.iconSuffix,
      this.suffixTap,
      this.showPassword = false,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        style: AppStyle.smallTextStyle,
        obscureText: isPassword && !showPassword,
        validator: validator,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: iconPrefix != null
              ? Icon(
                  iconPrefix,
                  color: Colors.grey[400],
                )
              : null,
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: suffixTap,
                  icon: Icon(
                    iconSuffix,
                    color: Colors.grey[400],
                  ),
                )
              : null,
          filled: true,
          focusedBorder:
              OutlineInputBorder(borderSide: Divider.createBorderSide(context)),
          enabledBorder:
              OutlineInputBorder(borderSide: Divider.createBorderSide(context)),
          hintText: hintText,
          hintStyle: AppStyle.smallTextStyle,
          border: OutlineInputBorder(
            borderSide: Divider.createBorderSide(context),
          ),
          contentPadding: const EdgeInsets.all(8),
        ),
      );
}
