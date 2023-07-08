import 'dart:math' as math;

import 'package:code/constants/colors.dart';
import 'package:code/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    this.width,
    this.height,
    this.bgWidth,
    this.bgHeight,
    this.imageWidth,
    this.imageHeight,
    this.imageTop,
    this.imageLeft,
    this.borderRadius = 30,
    this.rotateDeg = 0,
    this.url,
    this.color,
    this.imageAlignment = Alignment.center,
    this.clipBehavior = Clip.antiAlias,
    this.isCircle = false,
    this.padding,
  });

  final double? width, height, bgWidth, bgHeight;
  final double? imageWidth, imageHeight, imageTop, imageLeft;
  final double borderRadius, rotateDeg;
  final String? url, color;
  final Alignment imageAlignment;
  final Clip clipBehavior;
  final bool isCircle;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        clipBehavior: clipBehavior,
        children: [
          // background
          Container(
            width: bgWidth ?? Dimens.getScreenWidth(context),
            height: bgHeight ?? Dimens.getScreenHeight(context),
            decoration: BoxDecoration(
              color: HexColor.fromHex(color ?? '#ffffff'),
              borderRadius: isCircle ? null : BorderRadius.circular(borderRadius),
              shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
            ),
          ),

          // image
          Positioned(
            top: imageTop,
            left: imageLeft,
            child: Container(
              padding: padding,
              alignment: imageAlignment,
              width: imageWidth,
              height: imageHeight,
              // color: Colors.red,
              child: Transform.rotate(
                angle: rotateDeg != 0 ? math.pi / rotateDeg : 0,
                child: SimpleShadow(
                  opacity: 0.3,
                  color: AppColors.black,
                  offset: const Offset(0, 30),
                  sigma: 20,
                  child: Image.network(
                    url ?? '',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
