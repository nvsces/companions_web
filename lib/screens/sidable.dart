import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

enum SlidableAction { edit, delete }

class SlidableWidget<T> extends StatelessWidget {
  final Widget child;
  final Function(SlidableAction action) onDismissed;

  const SlidableWidget({
    @required this.child,
    @required this.onDismissed,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Slidable(
        actionPane: SlidableDrawerActionPane(),
        child: child,
        actions: <Widget>[
          IconSlideAction(
            caption: 'Редактировать',
            color: Colors.cyan,
            icon: Icons.edit,
            onTap: () => onDismissed(SlidableAction.edit),
          ),
        ],

        /// right side
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Удалить',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => onDismissed(SlidableAction.delete),
          ),
        ],
      );
}
