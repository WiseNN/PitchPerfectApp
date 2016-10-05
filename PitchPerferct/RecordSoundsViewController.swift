//
//  ViewController.swift
//  PitchPerferct
//
//  Created by Norris Wise on 6/14/16.
//  Copyright © 2016 Norris Swift Sample Application. All rights reserved.
//

import UIKit
import AVFoundation


class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate
{
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!

    
    var audioRecorder:AVAudioRecorder!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func recordAudio(sender: AnyObject)
    {
            print("This Record button was pressed")
        recordingLabel.text = "Recording is in progress"
        
        stopRecordingButton.enabled = true
        recordButton.enabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath!)
        
        let session = AVAudioSession.sharedInstance()
       // try! session.setActive(true)
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
        
    }

    @IBAction func stopRecording(sender: AnyObject)
    {
        print("Stop recording button pressed")
        recordButton.enabled = true
        stopRecordingButton.enabled = false
        recordingLabel.text = "Tap to Record"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
        
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
        stopRecordingButton.enabled = false
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool)
    {
        print("Recording is finished")
        
        if(flag)
        {
            self.performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)
            print("Segue has been performed!!!\n")
            print("sending audioRecorder url: \(audioRecorder.url) ")
        }
        else{
            print("There was an error while recording")
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        //print("Looking at the object\(AnyObject)")
        if(segue.identifier=="stopRecording")
        {
            let playSoundsVC = segue.destinationViewController as! playSoundsViewController
            
            let recorderAudioURL = sender as! NSURL
            let str: String = recorderAudioURL.absoluteString
            print("HAS BEEN RECIEVED: "+str)
            playSoundsVC.recorderAudioURL = recorderAudioURL
            //playSoundsVC.recorderAudioURL
            
        }
    }

}

