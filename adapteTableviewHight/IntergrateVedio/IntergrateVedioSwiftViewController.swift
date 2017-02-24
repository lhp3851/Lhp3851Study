//
//  IntergrateVedioSwiftViewController.swift
//  AVFoundatonStudy
//
//  Created by kankanliu on 16/8/3.
//  Copyright © 2016年 jerry. All rights reserved.
//

import UIKit
import AVFoundation

class IntergrateVedioSwiftViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

//    func combVideos() {
//        let firstVideo = NSBundle.mainBundle().pathForResource("1", ofType: "mp4")
//        let secondVideo = NSBundle.mainBundle().pathForResource("2", ofType: "mp4")
//        
//        let optDict = [AVURLAssetPreferPreciseDurationAndTimingKey : NSNumber(bool: false)]
//        let firstAsset = AVURLAsset(URL: NSURL(fileURLWithPath: firstVideo!), options: optDict)
//        let secondAsset = AVURLAsset(URL: NSURL(fileURLWithPath: secondVideo!), options: optDict)
//        
//        let composition = AVMutableComposition()
//        do {
//            let compositionTrack = composition.addMutableTrackWithMediaType(AVMediaTypeVideo, preferredTrackID: kCMPersistentTrackID_Invalid)
//            let firstTimeRange = CMTimeRange(start: kCMTimeZero, duration: firstAsset.duration)
//            let secondTimeRange = CMTimeRange(start: kCMTimeZero, duration: secondAsset.duration)
//            
//            // 添加视频
//            try compositionTrack.insertTimeRange(secondTimeRange, ofTrack: secondAsset.tracksWithMediaType(AVMediaTypeVideo).first!, atTime: kCMTimeZero)
//            try compositionTrack.insertTimeRange(firstTimeRange, ofTrack: firstAsset.tracksWithMediaType(AVMediaTypeVideo).first!, atTime: kCMTimeZero)
//            
//            // 添加声音
//            let audioTrack = composition.addMutableTrackWithMediaType(AVMediaTypeAudio, preferredTrackID: kCMPersistentTrackID_Invalid)
//            try audioTrack.insertTimeRange(secondTimeRange, ofTrack: secondAsset.tracksWithMediaType(AVMediaTypeAudio).first!, atTime: kCMTimeZero)
//            try audioTrack.insertTimeRange(firstTimeRange, ofTrack: firstAsset.tracksWithMediaType(AVMediaTypeAudio).first!, atTime: kCMTimeZero)
//            
//            let cache = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true).last
//            let filePath = cache! + "/comp_sw.mp4"
//            
//            let exporterSession = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetHighestQuality)
//            exporterSession?.outputFileType = AVFileTypeMPEG4
//            exporterSession?.outputURL = NSURL(fileURLWithPath: filePath)
//            exporterSession?.shouldOptimizeForNetworkUse = true
//            exporterSession?.exportAsynchronouslyWithCompletionHandler({ () -> Void in
//                switch exporterSession!.status {
//                case .Unknown:
//                    print("unknow")
//                case .Cancelled:
//                    print("cancelled")
//                case .Failed:
//                    print("failed")
//                case .Waiting:
//                    print("waiting")
//                case .Exporting:
//                    print("exporting")
//                case .Completed:
//                    print("completed")
//                }
//            })
//        } catch {
//            print("\(error)")
//        }
//    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
