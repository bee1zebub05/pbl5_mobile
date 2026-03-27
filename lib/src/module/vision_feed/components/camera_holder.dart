import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pbl5_mobile/src/common/constant/ui_constant.dart';
import 'package:pbl5_mobile/src/module/vision_feed/cubit/vision_feed_cubit.dart';
import 'package:pbl5_mobile/src/module/vision_feed/cubit/vision_feed_state.dart';
import 'package:pbl5_mobile/src/module/vision_feed/model/mjpeg_viewer.dart';

class CameraHolder extends StatelessWidget {
  const CameraHolder({super.key});

  @override
  Widget build(BuildContext context) {
    final url =
        context.read<VisionFeedCubit>().repository.getStreamUrl();

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        UIConst.paddingHorizontal,
        UIConst.paddingVertical,
        UIConst.paddingHorizontal,
        0,
      ),
      child: Container(
        width: double.infinity,
        height: 480.h,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Positioned.fill(
              child: MjpegViewer(url: url),
            ),

            BlocBuilder<VisionFeedCubit, VisionFeedState>(
              builder: (context, state) {
                if (!state.isLoading) return const SizedBox();
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}