package com.example.network_audio_player;

import android.content.Context;
import android.media.AudioAttributes;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Build;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import java.io.IOException;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** AudioPlayerPlugin */
public class AudioPlayerPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Context context;
  MediaPlayer mediaPlayer;
  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "audio_player");
    channel.setMethodCallHandler(this);
  context =  flutterPluginBinding.getApplicationContext();
  }

  @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("musicINIT")) {
      System.out.println();
      String url = call.argument("path");
      if(url == null || url == "") result.error("1","Url Can not be Null","URL Can not be null ");
      mediaPlayer =new MediaPlayer();
      mediaPlayer.setAudioAttributes(
              new AudioAttributes.Builder()
                      .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC)
                      .setUsage(AudioAttributes.USAGE_MEDIA)
                      .build());
      try {
        mediaPlayer.setDataSource(context, Uri.parse(url));
        mediaPlayer.prepare();

      } catch (IOException e) {
        System.out.println(e);
        e.printStackTrace();
        result.error("2",e.getMessage(),e.getLocalizedMessage());
      }

      result.success("ok ");
    } else if(call.method.equals("play")){
      if(mediaPlayer.isPlaying()){
        mediaPlayer.release();
      }else{
        mediaPlayer.start();
      }

    }else if(call.method.equals("pause")){
      mediaPlayer.pause();
    }else  if(call.method.equals("duration")){
      result.success(mediaPlayer.getDuration());
    }else  if(call.method.equals("getTime")){
       result.success(mediaPlayer.getCurrentPosition());
    }else  if(call.method.equals("seek")){
      double sec = call.argument("seekPositionInSeconds");
      int milliSec = (int)(sec);
      System.out.println(milliSec);
      mediaPlayer.seekTo(milliSec);
    }
    else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
