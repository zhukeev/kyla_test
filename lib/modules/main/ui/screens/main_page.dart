import 'package:flutter/material.dart';
import 'package:kyla_test/modules/main/ui/widgets/animation_bottom.dart';
import 'package:kyla_test/modules/main/ui/widgets/bottom_nav_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DropAnimationController? _dropAnimationController;

  double get lowerLimitPerc => 0.4;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final lowerLimit = height * lowerLimitPerc;

    final textTheme = Theme.of(context).textTheme;
    final mentuStyle = textTheme.titleMedium?.copyWith(
      color: Colors.white,
    );

    return ValueListenableBuilder<double>(
        valueListenable: _dropAnimationController?.height ?? ValueNotifier<double>(16),
        builder: (context, height, _) {
          final reachedLimit = lowerLimit <= height;

          return Scaffold(
            appBar: AppBar(title: Text(widget.title)),
            body: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Events',
                        style: textTheme.headlineMedium?.copyWith(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: BottomNavBar(),
                ),
                SizedBox.fromSize(
                  size: size,
                  child: ColoredBox(
                    color: Color.lerp(Colors.transparent, Colors.blue, (height / lowerLimit)) ?? Colors.white,
                  ),
                ),
                Positioned(
                  bottom: lowerLimit - 56 * 4,
                  right: 0,
                  left: 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: reachedLimit ? 1 : 0,
                    child: Column(
                      children: [
                        Text(
                          'Reminder',
                          style: mentuStyle,
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'Camera',
                          style: mentuStyle,
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'Attachment',
                          style: mentuStyle,
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'Text Note',
                          style: mentuStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: BottomAnimation(
                    height: size.height,
                    limit: lowerLimit,
                    onDropAnimationController: (controller) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (mounted) {
                          setState(() {
                            _dropAnimationController = controller;
                          });
                        }
                      });
                    },
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: height.clamp(0, lowerLimit),
                  right: 0,
                  child: GestureDetector(
                    onVerticalDragUpdate: (details) {
                      _dropAnimationController?.height.value =
                          (size.height - details.globalPosition.dy).clamp(0, lowerLimit);
                    },
                    onVerticalDragEnd: (_) => _dropAnimationController?.onDropComplete(),
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 3),
                      child: FloatingActionButton(
                        onPressed: () => _dropAnimationController?.onReset(),
                        tooltip: 'Increment',
                        backgroundColor: reachedLimit ? Colors.white : Colors.blue,
                        child: reachedLimit
                            ? const Icon(
                                Icons.close,
                                color: Colors.black,
                              )
                            : const Icon(Icons.add),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
