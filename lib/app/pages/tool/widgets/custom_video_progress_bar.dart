import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoProgressBar extends StatefulWidget {
  final VideoPlayerController controller;

  const CustomVideoProgressBar({Key? key, required this.controller}) : super(key: key);

  @override
  _CustomVideoProgressBarState createState() => _CustomVideoProgressBarState();
}

class _CustomVideoProgressBarState extends State<CustomVideoProgressBar> {
  double _progress = 0.0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateProgress);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateProgress);
    super.dispose();
  }

  void _updateProgress() {
    if (!_isDragging) {
      setState(() {
        _progress = widget.controller.value.position.inMilliseconds.toDouble();
      });
    }
  }

  void _onDragStart(double value) {
    setState(() {
      _isDragging = true;
    });
  }

  void _onDragEnd(double value) {
    setState(() {
      _isDragging = false;
      widget.controller.seekTo(Duration(milliseconds: value.toInt()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final duration = widget.controller.value.duration.inMilliseconds.toDouble();
    final bufferedEnd = widget.controller.value.buffered.isNotEmpty
        ? widget.controller.value.buffered.last.end.inMilliseconds.toDouble()
        : 0.0;

    return Column(
      children: [
        // 显示缓冲进度
        // LinearProgressIndicator(
        //   value: bufferedEnd / duration,
        //   backgroundColor: Colors.grey[300],
        //   valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
        // ),
        // 进度条
        Slider(
          value: _progress,
          min: 0.0,
          max: duration,
          inactiveColor:Colors.grey,
          onChangeStart: _onDragStart,
          onChanged: (value) {
            setState(() {
              _progress = value;
            });
          },
          onChangeEnd: _onDragEnd,
        ),
      ],
    );
  }
}
