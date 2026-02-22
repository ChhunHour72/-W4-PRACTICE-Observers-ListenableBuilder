import 'package:flutter/material.dart';
 
import 'download_controler.dart';

class DownloadTile extends StatelessWidget {
  const DownloadTile({super.key, required this.controller});

  final DownloadController controller;
 
 // TODO

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        Widget trailingIcon = const SizedBox(); 
        String subtitleText = '';

        if (controller.status == DownloadStatus.notDownloaded) {
          trailingIcon = IconButton(
            icon: const Icon(Icons.download),
            onPressed: controller.startDownload, 
          );
        } else if (controller.status == DownloadStatus.downloading) {
          trailingIcon = const Icon(Icons.downloading);

          double percentage = controller.progress * 100;
          double currentSizeMb = controller.progress * controller.ressource.size;
          
          subtitleText = '${percentage.toStringAsFixed(1)} % completed - ${currentSizeMb.toStringAsFixed(1)} of ${controller.ressource.size} MB';

        } else if (controller.status == DownloadStatus.downloaded) {
          trailingIcon = const Icon(Icons.folder);
          subtitleText = '100.0 % completed - ${controller.ressource.size.toDouble()} of ${controller.ressource.size} MB';
        }

        return Card(
          child: ListTile(
            title: Text(controller.ressource.name),
            subtitle: subtitleText.isNotEmpty ? Text(subtitleText) : null,
            trailing: trailingIcon,
          ),
        );
      },
    );
     
    // TODO
  }
}
