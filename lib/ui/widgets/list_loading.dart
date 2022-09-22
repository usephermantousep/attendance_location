part of 'widgets.dart';

class ListLoading extends StatelessWidget {
  const ListLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[500]!,
        loop: 10,
        child: ListView.builder(
          itemCount: 12,
          itemBuilder: (context, index) => const Card(
            margin: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: ListTile(),
          ),
        ),
      );
}
