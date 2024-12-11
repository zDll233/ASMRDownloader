import 'package:asmr_downloader/pages/downloader/config_settings/components/asmr_api_channel.dart';
import 'package:asmr_downloader/pages/downloader/config_settings/components/asmr_proxy.dart';
import 'package:asmr_downloader/pages/downloader/config_settings/components/dl_cover_check.dart';
import 'package:asmr_downloader/pages/downloader/config_settings/components/dl_path_picker.dart';
import 'package:flutter/widgets.dart';

class ConfigSettings extends StatelessWidget {
  const ConfigSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DownloadPathPicker(),
        DlCoverCheck(),
        AsmrProxy(),
        AsmrApiChannel(),
      ],
    );
  }
}