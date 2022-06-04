import Flutter
import UIKit
import AVFoundation
var player: AudioPlayer?
public class SwiftAudioPlayerPlugin: NSObject, FlutterPlugin {
    var player = AudioPlayer()
  public static func register(with registrar: FlutterPluginRegistrar) {
    
    let channel = FlutterMethodChannel(name: "audio_player", binaryMessenger: registrar.messenger())
    let instance = SwiftAudioPlayerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      switch(call.method){
      case  "musicINIT":
        if  let args = call.arguments as? Dictionary<String, Any>,
                      let path = args["path"] as? String {
                        // please check the "as" above  - wasn't able to test
                        // handle the method
                          player.audio(isLocal: true, path:path)
                      result(nil)
                    } else {
                      result(FlutterError.init(code: "errorSetDebug", message: "data or format error", details: nil))
                    }
          break
      case "play":
          player.play()
          break
      case "pause":
          player.pause()
          break
      case "duration":
          result(player.getDuration())
          break
      case "getTime":
          result(player.getTime())
          break
      case "seek":
          if let args = call.arguments as? Dictionary<String,Any>{
              if args["seekPositionInSeconds"].unsafelyUnwrapped != nil {
                  player.seek(seconds: args["seekPositionInSeconds"].unsafelyUnwrapped as! Float64,result: result)
              }
             
          }
         
      default:
          result("ERROR")
          break
//      }else if(call.method == "play"){
//          player.play()
//      }else if(call.method == "pause"){
//          player.pause()
//      }
 //     add()
//
//      print(call.method)
//      if let args = call.arguments as? Dictionary<String,Any>{
//          print(args["a"].unsafelyUnwrapped)
//          playAudio().playAudio(isLocal: false, path: "https://s8.wsongs.download/kaeg121nks8subn/Hareesha%20Vayassu%2036%20-%20%282022%29/%5BiSongs.info%5D%2001%20-%20Hareesha%20Vayassu%2036%20Title%20Track.mp3")
//      }
    result("iOS " + UIDevice.current.systemVersion)
      
  }
}
   
}
