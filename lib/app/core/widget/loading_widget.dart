import 'package:expense_tracker/app/core/widget/elevated_container.dart';

import '../../export.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: ElevatedContainer(
        padding: EdgeInsets.all(margin_20),
        child: const CircularProgressIndicator(
          color: AppColors.appColor,
        ),
      ),
    );
  }
}
