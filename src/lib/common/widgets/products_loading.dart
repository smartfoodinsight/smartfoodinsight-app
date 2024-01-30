import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductsLoading extends StatelessWidget {
  const ProductsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)));
            },
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemCount: 10),
      ),
    );
  }
}
