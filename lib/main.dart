import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'screens/grade_programacao_screen.dart';
import 'screens/home_screen.dart';
import 'screens/list_notice_screen.dart';
import 'package:audio_session/audio_session.dart';

Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.chanel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const MainScreen(),
    theme: ThemeData(
      primaryColor: Colors.lightBlue[800],
      scaffoldBackgroundColor: const Color(0xFFEAEBF3),
    ),
  ));
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  int currentIndex = 0;
  final pageController = PageController(initialPage: 0);
  final _player = AudioPlayer();
  bool _isStop = true;

  @override
  void initState() {
    super.initState();
    // ambiguate(WidgetsBinding.instance)!.addObserver(this);
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.
    // final session = await AudioSession.instance;
    // await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    // Try to load audio from a source and catch any errors.
    try {
      // AAC example: https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.aac
      await _player.setAudioSource(AudioSource.uri(
          Uri.parse("https://streaming.radiorcvfm.com.br:9000/live"),
          tag: const MediaItem(
            id: '0',
            title: 'Radio RCVFM 87.9',
          )));
    } catch (e) {
      print("Error loading audio source: $e");
    }

    // _handleInterruptions(session);
  }

  @override
  void dispose() {
    // ambiguate(WidgetsBinding.instance)!.removeObserver(this);
    // Release decoders and buffers back to the operating system making them
    // available for other apps to use.
    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      _player.stop();
    }
  }

  // void _handleInterruptions(AudioSession audioSession) {
  //   // just_audio can handle interruptions for us, but we have disabled that in
  //   // order to demonstrate manual configuration.
  //   bool playInterrupted = false;
  //   audioSession.becomingNoisyEventStream.listen((_) {
  //     print('PAUSE');
  //     _player.pause();
  //     _isStop = true;
  //   });
  //   _player.playingStream.listen((playing) {
  //     playInterrupted = false;
  //     if (playing) {
  //       audioSession.setActive(true);
  //     }
  //   });
  //   audioSession.interruptionEventStream.listen((event) {
  //     print('interruption begin: ${event.begin}');
  //     print('interruption type: ${event.type}');
  //     if (event.begin) {
  //       switch (event.type) {
  //         case AudioInterruptionType.duck:
  //           if (audioSession.androidAudioAttributes!.usage ==
  //               AndroidAudioUsage.game) {
  //             _player.setVolume(_player.volume / 2);
  //           }
  //           playInterrupted = false;
  //           break;
  //         case AudioInterruptionType.pause:
  //         case AudioInterruptionType.unknown:
  //           if (_player.playing) {
  //             _player.pause();
  //             playInterrupted = true;
  //           }
  //           break;
  //       }
  //     } else {
  //       switch (event.type) {
  //         case AudioInterruptionType.duck:
  //           //_player.setVolume(min(1.0, _player.volume * 2));
  //           playInterrupted = false;
  //           break;
  //         case AudioInterruptionType.pause:
  //           if (playInterrupted) _player.play();
  //           playInterrupted = false;
  //           break;
  //         case AudioInterruptionType.unknown:
  //           playInterrupted = false;
  //           break;
  //       }
  //     }
  //   });
  //   audioSession.devicesChangedEventStream.listen((event) {
  //     print('Devices added: ${event.devicesAdded}');
  //     print('Devices removed: ${event.devicesRemoved}');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAEBF3),
      appBar: AppBar(
        title: Image.asset(
          'assets/logo.png',
          height: 150,
          width: 150,
        ),
        toolbarHeight: 120,
        elevation: 5,
        actions: [
          !_isStop
              ? Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        'Você está ouvindo RCV FM 87.9',
                        textStyle: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                    totalRepeatCount: 4,
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
                    repeatForever: true,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(top: 20),
                )
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            PageView(
              controller: pageController,
              physics: const ClampingScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              children: const [
                HomeScreen(),
                ListNoticeScreen(),
                ProgramacaoScreen(),
              ],
            ),
            // bottom bar
            Positioned(
              bottom: 10,
              left: 20,
              right: 20,
              child: Container(
                alignment: Alignment.center,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.lightBlue[800],
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    iconDocked(
                      currentIndex == 0,
                      LucideIcons.home,
                      'Home',
                      0,
                    ),
                    iconDocked(
                      currentIndex == 1,
                      LucideIcons.newspaper,
                      'Notícias',
                      1,
                    ),
                    iconDocked(
                      currentIndex == 2,
                      LucideIcons.list,
                      'Programação',
                      2,
                    ),
                    // iconDocked(
                    //   currentIndex == 0,
                    //   LucideIcons.percent,
                    //   'Promoções',
                    //   0,
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.lightGreen,
        onPressed: () {
          _isStop ? _player.play() : _player.pause();
          setState(() => _isStop = !_isStop);
        },
        splashColor: Colors.lightBlue,
        tooltip: 'Play',
        icon: Icon(_isStop ? LucideIcons.play : LucideIcons.pause),
        label: const Text('Ao Vivo'),
      ),
    );
  }

  Widget iconDocked(bool isSelected, IconData icon, String name, int index) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 4)),
        IconButton(
            icon: isSelected
                ? Icon(
                    icon,
                    color: Colors.white,
                    size: 22,
                  )
                : Icon(
                    icon,
                    color: Colors.lightBlueAccent,
                    size: 22,
                  ),
            onPressed: () => {pageController.jumpToPage(index)}),
        isSelected
            ? Text(name,
                style: const TextStyle(color: Colors.white, fontSize: 10))
            : Text(name,
                style: const TextStyle(
                    color: Colors.lightBlueAccent, fontSize: 10))
      ],
    );
  }
}
