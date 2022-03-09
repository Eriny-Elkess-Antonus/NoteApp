import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyListWrapper extends StatelessWidget {
  const EmptyListWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/image/undraw_season_change.svg',
            width: MediaQuery.of(context).size.width * 0.64,
          ),
          const SizedBox(height: 16),
          Text(
            'لا يوجد شئ',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      ),
    );
  }
}
