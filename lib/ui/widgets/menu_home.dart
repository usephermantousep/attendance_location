part of 'widgets.dart';

class MenuHome extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color colorContainer;
  final Color colorTextIcon;
  const MenuHome(
      {required this.title,
      required this.icon,
      required this.colorContainer,
      required this.colorTextIcon,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
          color: colorContainer, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.topRight,
            child: Icon(
              icon,
              color: colorTextIcon,
            ),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: AppStyle.smallTextStyle.copyWith(color: colorTextIcon),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
