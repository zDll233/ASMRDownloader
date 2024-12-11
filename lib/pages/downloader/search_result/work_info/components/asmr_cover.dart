import 'package:asmr_downloader/services/download/download_providers.dart';
import 'package:asmr_downloader/services/ui/ui_providers.dart';
import 'package:asmr_downloader/utils/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';

class AsmrCover extends ConsumerWidget {
  const AsmrCover({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coverLoadingState = ref.watch(coverLoadingStateProvider);
    return coverLoadingState.when(
      data: (bytes) {
        if (bytes == null) {
          return const Icon(Icons.error, color: Colors.red);
        }
        return FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: MemoryImage(bytes));
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stack) {
        Log.error('Load cover image failed\n'
            'sourceId: ${ref.read(sourceIdProvider)}\n'
            'error: ');
        return const Icon(Icons.error, color: Colors.red);
      },
    );
  }
}
