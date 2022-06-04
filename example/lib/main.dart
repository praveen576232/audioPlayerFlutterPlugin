import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:network_audio_player/network_audio_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    init();
  }
  init()async{
  await AudioPlayer.inti(
    networkUrl: "SONG_URL"
  );
  }
 play() async {
   await AudioPlayer.play();
 }
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
     // platformVersion =
        //  await AudioPlayer.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
   //   _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            ElevatedButton(onPressed: (){
            play();
          }, child: Text("click to play song")),
            ElevatedButton(onPressed: ()async{
             AudioPlayer.pause();
          }, child: Text("click to pause song")),
              ElevatedButton(onPressed: (){
            AudioPlayer.duration();
          }, child: Text("click to duration song")),
              ElevatedButton(onPressed: (){
            AudioPlayer.getTime();
          }, child: Text("click to current duration song")),
              ElevatedButton(onPressed: ()async{
                var time = await  AudioPlayer.getTime();
            AudioPlayer.seek(time + 10.0);
          }, child: Text("click to seek to 10 Sec For song")),
              ElevatedButton(onPressed: ()async{
                var time = await  AudioPlayer.getTime();
            AudioPlayer.seek(time - 10.0);
          }, child: Text("click to seek to 10 Sec Rev song")),
          ]
        ),
      ),
    );
  }
}
