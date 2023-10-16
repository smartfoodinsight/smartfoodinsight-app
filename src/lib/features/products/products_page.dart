import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:smartfoodinsight_app/common/utils/utis.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductsPage extends ConsumerWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: const Padding(
            padding: EdgeInsets.all(16), child: Text('Productos')),
        floatingActionButton: ElevatedButton(
          onPressed: () => context.push(AppSettings.scan),
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: HexColor("#aac6f9"),
            padding: const EdgeInsets.all(15),
          ),
          child: SvgPicture.asset(
            'assets/images/sb.svg',
            width: 32.0,
            height: 32.0,
            colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
        ));
  }
}
