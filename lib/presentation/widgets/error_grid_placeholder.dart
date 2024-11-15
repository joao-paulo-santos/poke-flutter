import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ErrorGridPlaceholder extends StatelessWidget {
  const ErrorGridPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CachedNetworkImage(
      imageUrl:
          "https://imgix.ranker.com/user_node_img/50073/1001454025/original/1001454025-photo-u1?auto=format&q=60&fit=crop&fm=pjpg&dpr=2&w=500",
      fit: BoxFit.cover,
      errorWidget: (context, url, error) {
        return const Text("Image not found");
      },
    ));
  }
}
