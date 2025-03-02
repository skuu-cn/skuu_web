import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

import 'controllers/tool_controller.dart';

class ThumbnailRequest {
  const ThumbnailRequest({
    required this.video,
    required this.thumbnailPath,
    required this.imageFormat,
    required this.maxHeight,
    required this.maxWidth,
    required this.timeMs,
    required this.quality,
    required this.attachHeaders,
  });

  final String video;
  final String? thumbnailPath;
  final ImageFormat imageFormat;
  final int maxHeight;
  final int maxWidth;
  final int timeMs;
  final int quality;
  final bool attachHeaders;
}

class ThumbnailResult {
  const ThumbnailResult({
    required this.image,
    required this.dataSize,
    required this.height,
    required this.width,
  });

  final Image image;
  final int dataSize;
  final int height;
  final int width;
}

Future<ThumbnailResult> genThumbnail(ThumbnailRequest r) async {
  Uint8List bytes;
  final completer = Completer<ThumbnailResult>();
  if (r.thumbnailPath != null) {
    final thumbnailFile = await VideoThumbnail.thumbnailFile(
      video: r.video,
      headers: r.attachHeaders
          ? const {
        'USERHEADER1': 'user defined header1',
        'USERHEADER2': 'user defined header2',
      }
          : null,
      thumbnailPath: r.thumbnailPath,
      imageFormat: r.imageFormat,
      maxHeight: r.maxHeight,
      maxWidth: r.maxWidth,
      timeMs: r.timeMs,
      quality: r.quality,
    );

    debugPrint('thumbnail file is located: $thumbnailFile');

    bytes = await thumbnailFile.readAsBytes();
  } else {
    bytes = await VideoThumbnail.thumbnailData(
      video: r.video,
      headers: r.attachHeaders
          ? const {
        'USERHEADER1': 'user defined header1',
        'USERHEADER2': 'user defined header2',
      }
          : null,
      imageFormat: r.imageFormat,
      maxHeight: r.maxHeight,
      maxWidth: r.maxWidth,
      timeMs: r.timeMs,
      quality: r.quality,
    );
  }

  final imageDataSize = bytes.length;
  debugPrint('image size: $imageDataSize');

  final image = Image.memory(
    bytes,
    fit: BoxFit.cover,
  );
  image.image.resolve(ImageConfiguration.empty).addListener(
    ImageStreamListener(
          (ImageInfo info, bool _) {
        completer.complete(
          ThumbnailResult(
            image: image,
            dataSize: imageDataSize,
            height: info.image.height,
            width: info.image.width,
          ),
        );
      },
      onError: completer.completeError,
    ),
  );
  return completer.future;
}

class GenThumbnailImage extends StatefulWidget {
  const GenThumbnailImage({
    Key? key,
    required this.thumbnailRequest,
  }) : super(key: key);
  final ThumbnailRequest thumbnailRequest;

  @override
  State<GenThumbnailImage> createState() => _GenThumbnailImageState();
}

class _GenThumbnailImageState extends State<GenThumbnailImage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ThumbnailResult>(
      future: genThumbnail(widget.thumbnailRequest),
      builder: (BuildContext context, AsyncSnapshot<ThumbnailResult> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          final image = data.image;
          return Container(
            width: double.infinity, // 宽度铺满
            height: double.infinity,
            child: image,
          );
        } else if (snapshot.hasError) {
          return Container(
            padding: const EdgeInsets.all(8),
            color: Colors.red,
            child: Text('Error:\n${snapshot.error}\n\n${snapshot.stackTrace}'),
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Generating the thumbnail for: ${widget.thumbnailRequest
                    .video}...',
              ),
              const SizedBox(height: 10),
              const CircularProgressIndicator(),
            ],
          );
        }
      },
    );
  }
}

class ThumbnailPage extends StatefulWidget {
  const ThumbnailPage({Key? key}) : super(key: key);

  @override
  State<ThumbnailPage> createState() => _ThumbnailPage();
}

class _ThumbnailPage extends State<ThumbnailPage> {
  late ToolController toolController;
  final _editNode = FocusNode();
  final _video = TextEditingController(
    text:
    'https://cloud.video.taobao.com/play/u/153810888/p/2/e/6/t/1/266102583124.mp4',
  );
  ImageFormat _format = ImageFormat.JPEG;
  bool _attachHeaders = false;

  String? _tempDir;
  late VideoPlayerController _controller;
  Duration? _duration;

  @override
  void initState() {
    super.initState();

    if (!kIsWeb) {
      getTemporaryDirectory().then((d) => _tempDir = d.path);
    }
    _controller = VideoPlayerController.network(_video.text)
      ..initialize().then((_) {
        setState(() {
          int seconds = _controller.value.duration.inSeconds; // 获取秒数
          _duration = Duration(seconds: seconds); // 转换为Duration
        });
      });
    toolController = Get.put(ToolController());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('缩略图截取'),
      ),
      body: GetBuilder<ToolController>(builder: (a) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 10, 2, 8),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  isDense: true,
                  labelText: '视频 URI',
                ),
                maxLines: null,
                controller: _video,
                focusNode: _editNode,
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.done,
                onEditingComplete: _editNode.unfocus,
              ),
            ),
            Center(
              child: Row(
                children: [
                  Spacer(),
                  Container(
                    width: 400,
                    // height: 500,
                    // color: Colors.amber,
                    decoration: BoxDecoration(
                      // color: Colors.grey,
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        _controller.value.isInitialized
                            ? AspectRatio(
                          aspectRatio: 1.5,
                          child: VideoPlayer(_controller),
                        )
                            : Center(child: CircularProgressIndicator()),
                        // 加载中
                        VideoProgressIndicator(
                          _controller,
                          allowScrubbing: true, // 允许拖动
                          colors: VideoProgressColors(
                            playedColor: Colors.red, // 已播放部分颜色
                            bufferedColor: Colors.grey, // 缓冲部分颜色
                            backgroundColor: Colors.black, // 背景颜色
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                            });
                          },
                          child: Icon(_controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow),
                        ),
                        Row(
                          children: [
                            Text("添加到："),
                          ],
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  GenThumbnailImage tmp = GenThumbnailImage(
                                    thumbnailRequest: ThumbnailRequest(
                                      video: _video.text,
                                      thumbnailPath: null,
                                      imageFormat: _format,
                                      maxHeight: 0,
                                      maxWidth: 0,
                                      timeMs: _controller
                                          .value.position.inMilliseconds,
                                      quality: 100,
                                      attachHeaders: _attachHeaders,
                                    ),
                                  );
                                  toolController.setGenThumbnailImage(1, tmp);
                                },
                                child: Text("1")),
                            ElevatedButton(
                                onPressed: () {
                                  GenThumbnailImage tmp = GenThumbnailImage(
                                    thumbnailRequest: ThumbnailRequest(
                                      video: _video.text,
                                      thumbnailPath: null,
                                      imageFormat: _format,
                                      maxHeight: 0,
                                      maxWidth: 0,
                                      timeMs: _controller
                                          .value.position.inMilliseconds,
                                      quality: 100,
                                      attachHeaders: _attachHeaders,
                                    ),
                                  );
                                  toolController.setGenThumbnailImage(2, tmp);
                                },
                                child: Text("2")),
                            ElevatedButton(
                                onPressed: () {
                                  GenThumbnailImage tmp = GenThumbnailImage(
                                    thumbnailRequest: ThumbnailRequest(
                                      video: _video.text,
                                      thumbnailPath: null,
                                      imageFormat: _format,
                                      maxHeight: 0,
                                      maxWidth: 0,
                                      timeMs: _controller
                                          .value.position.inMilliseconds,
                                      quality: 100,
                                      attachHeaders: _attachHeaders,
                                    ),
                                  );
                                  toolController.setGenThumbnailImage(3, tmp);
                                },
                                child: Text("3")),
                            ElevatedButton(
                                onPressed: () {
                                  GenThumbnailImage tmp = GenThumbnailImage(
                                    thumbnailRequest: ThumbnailRequest(
                                      video: _video.text,
                                      thumbnailPath: null,
                                      imageFormat: _format,
                                      maxHeight: 0,
                                      maxWidth: 0,
                                      timeMs: _controller
                                          .value.position.inMilliseconds,
                                      quality: 100,
                                      attachHeaders: _attachHeaders,
                                    ),
                                  );
                                  toolController.setGenThumbnailImage(4, tmp);
                                },
                                child: Text("4")),
                            ElevatedButton(
                                onPressed: () {
                                  GenThumbnailImage tmp = GenThumbnailImage(
                                    thumbnailRequest: ThumbnailRequest(
                                      video: _video.text,
                                      thumbnailPath: null,
                                      imageFormat: _format,
                                      maxHeight: 0,
                                      maxWidth: 0,
                                      timeMs: _controller
                                          .value.position.inMilliseconds,
                                      quality: 100,
                                      attachHeaders: _attachHeaders,
                                    ),
                                  );
                                  toolController.setGenThumbnailImage(5, tmp);
                                },
                                child: Text("5")),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 400,
                    // height: 500,
                    // color: Colors.amber,
                    decoration: BoxDecoration(
                      // color: Colors.grey,
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        Container(
                          height: 250,
                          width: double.infinity,
                          color: Colors.blueAccent,
                          child: toolController.imgMap[1] == null
                              ? IconButton(
                              onPressed: () {},
                              icon: Text(
                                '添加到此1',
                                style: TextStyle(color: Colors.white),
                              ))
                              : toolController.imgMap[1],
                        ),
                        Container(
                          height: 10,
                        ),
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.grey, Colors.white], // 渐变颜色
                              begin: Alignment.topCenter, // 渐变起点（顶部）
                              end: Alignment.bottomCenter, // 渐变终点（底部）
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 125,
                              width: 185,
                              color: Colors.blueAccent,
                              child: toolController.imgMap[2] == null
                                  ? IconButton(
                                  onPressed: () {},
                                  icon: Text(
                                    '添加到此2',
                                    style: TextStyle(color: Colors.white),
                                  ))
                                  : toolController.imgMap[2],
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Container(
                              height: 125,
                              width: 185,
                              color: Colors.blueAccent,
                              child: toolController.imgMap[3] == null
                                  ? IconButton(
                                  onPressed: () {},
                                  icon: Text(
                                    '添加到此3',
                                    style: TextStyle(color: Colors.white),
                                  ))
                                  : toolController.imgMap[3],
                            ),
                          ],
                        ),
                        Container(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 125,
                              width: 185,
                              color: Colors.blueAccent,
                              child: toolController.imgMap[4] == null
                                  ? IconButton(
                                  onPressed: () {},
                                  icon: Text(
                                    '添加到此4',
                                    style: TextStyle(color: Colors.white),
                                  ))
                                  : toolController.imgMap[4],
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Container(
                              height: 125,
                              width: 185,
                              color: Colors.blueAccent,
                              child: toolController.imgMap[5] == null
                                  ? IconButton(
                                  onPressed: () {},
                                  icon: Text(
                                    '添加到此5',
                                    style: TextStyle(color: Colors.white),
                                  ))
                                  : toolController.imgMap[5],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        );

      }),


      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () async {
              final video =
              await ImagePicker().pickVideo(source: ImageSource.camera);
              setState(() {
                _video.text = video?.path ?? '';
              });
            },
            tooltip: '捕捉视频',
            child: const Icon(Icons.videocam),
          ),
          const SizedBox(
            width: 5,
          ),
          FloatingActionButton(
            onPressed: () async {
              final video =
              await ImagePicker().pickVideo(source: ImageSource.gallery);
              setState(() {
                _controller = VideoPlayerController.network(video!.path)
                  ..initialize().then((_) {
                    setState(() {
                      int seconds =
                          _controller.value.duration.inSeconds; // 获取秒数
                      _duration = Duration(seconds: seconds); // 转换为Duration
                    });
                  });
                _video.text = video.path ?? '';
              });
            },
            tooltip: '选择一个视频',
            child: const Icon(Icons.local_movies),
          ),
        ],
      ),
    );
  }

  Future<int?> getVideoDuration(String videoPath,
      {bool isAsset = false}) async {
    final controller = isAsset
        ? VideoPlayerController.asset(videoPath)
        : VideoPlayerController.network(videoPath);
    try {
      await controller.initialize().timeout(Duration(seconds: 10),
          onTimeout: () {
            throw TimeoutException('视频加载超时');
          });
      return controller.value.duration.inSeconds;
    } catch (e) {
      print('获取视频时长失败: $e');
      return null;
    } finally {
      await controller.dispose();
    }
  }
}
