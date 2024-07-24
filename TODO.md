По базовому классу для всех экранов
Сделать что-то вроде

```dart
abstract class BasePage extends StatefulWidget {
  final String? title;

  BasePage({
    super.key,
    this.title,
  });
}


/// Базовый экран для всех экранов приложения.
///
/// * Создает [Scaffold] для экрана - [buildScaffold]
/// * Создает и настраивает [AppBar] - [buildAppBar]
abstract class BasePageState<T extends BasePage> extends State<T> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  /// Выключить, чтобы не оборачивать экран в [Scaffold]
  bool shouldBuildScaffold = true;

  /// Включить, чтобы обернуть экран в [SafeArea]
  bool isSafeAreaEnabled = false;

  bool shouldDecorateToAbsorbPointer = false;

  bool resizeToAvoidBottomInset = true;
  StackFit decorateBodyStackFit = StackFit.expand;

  late bool canPop = ModalRoute
      .of(context)
      ?.canPop ?? false;

  @override
  Widget build(BuildContext context) {
    var body = buildBody(context);
    body = decorateBody(context, body);
    if (isSafeAreaEnabled) {
      body = SafeArea(
        child: body,
      );
    }
    var scaffold = buildScaffold(context, body);
    scaffold = decorateScaffold(context, scaffold);
    return decorateKeyboardUnfocusing(context, scaffold);
  }

  @protected
  Widget buildScaffold(BuildContext context, Widget body) {
    if (!shouldBuildScaffold) {
      return body;
    }
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ThemeBuilder.systemUiOverlayStyle,
      child: Scaffold(
        appBar: buildAppBar(context),
        key: scaffoldKey,
        body: body,
        floatingActionButton: buildFloatingActionButton(context),
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      ),
    );
  }

  @protected
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      toolbarHeight: 64,
      title: buildAppBarTitle(context),
      leading: buildAppBarLeading(context),
      actions: buildAppBarActions(context),
      bottom: buildAppBarBottom(context),
    );
  }

  @protected
  Widget? buildAppBarTitle(BuildContext context) {
    if (widget.title == null) {
      return null;
    }
    return AutoSizeText(
      widget.title ?? '',
      maxLines: 2,
      minFontSize: 16,
      style: AppTextStyle.title.copyWith(
        fontSize: 16,
      ),
      textAlign: TextAlign.center,
    );
  }

  @protected
  Widget decorateKeyboardUnfocusing(BuildContext context, Widget child) {
    return GestureDetector(
      onTap: FocusScope
          .of(context)
          .unfocus,
      child: child,
    );
  }

  @protected
  Widget buildBaseError({required Function onPressedButton}) {
    return BaseErrorWidget(
      onPressedButton: onPressedButton,
    );
  }

  @protected
  Widget decorateScaffold(BuildContext context, Widget scaffold) {
    return AbsorbPointer(
      absorbing: shouldDecorateToAbsorbPointer,
      child: scaffold,
    );
  }

  /// Переопределите для построения тела экрана приложения.
  Widget buildBody(BuildContext context);

  @protected
  Widget? buildFloatingActionButton(BuildContext context) {
    return null;
  }

  @protected
  PreferredSizeWidget? buildAppBarBottom(BuildContext context) {
    return null;
  }

  @protected
  List<Widget>? buildAppBarActions(BuildContext context) {
    return null;
  }

  @protected
  Widget? buildAppBarLeading(BuildContext context) {
    return canPop ? const CustomBackButton() : null;
  }

  void showMessage({String? message}) {
    if (message == null) {
      appModel.logger.w("Empty message to display in snackbar");
      return;
    }
    BotToast.showText(
      text: message,
    );
  }
}
```

Базовый стейт для список BaseListViewPageState в него можно вынести пагинацию

```dart
          return ListView.separated(
            controller: _scrollController,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            padding: const EdgeInsets.all(16),
            itemCount: state.data.length,
            itemBuilder: (context, index) {
              if (index >= state.data.length) {
                return const Center(child: CircularProgressIndicator());
              }
              // TODO: Добавить состояние ошибки
              return buildListItem(context, index);
            },
          );
```

На самом экране оставить только 


```dart
  @override
  Widget buildListItem(BuildContext context, int index) {
    var post = _productListBloc.loadedData[index];
    return NewsListItem(post);
  }
```