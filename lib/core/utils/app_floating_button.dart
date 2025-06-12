import 'package:flutter/material.dart';

class AppFloatingButton extends StatefulWidget {
  final Color color;
  final Icon icon;
  final VoidCallback onPressed;

  const AppFloatingButton({
    super.key,
    required this.color,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<AppFloatingButton> createState() => _AppFloatingButtonState();
}

class _AppFloatingButtonState extends State<AppFloatingButton> {
  Offset? position;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenSize = MediaQuery.of(context).size;
      setState(() {
        position = Offset(
          screenSize.width - 70,
          screenSize.height - 200, // ✅ ارفعيه زيادة عن السابق
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (position == null) {
      return const SizedBox();
    }

    final mediaQuery = MediaQuery.of(context);
    final screenSize = mediaQuery.size;
    final topPadding = mediaQuery.padding.top;
    final bottomPadding = mediaQuery.padding.bottom;

    const appBarHeight = kToolbarHeight;
    const bottomNavBarHeight = 60.0;
    const snackBarHeight = 56.0;
    const snackBarSafePadding = 16.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Positioned(
              left: position!.dx,
              top: position!.dy,
              child: Draggable(
                feedback: _buildButton(opacity: 0.7),
                childWhenDragging: const SizedBox(),
                onDragEnd: (details) {
                  final renderBox = context.findRenderObject() as RenderBox;
                  final localOffset = renderBox.globalToLocal(details.offset);

                  double newX = localOffset.dx;
                  double newY = localOffset.dy;

                  if (newX < screenSize.width / 2) {
                    newX = 10;
                  } else {
                    newX = screenSize.width - 70;
                  }

                  final minY = topPadding + appBarHeight + 10;
                  final maxY = screenSize.height -
                      bottomNavBarHeight -
                      bottomPadding -
                      70 -
                      snackBarHeight -
                      snackBarSafePadding;

                  newY = newY.clamp(minY, maxY);

                  setState(() {
                    position = Offset(newX, newY);
                  });
                },
                child: _buildButton(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildButton({double opacity = 1.0}) {
    return Opacity(
      opacity: opacity,
      child: SizedBox(
        width: 56, // ✅ قللنا الحجم
        height: 56,
        child: FloatingActionButton(
          backgroundColor: widget.color,
          shape: const CircleBorder(),
          onPressed: widget.onPressed,
          child: widget.icon,
        ),
      ),
    );
  }
}
