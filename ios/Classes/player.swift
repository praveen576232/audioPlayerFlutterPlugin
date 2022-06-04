//
//  player.swift
//  audio_player
//
//  Created by apple on 24/01/22.
//

import Foundation
import AVFoundation
//
class AudioPlayer {

    var player:AVPlayer?
    func  audio(isLocal:Bool,path:String){
                let urlString = URL(string: path)


                do{
                   try AVAudioSession.sharedInstance()

                        .setMode(.default)
                    try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                    try AVAudioSession.sharedInstance()
                        .setCategory(.playback)
                    let playState = AVPlayerItem(url:urlString!)
                    
                    player = AVPlayer(playerItem: playState)
                }catch{
                    print("erorr to play song")
                }
  }
    func play(){
        if let player = player {
            player.play()
            print(player.currentItem?.duration.seconds)
        }
    }
    func pause(){
        if let player = player {
            player.pause()
           
        }
    }
    func getDuration()->Double?{
        if let player = player {
            
            return(player.currentItem?.duration.seconds)
        }
        return nil
    }
    func getTime()->Double?{
     return  player?.currentTime().seconds
    }
    func seek(seconds:Float64,result:FlutterResult) {
        print("position is --> \(seconds)")
        if let player = player {
//            if (player.currentItem?.duration.seconds != nil && player.currentItem?.duration.seconds ?? 0 <= seconds) {
                player.seek(to: CMTimeMakeWithSeconds(seconds, preferredTimescale: 1), toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
//            }
//            result("ERROR TO SEEK")
        }
      

    }
}

//
//func add(){
//
//
////         if let player = player, player {
////             player.stop()
////             timer.invalidate()
////             self.name = "Play"
////         }
//
////         else {
////             let urlString = Bundle.main.path(forResource: "audio", ofType: "mp3")
//        let urlString = URL(string:  "https://s6.wsongs.download/kacd108kjn1nadp/Jaga%20Malla%20-%20%282019%29/%5BiSongs.info%5D%2003%20-%20O%20Nanna%20Kanne.mp3")
//
//
//        do{
//           try AVAudioSession.sharedInstance()
//
//                .setMode(.default)
//            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
//            try AVAudioSession.sharedInstance()
//                .setCategory(.playback)
////                 guard let urlString = urlString else {
////                     return
////                 }
//            let playState = AVPlayerItem(url:urlString!)
//            player = AVPlayer(playerItem: playState)
////                 player  = try AVAudioPlayer(contentsOf:URL(fileURLWithPath: urlString))
//            guard let player = player else {
//                return
//            }
//            player.play()
////                 self.duration = player.duration
////                 self.currentPosition = player.currentTime
////                 player.prepareToPlay()
////                 player.play()
////                 timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { time in
////                     print(time)
////                         print("time")
////                     if(player.duration == player.currentTime){
////                         print("invalid")
////                         time.invalidate()
////                     }
////                         self.currentPosition = player.currentTime
//
//
////                                      })
////                self.name = "Stop"
//        }catch{
//            print("erorr to play song")
//        }
//    }
//
