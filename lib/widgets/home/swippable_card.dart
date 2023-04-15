import 'dart:developer' as d;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/presentation/blocs/swipe_controller/swipe_bloc.dart';

class SwipableCard extends StatefulWidget {
  const SwipableCard(
      {Key? key,
      required this.onLiked,
      required this.color,
      required this.onPanUpdated,
      required this.onSwipeEnded,
      required this.onDisLike,
      required this.child,
      required this.swipeController})
      : super(key: key);
  final VoidCallback onLiked;
  final VoidCallback onDisLike;
  final Color color;
  final Widget child;
  final SwipeController swipeController;
  final Function(DragUpdateDetails details) onPanUpdated;
  final Function() onSwipeEnded;

  @override
  State<SwipableCard> createState() => _SwipableCardState();
}

class _SwipableCardState extends State<SwipableCard>
    with SingleTickerProviderStateMixin {
  Offset position = Offset.zero;
  Offset dislikeOffset = const Offset(-1, 0);
  bool isDragging = false;
  double angle = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SwipeController, SwipeState>(
      bloc: widget.swipeController,
      listener: (context, state) {
        if (state is SwipedState) {
          if (state.swipeState == SwipeStates.liked) {
            like();
          }
          if (state.swipeState == SwipeStates.disliked) {
            dislike();
          }
        }
      },
      child: GestureDetector(
        onPanStart: (details) {},
        onPanUpdate: (details) {
          setState(() {
            isDragging = true;
            position += details.delta;
            updateAngle();
          });

          widget.onPanUpdated(details);
        },
        onPanEnd: (details) async {
          if (position.dx >= 95) {
            like();
          } else if (position.dx <= -95) {

            dislike();
          } else {
            reset(details);
          }
        },
        child: LayoutBuilder(builder: (context, constraints) {
          final center = constraints.biggest.bottomCenter(Offset.zero);
          angle = angle * pi / 180;
          final rotatedMatrix = Matrix4.identity()
            ..translate(center.dx, center.dy)
            ..rotateZ(angle)
            ..translate(-center.dx, -center.dy);
          return AnimatedContainer(
            duration: Duration(milliseconds: isDragging ? 0 : 800),
            transform: rotatedMatrix..translate(position.dx, 0),
            child: Container(
              width: deviceWidth(),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
              child: widget.child,
            ),
          );
        }),
      ),
    );
  }

  void updateAngle() {
    setState(() {
      final x = position.dx;
      angle = 45 * x / MediaQuery.of(context).size.width;
    });
  }

  void reset(DragEndDetails details) {
    widget.onSwipeEnded();
    setState(() {
      isDragging = false;
      position = Offset.zero;
      angle = 0;
    });
  }

  Future<void> dislike() async {
    d.log('disliked');
    isDragging = false;
    angle = -80;
    position = Offset(-(getDeviceSize().width / 2), -20);
    widget.onSwipeEnded();
    await Future.delayed(const Duration(milliseconds: 300));
    widget.onDisLike();
  }

  Future<void> like() async {
    d.log('liked');
    isDragging = false;
    angle = 100;
    position = Offset((getDeviceSize().width / 2), 0);
    widget.onSwipeEnded();
    await Future.delayed(const Duration(milliseconds: 300));
    widget.onLiked();
  }
}
