import 'package:flutter/material.dart';
import 'package:wts_test/abstract/base_network_image.dart';
import 'package:wts_test/widgets/no_image.dart';
import 'package:wts_test/widgets/text_decoration.dart';

abstract class BaseTile extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final bool? shouldBeScrollable;
  final int? price;

  const BaseTile({
    required this.title,
    this.imageUrl,
    this.price,
    this.shouldBeScrollable = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var body = buildBody(context);
    var bodyWithBasicInfo = buildBasicInfo(context, body);
    var tile = shouldBeScrollable!
        ? buildSingleScrollChildView(context, bodyWithBasicInfo)
        : buildDecoratedBox(context, bodyWithBasicInfo);
    return tile;
  }

  @protected
  List<Widget> buildBasicInfo(BuildContext context, Widget body) {
    return [
      buildTileImage(imageUrl),
      buildTileTitle(context, title),
      buildTilePrice(context, price ?? 0),
      body,
    ];
  }

  @protected
  Widget buildDecoratedBox(BuildContext context, List<Widget> body) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(16),
      ),
      child: buildPadding(
          context,
          buildColumn(
            context,
            body,
          )),
    );
  }

  @protected
  Widget buildSingleScrollChildView(BuildContext context, List<Widget> body) {
    return SingleChildScrollView(
      child: buildPadding(
        context,
        buildColumn(context, body),
      ),
    );
  }

  @protected
  Widget buildPadding(BuildContext context, Widget body) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: body,
    );
  }

  Widget buildBody(BuildContext context);

  @protected
  Widget buildColumn(BuildContext context, List<Widget> body) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: body,
    );
  }

  @protected
  Widget buildTileTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }

  @protected
  Widget buildTilePrice(BuildContext context, int price) {
    return Text(
      price == 0 ? 'Цена не указана' : '$price ₽',
      style: Theme.of(context).textTheme.labelMedium,
    );
  }

  @protected
  Widget buildTileImage(String? imageUrl) {
    if (imageUrl == null) {
      return const NoImageWidget();
    }
    return BaseNetworkImage(imageUrl: imageUrl);
  }

  @protected
  Widget buildDecoratedText(String text) {
    return TextDecorationWidget(
      text: text,
      verticalInset: 6,
    );
  }
}
