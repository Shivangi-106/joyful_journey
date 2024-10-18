import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LearningPage(), // Removed 'const' here
    );
  }
}

class LearningPage extends StatelessWidget {
  final List<VideoItem> videoItems = [
    VideoItem(
      title: 'ABCD song',
      subtitle: 'Learning A-Z in fun way',
      videoUrl: 'https://youtu.be/gHnWkmW6qRI?si=L1lMUArqkgLzUSQM',
      color: Colors.yellow,
    ),
    VideoItem(
      title: 'The Honest Woodcutter Story',
      subtitle: 'Truthfulness Brings its own reward',
      videoUrl: 'https://youtu.be/aZqZzXfbOb8?feature=shared',
      color: Colors.green,
    ),
    VideoItem(
      title: 'The Hunter and The Pigeons Story',
      subtitle: 'Unity is Strength',
      videoUrl: 'https://youtu.be/0KURKXDgloo?feature=shared',
      color: Colors.yellow,
    ),
  ];

  LearningPage({super.key}); // Removed 'const' from here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/learning_page.jpg'), // Ensure this image exists
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

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl)!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
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
        title: const Text('Learning Video'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.green,
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: const Center(
                child: Text('Video Player', style: TextStyle(fontSize: 24)),
              ),
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
