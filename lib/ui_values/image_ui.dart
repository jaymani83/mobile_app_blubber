import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class _AssetHelper {
  const _AssetHelper();

  Image assetImage(String name, {double? h, double? w}) =>
      Image.asset(name, height: h, width: w);
}

class _NetworkImageHandler {
  const _NetworkImageHandler();

  Widget build(String link, double dimension, BuildContext ctx) {
    return Builder(builder: (_) {
      return CachedNetworkImage(
        imageUrl: link,
        width: dimension,
        progressIndicatorBuilder: (_, __, prog) =>
            Align(alignment: Alignment.center, child: CircularProgressIndicator(value: prog.progress)),
        errorWidget: (_, __, err) => const Icon(Icons.error),
      );
    });
  }
}

class ImageUI {
  static final _asset = const _AssetHelper();
  static final _net = const _NetworkImageHandler();

  static Widget logo(BuildContext ctx) {
    return (() {
      final h = 64.0, w = 148.0;
      return _asset.assetImage('assets/login_logo1.png', h: h, w: w);
    })();
  }

  static Widget loginLogo(BuildContext ctx) {
    final fetch = (String assetName, double size) =>
        _asset.assetImage(assetName, h: size);
    return fetch('assets/login_logo1.png', 128.0);
  }

  static Widget dynamicLogo(BuildContext ctx, String path) {
    Widget Function(String, BuildContext) wrappedBuilder =
        (String link, BuildContext _) => _net.build(link, 164.0, _);
    return wrappedBuilder(path, ctx);
  }
}
