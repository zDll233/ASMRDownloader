import 'package:asmr_downloader/models/track_item.dart';
import 'package:asmr_downloader/pages/downloader/search_result/tracks_view/components/middle_ellipsis_text.dart';
import 'package:asmr_downloader/services/download/download_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DownloadProgress extends StatelessWidget {
  const DownloadProgress({super.key, required this.tracksLPadding});
  final double tracksLPadding;

  @override
  Widget build(BuildContext context) {
    final appWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: tracksLPadding, bottom: 10.0),
      child: Row(
        children: [
          _downloadButton(),
          SizedBox(width: appWidth * 0.01),
          _progressBar(appWidth),
          SizedBox(width: appWidth * 0.01),
          _progressPercentage(),
          Spacer(),
          _totalDlCount(appWidth),
        ],
      ),
    );
  }

  Widget _downloadButton() {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final downloading =
            ref.watch(dlStatusProvider) == DownloadStatus.downloading;
        return TextButton(
          style: TextButton.styleFrom(backgroundColor: Colors.pink[200]),
          onPressed: downloading ? null : ref.read(downloadManagerProvider).run,
          child: Text(downloading ? '下载中' : '下载',
              style: TextStyle(color: Colors.white70)),
        );
      },
    );
  }

  Widget _progressBar(double appWidth) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final process = ref.watch(processProvider);
        final currentFileName = ref.watch(currentFileNameProvider);
        return SizedBox(
          width: appWidth * 0.35,
          child: Stack(children: [
            LinearProgressIndicator(
              minHeight: 30,
              borderRadius: BorderRadius.circular(10),
              value: process,
            ),
            Positioned(
                top: 3.5,
                left: 5,
                child: SizedBox(
                  width: appWidth * 0.34,
                  child: Row(children: ellipsisInMiddle(currentFileName)),
                )),
          ]),
        );
      },
    );
  }

  Widget _progressPercentage() {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final process = ref.watch(processProvider);
        return Center(child: Text('${(process * 100).toStringAsFixed(2)}%'));
      },
    );
  }

  Widget _totalDlCount(double appWidth) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final currentDl = ref.watch(currentDlNoProvider);
        final total = ref.watch(totalTaskCntProvider);
        return SizedBox(
          width: appWidth * 0.07,
          child: Center(child: Text('$currentDl / $total')),
        );
      },
    );
  }
}
