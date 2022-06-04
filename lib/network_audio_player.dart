
import 'dart:async';

import 'package:flutter/services.dart';

class AudioPlayer {
  static const MethodChannel _channel = MethodChannel('audio_player');

  static Future<String?>  inti({required String networkUrl}) async {
 await _channel.invokeMethod('musicINIT',{
      "path":networkUrl
    });
   
  }
  static Future play()async{
    await _channel.invokeMethod('play');
  }
  static Future pause()async {
    await _channel.invokeMethod('pause');
  }
  static Future duration() async {
    var a =await  _channel.invokeMethod('duration');
    print(a);
  }
  static Future getTime() async {
    var t = await _channel.invokeMethod('getTime');
    return t;
  }
  static Future seek(double position) async {
    var t = await _channel.invokeMethod('seek',{
      "seekPositionInSeconds":position
    });
    print(t);
  }
}
