import "package:flutter/material.dart";
import 'package:psr_base/controllers/steps_controller.dart';
import 'package:psr_base/models/local_models.dart';
import 'package:psr_base/ui_related/builders/safe_state.dart';
import 'package:psr_base/ui_related/builders/should_rebuild.dart';
import 'package:psr_base/ui_related/builders/steps_builder.dart';
import 'package:psr_base/ui_related/space_between.dart';
import 'package:psr_base/utils/operations_related/handle_nullable.dart';

class ListsGenerate extends StatefulWidget {
  final List<SingleSelectionModel> items;
  final String title;
  final Widget Function(BuildContext, bool)? itemBuilder;

  const ListsGenerate({
    Key? key,
    this.items = const [],
    this.title = "",
    this.itemBuilder,
  }) : super(key: key);

  @override
  ListsGenerateState createState() => ListsGenerateState();
}

class ListsGenerateState extends SafeState<ListsGenerate> {
  final controller = StepsController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 3,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          intermediate(10),
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF4C4D52),
            ),
          ),
          intermediate(15),
          ShouldRebuild<StepsBuilder>(
            onInit: () {},
            shouldRebuild: (oldWidget, newWidget) {
              return oldWidget.items != newWidget.items;
            },
            child: StepsBuilder<SingleSelectionModel>(
              key: UniqueKey(),
              controller: controller,
              items: widget.items,
              prePage: 10,
              separatorBuilder: (context, index) {
                return const SizedBox();
              },
              builder: (element, index) {
                return Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: InkWell(
                    onTap: () => Navigator.pop(context, element.code),
                    borderRadius: BorderRadius.circular(5),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                element.label,
                                style: const TextStyle(
                                  color: Color(0xFF4A6572),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            if (element.icon.isNotNull) ...[
                              Icon(
                                element.icon,
                                color: const Color(0xFF4A6572),
                                size: 22,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
