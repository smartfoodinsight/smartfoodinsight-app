import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:smartfoodinsight_app/common/extensions/app_localizations_extension.dart';
import 'package:smartfoodinsight_app/common/utils/utis.dart';
import 'package:smartfoodinsight_app/features/products/products_details_page_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailsPage extends ConsumerWidget {
  final String ean;
  const ProductDetailsPage({required this.ean, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(productInfoProvider(ean));

    return productAsync.when(
        data: (product) => Scaffold(
              body: CustomScrollView(
                physics: const ClampingScrollPhysics(),
                slivers: [
                  _CustomSliverAppBar(product: product),
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                    childCount: 1,
                    (context, index) => _ProductDetails(product: product),
                  ))
                ],
              ),
            ),
        error: (error, stackTrace) => const Text('error'),
        loading: () => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ));
  }
}

class _ProductDetails extends StatelessWidget {
  final Product product;

  const _ProductDetails({required this.product});

  @override
  Widget build(BuildContext context) {
    double imageHeight = 65;

    String kCal = formatNutrient(
        product.nutriments
            ?.getValue(Nutrient.energyKCal, PerSize.oneHundredGrams),
        'kcal');

    String fats = formatNutrient(
        product.nutriments?.getValue(Nutrient.fat, PerSize.oneHundredGrams),
        'g');

    String saturatedFats = formatNutrient(
        product.nutriments
            ?.getValue(Nutrient.saturatedFat, PerSize.oneHundredGrams),
        'g');

    String carbohydrates = formatNutrient(
        product.nutriments
            ?.getValue(Nutrient.carbohydrates, PerSize.oneHundredGrams),
        'g');

    String sugars = formatNutrient(
        product.nutriments?.getValue(Nutrient.sugars, PerSize.oneHundredGrams),
        'g');

    String fiber = formatNutrient(
        product.nutriments?.getValue(Nutrient.fiber, PerSize.oneHundredGrams),
        'g');

    String proteins = formatNutrient(
        product.nutriments
            ?.getValue(Nutrient.proteins, PerSize.oneHundredGrams),
        'g');

    String salt = formatNutrient(
        product.nutriments?.getValue(Nutrient.salt, PerSize.oneHundredGrams),
        'g');

    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Text(context.loc.nutriInfo),
            const Spacer(),
            Text('${context.loc.per} ${product.nutrimentDataPer!}')
          ]),
          _CustomIconTitle(
              iconData: FontAwesomeIcons.fire,
              firstText: context.loc.calories,
              secondText: kCal),
          _CustomIconTitle(
              iconData: Icons.fastfood,
              firstText: context.loc.fats,
              secondText: fats),
          _CustomIconTitle(
              iconData: FontAwesomeIcons.bacon,
              firstText: context.loc.saturatedFats,
              secondText: saturatedFats),
          _CustomIconTitle(
              iconData: FontAwesomeIcons.breadSlice,
              firstText: context.loc.carbohydrates,
              secondText: carbohydrates),
          _CustomIconTitle(
              iconData: FontAwesomeIcons.candyCane,
              firstText: context.loc.sugars,
              secondText: sugars),
          _CustomIconTitle(
              iconData: FontAwesomeIcons.wheatAwn,
              firstText: context.loc.fiber,
              secondText: fiber),
          _CustomIconTitle(
              iconData: FontAwesomeIcons.drumstickBite,
              firstText: context.loc.proteins,
              secondText: proteins),
          _CustomIconTitle(
              iconData: FontAwesomeIcons.cookie,
              firstText: context.loc.salt,
              secondText: salt),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.asset(
                  'assets/images/nutriscore-${product.nutriscore ?? 'unknown'}.png',
                  height: imageHeight,
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Image.asset(
                  'assets/images/nova-group-${product.novaGroup ?? 'unknown'}.png',
                  height: imageHeight,
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: SvgPicture.asset(
                    'assets/images/ecoscore-${product.ecoscoreGrade ?? 'unknown'}.svg',
                    height: imageHeight),
              )
            ],
          ),
          const SizedBox(height: 20),
          Text(context.loc.openFoodFactsInfo),
          GestureDetector(
              onTap: () async {
                Uri uri = Uri.parse(AppSettings.openFoodFacts);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              },
              child: const Text(AppSettings.openFoodFacts,
                  style: TextStyle(decoration: TextDecoration.underline))),
        ]));
  }
}

class _CustomIconTitle extends StatelessWidget {
  final String firstText;
  final String secondText;
  final IconData iconData;

  const _CustomIconTitle(
      {required this.firstText,
      required this.iconData,
      required this.secondText});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(firstText),
        leading: Icon(iconData, color: Colors.grey, size: 30),
        trailing: Text(secondText));
  }
}

class _CustomSliverAppBar extends ConsumerWidget {
  final Product product;

  const _CustomSliverAppBar({required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);

    return SliverAppBar(
      actions: [
        IconButton(
            onPressed: () async => {}, icon: const Icon(Icons.favorite_border))
      ],
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.5,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text('${product.productName} ${product.quantity}'),
        background: Stack(children: [
          SizedBox.expand(
              child: product.imageFrontUrl != null
                  ? Image.network(product.imageFrontUrl!, fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress != null) return const SizedBox();
                      return FadeInRight(child: child);
                    })
                  : Image.asset('images/imagenotavailable.png',
                      fit: BoxFit.cover)),
          const _CustomGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.0, 0.2],
            colors: [Colors.black54, Colors.transparent],
          ),
          const _CustomGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.7, 1.0],
            colors: [Colors.transparent, Colors.black87],
          ),
          const _CustomGradient(
            begin: Alignment.topLeft,
            stops: [0.0, 0.4],
            colors: [Colors.black87, Colors.transparent],
          ),
        ]),
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  const _CustomGradient(
      {this.begin = Alignment.centerLeft,
      this.end = Alignment.centerRight,
      required this.stops,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: DecoratedBox(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: begin, end: end, stops: stops, colors: colors)),
    ));
  }
}

String formatNutrient(double? value, String unit) {
  if (value != null) {
    String formattedValue =
        value % 1 == 0 ? value.toInt().toString() : value.toString();
    return '$formattedValue $unit';
  } else {
    return '?';
  }
}
