//
//  playSoundsViewController.swift
//  PitchPerferct
//
//  Created by Norris Wise on 6/14/16.
//  Copyright © 2016 Norris Swift Sample Application. All rights reserved.
//


import UIKit
import AVFoundation


class playSoundsViewController: UIViewController
{
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var darkVaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    //var recorderAudioURL : NSURL!
    var audioFile : AVAudioFile!
    var audioEngine : AVAudioEngine!
    var audioPlayerNode : AVAudioPlayerNode!
    var stopTimer : NSTimer!
    
    
    
    
    enum ButtonType : Int {case Slow = 0, Fast, Chipmunk, Vader, Echo, Reverb}
    
    
    @IBAction func playSoundsForButton(sender: AnyObject)
    {
        
        
        switch (ButtonType(rawValue: sender.tag)!)
        {
        case .Slow:
            playSound(rate:0.5)
            print("Snail is playing...")
        case .Fast:
            playSound(rate: 1.5)
            print("Rabbit is playing...")
        case .Chipmunk:
            playSound(pitch: 1700)
            print("Chipmunk is playing...")
        case .Vader:
            playSound(pitch: -1000)
            print("Vader is playing...")
        case .Echo:
            playSound(echo:true)
            print("Echo activated...")
        case .Reverb:
            playSound(reverb:true)
            print("Reverb activated...")
        }
        
        configureUI(.Playing)
    }
    
    @IBAction func stopButtonPressed(sender: AnyObject)
    {
        print("Playback stop button is pressed")
        audioEngine.stop()
        
    }
    
    
    var recorderAudioURL = NSURL()
    
    override func viewDidLoad()
    {
        setupAudio()
    }
    
    override func didReceiveMemoryWarning()
    {
        
    }
    override func viewWillAppear(animated: Bool)
    {
        configureUI(.NotPlaying)
    }
    

}
