import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    super.key,
    required this.image,
    this.fit = BoxFit.fill,
    this.isNetwork = true,
    this.radius = 50,
    required this.borderRadius,
    required this.height,
    required this.width,
  });
  final String image;
  final double height, width;
  final bool isNetwork;
  final double radius;
  final BorderRadiusGeometry borderRadius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return isNetwork
        ? SizedBox(
            height: height,
            width: width,
            child: CachedNetworkImage(
              imageUrl: image,
              placeholder: (context, url) => const BlankImageWidget(),
              errorWidget: (context, url, error) => const BlankImageWidget(),
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: borderRadius ?? BorderRadius.circular(radius),
                  image: DecorationImage(image: imageProvider, fit: fit),
                ),
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(
                borderRadius: borderRadius,
                image: DecorationImage(
                    image: AssetImage(image), fit: BoxFit.fill)),
          );
  }
}

class BlankImageWidget extends StatefulWidget {
  const BlankImageWidget({Key? key}) : super(key: key);

  @override
  _BlankImageWidgetState createState() => _BlankImageWidgetState();
}

class _BlankImageWidgetState extends State<BlankImageWidget> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(0),
      child: Center(
          child: SizedBox(
        child: Card(
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          elevation: 0.0,
        ),
      )),
    );
  }
}
