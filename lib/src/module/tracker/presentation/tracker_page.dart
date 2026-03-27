import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pbl5_mobile/generated/colors.gen.dart';
import 'package:pbl5_mobile/src/common/constant/ui_constant.dart';
import 'package:pbl5_mobile/src/common/widgets/text/heading_text.dart';
import 'package:pbl5_mobile/src/common/widgets/text/paragrahp_text.dart';

class TrackerPage extends StatelessWidget {
  const TrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.account_circle_outlined,
            size: 36.h,
            color: ColorName.primary,
          ),
          actions: [
            Icon(Icons.settings_outlined, size: 36.h, color: ColorName.gray),
          ],
          centerTitle: true,
          title: HeadingText(text: 'Tracker'),
        ),
        body: Stack(
          alignment: AlignmentGeometry.bottomCenter,
          children: [
            SizedBox.expand(
              child: Image.asset('assets/images/map1.jpg', fit: BoxFit.cover),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 30.h),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: UIConst.paddingHorizontal/4,
                  vertical: UIConst.paddingVertical
                ),
                width: 342.w,
                height: 180.h,
                decoration: BoxDecoration(
                  color: ColorName.white,
                  borderRadius: BorderRadius.circular(30.sp),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: ParagraphText(
                              text: 'CURRENT ADDRESS',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2.w,
                            ),
                            subtitle: HeadingText(
                              text: '120 Yen Lang, Ha Noi',
                              textAlign: TextAlign.left,
                              color: ColorName.black,
                              size: 20.sp,
                            ),
                          ),
                        ),
                        Icon(Icons.timer),
                        SizedBox(width: 10.w),
                        ParagraphText(text: '2s ago'),
                        SizedBox(width: 10.w),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.battery_full,color: ColorName.primary, size: 50.h,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ParagraphText(text: 'BATTERY'),
                                HeadingText(text: '84%',color: ColorName.black,),
                              ],
                            )
                          ],
                        ),

                        Row(
                          children: [
                            Icon(Icons.network_wifi,color: ColorName.chipRed, size: 50.h,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ParagraphText(text: 'NETWORK'),
                                HeadingText(text: 'LTE+',color: ColorName.black,),
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
