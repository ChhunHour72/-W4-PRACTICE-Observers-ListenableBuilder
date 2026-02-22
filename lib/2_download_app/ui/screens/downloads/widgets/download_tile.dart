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

        if (controller.status == DownloadStatus.notDownloaded) {
          trailingIcon = IconButton(
            icon: const Icon(Icons.download),
            onPressed: controller.startDownload, 
          );
        } else if (controller.status == DownloadStatus.downloading) {
          trailingIcon = const Icon(Icons.downloading);
        } else if (controller.status == DownloadStatus.downloaded) {
          trailingIcon = const Icon(Icons.folder);
        }

        return Card(
          child: ListTile(
            title: Text(controller.ressource.name),
            trailing: trailingIcon,
          ),
        );
      },
    );
     
    // TODO
  }
}
