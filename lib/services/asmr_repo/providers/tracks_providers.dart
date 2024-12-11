import 'package:asmr_downloader/services/download/download_providers.dart';
import 'package:asmr_downloader/services/asmr_repo/providers/api_providers.dart';
import 'package:asmr_downloader/utils/log.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final rawTracksProvider = FutureProvider<List<dynamic>?>((ref) async {
  final api = ref.watch(asmrApiProvider);

  final id = ref.watch(idProvider);
  if (id == null) {
    return null;
  }

  Log.info('Fetch tracks. id: $id');
  return api.getTracks(id);
});
