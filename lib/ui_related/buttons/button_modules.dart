import "package:flutter/material.dart";

class ButtonModules extends StatefulWidget {
  final IconData? icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  final Future<bool>? future;
  final double? fontSize;
  final double? height;
  const ButtonModules({
    Key? key,
    this.icon,
    required this.label,
    this.color = Colors.white,
    required this.onTap,
    this.future,
    this.fontSize,
    this.height,
  }) : super(key: key);

  @override
  State<ButtonModules> createState() => _ButtonModulesState();
}

class _ButtonModulesState extends State<ButtonModules> {
  Widget? get _icon {
    if (widget.icon != null) {
      return Icon(
        widget.icon,
        size: 22,
        color: Colors.white,
      );
    }
    return null;
  }

  Widget? _loading(bool isLoading) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.only(left: 8),
        child: SizedBox(
          width: 11,
          height: 11,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        ),
      );
    }
    return null;
  }

  Color? _splashColor(final bool data) {
    if (data == true) return Colors.transparent;
    return null;
  }

  void _onPressed(final bool data) {
    if (data != true) {
      widget.onTap();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: widget.future,
      builder: (context, snapshot) {
        return FlatButton(
          color: widget.color,
          height: widget.height ?? 50,
          onPressed: () => _onPressed(snapshot.data ?? false),
          splashColor: _splashColor(snapshot.data ?? false),
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 4,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          child: Row(
            children: [
              _icon,
              Expanded(
                child: Text(
                  widget.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: widget.fontSize ?? 15,
                    color: Colors.white,
                  ),
                ),
              ),
              _loading(snapshot.data ?? false),
            ].whereType<Widget>().toList(),
          ),
        );
      },
    );
  }
}
