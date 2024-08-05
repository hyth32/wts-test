import 'package:flutter/material.dart';
import 'package:wts_test/abstract/base_page.dart';

abstract class BaseListviewPage extends BasePage {
  final bool shouldBeRefreshable;
  final bool shouldBeSeparated;
  final ScrollController? scrollController;

  const BaseListviewPage({
    super.key,
    super.title,
    this.shouldBeRefreshable = false,
    this.shouldBeSeparated = false,
    this.scrollController,
  });
}

abstract class BaseListviewPageState<T extends BaseListviewPage>
    extends BasePageState<T> {
  @override
  Widget buildBody(BuildContext context) {
    var listViewBody = buildListViewBody(context);
    if (widget.shouldBeRefreshable) {
      return RefreshIndicator(
        child: listViewBody,
        onRefresh: handleRefresh,
      );
    }
    return listViewBody;
  }

  @protected
  Widget buildListViewBody(BuildContext context) {
    if (shouldBeSeparated) {
      return ListView.separated(
          controller: widget.scrollController,
          padding: const EdgeInsets.all(16),
          separatorBuilder: buildSeparator,
          itemCount: itemCount + 1,
          itemBuilder: (context, index) {
            if (index >= itemCount) {
              return const Center(child: CircularProgressIndicator());
            }
            return buildListItem(context, index);
          });
    }
    return ListView.builder(
      controller: widget.scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: itemCount + 1,
      itemBuilder: (context, index) {
        if (index >= itemCount) {
          return const Center(child: CircularProgressIndicator());
        }
        return buildListItem(context, index);
      },
    );
  }

  @protected
  Widget buildListItem(BuildContext context, int index);

  @protected
  Future<void> handleRefresh();

  @protected
  Widget buildSeparator(BuildContext context, int index) {
    return const SizedBox(height: 16);
  }

  @protected
  int get itemCount;

  @protected
  bool get shouldBeRefreshable => widget.shouldBeRefreshable;

  @protected
  bool get shouldBeSeparated => widget.shouldBeSeparated;
}
