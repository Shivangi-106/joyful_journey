import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class NatureDevelopmentPage extends StatelessWidget {
  final List<VideoItem> videoItems = [
    VideoItem(
      title: 'Thirsty Cow',
      subtitle: 'Where there is a will, there is a way',
      videoUrl: 'https://youtu.be/uwzViw-T0-A',
      color: Colors.yellow,
    ),
    VideoItem(
      title: 'The Honest Woodcutter Story',
      subtitle: 'Truthfulness Brings its own reward',
      videoUrl: 'https://youtu.be/aZqZzXfbOb8',
      color: Colors.green,
    ),
    VideoItem(
      title: 'The Hunter and The Pigeons Story',
      subtitle: 'Unity is Strength',
      videoUrl: 'https://youtu.be/0KURKXDgloo',
      color: Colors.yellow,
    ),
  ];

  NatureDevelopmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nature Development'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/background_nature_page.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: videoItems.length,
          itemBuilder: (context, index) {
            final videoItem = videoItems[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              child: ListTile(
                contentPadding: const EdgeInsets.all(8.0),
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                leading: const Icon(Icons.videocam, color: Colors.blue),
                title: Text(videoItem.title, style: const TextStyle(color: Colors.black)),
                subtitle: Text(videoItem.subtitle, style: const TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoPlayerScreen(videoItem.videoUrl),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class VideoItem {
  final String title;
  final String subtitle;
  final String videoUrl;
  final MaterialColor color;

  VideoItem({
    required this.title,
    required this.subtitle,
    required this.videoUrl,
    required this.color,
  });
}

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerScreen(this.videoUrl, {super.key});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();

    String? videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);

    if (videoId == null) {
      print("Error: Invalid YouTube URL: ${widget.videoUrl}");
    } else {
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: true, // Enable auto-play
          mute: false,
        ),
      )..addListener(() {
        if (mounted) {
          setState(() {
            _isPlayerReady = _controller.value.isReady;
            if (_controller.value.hasError) {
              print('Player Error: ${_controller.value.errorCode}');
            }
          });
        }
      });
    }
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
        title: const Text('Develop Nature'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.green,
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.red,
              onReady: () {
                print('Player is ready.');
              },
              onEnded: (data) {
                print('Video ended.');
              },
            ),
          ),
          Expanded(
            child: Center(
              child: _isPlayerReady
                  ? const Text('Video Player', style: TextStyle(fontSize: 24))
                  : const CircularProgressIndicator(), // Show loading indicator until ready
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
