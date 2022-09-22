part of 'widgets.dart';

class DialogHandlePermission extends StatelessWidget {
  final Function() function;
  const DialogHandlePermission({required this.function, super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'This application need permission to access location',
                maxLines: 2,
                textAlign: TextAlign.center,
                style: AppStyle.mediumTextStyle,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: function,
                child: Text(
                  "OK",
                  style: AppStyle.smallTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
