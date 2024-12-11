import 'package:asmr_downloader/pages/downloader/config_settings/config_settings.dart';
import 'package:asmr_downloader/pages/downloader/search_box/search_box.dart';
import 'package:asmr_downloader/pages/downloader/search_result/search_result.dart';
import 'package:flutter/material.dart';

class Downloader extends StatelessWidget {
  const Downloader({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SearchBox(),
              ConfigSettings(),
            ],
          ),
          SizedBox(height: 20),
          SearchResult(),
        ],
      ),
    );
  }
}
