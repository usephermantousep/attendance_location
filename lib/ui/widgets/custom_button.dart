part of 'widgets.dart';

class CustomButton extends StatelessWidget {
  final String text;
  const CustomButton({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue[400],
      ),
      child: Text(text,
          textAlign: TextAlign.center,
          style: AppStyle.smallTextStyle.copyWith(
            color: Colors.white,
          )),
    );
  }
}
