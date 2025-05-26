import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CachedNetworkImageExample extends StatefulWidget {
  const CachedNetworkImageExample({super.key});

  @override
  State<CachedNetworkImageExample> createState() => _CachedNetworkImageState();
}

class _CachedNetworkImageState extends State<CachedNetworkImageExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: CachedNetworkImage(
          imageUrl: "https://images.unsplash.com/photo-1662070479020-73f77887c87c?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZmFjZWJvb2slMjBsb2dvfGVufDB8fDB8fHww",
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
