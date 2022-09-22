part of 'widgets.dart';

showSnackbar({
  required BuildContext context,
  required String message,
  required bool isTrue,
  int duration = 1000,
}) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isTrue ? Colors.green[400] : Colors.red[400],
        duration: Duration(milliseconds: duration),
      ),
    );
