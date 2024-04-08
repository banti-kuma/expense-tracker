import '../../export.dart';

class LinearStepIndicator extends StatelessWidget {
  final int? currentStep;
  final ScrollController? scrollController;
  final int? stepCount;
  final double? size;
  final double? lineWidth;
  final Color? lineColor;

  LinearStepIndicator({
    this.currentStep,
    this.stepCount,
    this.scrollController,
    this.size = 20.0,
    this.lineWidth = 1.8,
    this.lineColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width,
        height: height_5,
        padding: EdgeInsets.symmetric(vertical: margin_0),
        child: ListView.builder(
          controller: scrollController,
          itemCount: stepCount,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                        height: height_5,
                        decoration: BoxDecoration(
                          color:
                              index < currentStep! ? lineColor : Colors.grey,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radius_5),
                              bottomLeft: Radius.circular(radius_5)),
                        )),
                  )
                ],
              ),
              width: Get.width * 0.13,
            );
          },
        ));
  }
}
