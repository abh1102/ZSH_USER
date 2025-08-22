import 'package:flutter/material.dart';

class CircularCustomImageWidget extends StatelessWidget {
  final String url;
  final double? mywidth;
  final double? myheight;
  const CircularCustomImageWidget({
    super.key,
    required this.url,
    this.mywidth,
    this.myheight,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        url,
        width: mywidth,
        height: myheight,
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return ClipOval(
                child: SizedBox(
                    width: mywidth,
                    height: myheight,
                    child: const Center(
                        child: CircularProgressIndicator.adaptive())));
          }
        },
        errorBuilder:
            (BuildContext context, Object error, StackTrace? stackTrace) {
          return ClipOval(
            child: SizedBox(
              width: mywidth,
              height: myheight,
              child: const Icon(Icons.error),
            ),
          ); // or any other widget you want to display for error
        },
      ),
    );
  }
}

class CustomImageWidget extends StatelessWidget {
  final String url;
  final bool? isContain;
  final double mywidth;
  final double myheight;
  final double myradius;
  const CustomImageWidget({
    super.key,
    required this.url,
    required this.mywidth,
    required this.myheight,
    required this.myradius,
    this.isContain,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(myradius),
      child: Image.network(
        url,
        width: mywidth,
        height: myheight,
        fit: isContain ?? false ? BoxFit.contain : BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return ClipRRect(
              borderRadius: BorderRadius.circular(myradius),
              child: SizedBox(
                width: mywidth,
                height: myheight,
                child: const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
            );
          }
        },
        errorBuilder:
            (BuildContext context, Object error, StackTrace? stackTrace) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(myradius),
            child: SizedBox(
              width: mywidth,
              height: myheight,
              child: const Icon(Icons.error),
            ),
          ); // or any other widget you want to display for error
        },
      ),
    );
  }
}
