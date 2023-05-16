// ignore_for_file: sort_child_properties_last, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  ShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return buildShimmer();
        });
  }
}

Widget buildShimmer() => const Card(
      elevation: 4,
      child: ListTile(
        title: ShimmerWidget.rectangular(
          height: 16,
          width: 30,
        ),
        subtitle: ShimmerWidget.rectangular(
          height: 14,
          width: 200,
        ),
      ),
    );

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangular(
      {super.key, required this.width, required this.height})
      : shapeBorder = const RoundedRectangleBorder();

  const ShimmerWidget.circular(
      {super.key,
      required this.width,
      required this.height,
      this.shapeBorder = const CircleBorder()});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
      child: Container(
        width: width,
        height: height,
        decoration:
            ShapeDecoration(color: Colors.grey[400]!, shape: shapeBorder),
      ),
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[300]!);
}
