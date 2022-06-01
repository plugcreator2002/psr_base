import 'package:flutter/material.dart';
import 'package:psr_base/common/font_models.dart';

class PaginationBuilder extends StatefulWidget {
  final Color? backgroundColor;
  final bool loading;
  final bool pagination;
  final bool isNon;
  final List<Widget> items;
  final bool morePaging;
  final double? initialScrollOffset;
  final bool reverse;
  final void Function(ScrollUpdateNotification notification)? onNotification;
  final void Function(ScrollController? controller)? callback;
  const PaginationBuilder({
    Key? key,
    this.backgroundColor,
    this.callback,
    this.loading = false,
    this.pagination = true,
    this.isNon = false,
    this.items = const <Widget>[],
    this.morePaging = false,
    this.onNotification,
    this.initialScrollOffset,
    this.reverse = false,
  }) : super(key: key);

  @override
  State<PaginationBuilder> createState() => _PaginationBuilderState();
}

class _PaginationBuilderState extends State<PaginationBuilder> {
  bool _extended = false;
  final _controller = ScrollController();

  _scrollListener() {
    if (widget.pagination) {
      if (_controller.position.extentAfter <= 0 && !_extended) {
        if (widget.callback != null) (widget.callback ?? (_) {})(_controller);
        _extended = true;
      } else if (_extended && _controller.position.extentAfter > 0) {
        _extended = false;
      }
    } else {}
  }

  @override
  void initState() {
    super.initState();

    _controller.addListener(_scrollListener);
  }

  @override
  void didUpdateWidget(covariant PaginationBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isNon && _controller.positions.isNotEmpty) {
      if (_controller.position.extentBefore > 0) {
        _controller.animateTo(
          0,
          duration: const Duration(seconds: 1),
          curve: Curves.easeOutQuart,
        );
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(_scrollListener);
    _controller.dispose();
  }

  Widget? get _morePaging {
    if (widget.morePaging) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: SizedBox(
          width: 20,
          height: 20,
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Color(0xFF4C4D52),
            ),
          ),
        ),
      );
    }

    if (!widget.morePaging) return const SizedBox();
    return null;
  }

  Widget? get _isNon {
    if (widget.loading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF00809A),
        ),
      );
    }
    if (widget.isNon) {
      return Padding(
        padding: const EdgeInsets.only(top: 220),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/emoji.png",
                width: 100,
              ),
              const SizedBox(height: 8),
              const Text(
                "متاسفانه چیزی یافت نشد",
                style: TextStyle(
                  color: Color(0xFF4C4D52),
                  fontSize: 15,
                  fontFamily: FontModels.yekan,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView(
        controller: _controller,
        reverse: widget.reverse,
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        children: [
          _isNon ?? Column(children: widget.items),
          _morePaging ?? const SizedBox(),
        ],
      ),
    );
  }
}
