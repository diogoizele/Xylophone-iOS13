//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 28/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    let colors: [UIColor] = [
        UIColor.systemRed,
        UIColor.systemOrange,
        UIColor.systemYellow,
        UIColor.systemGreen,
        UIColor.systemIndigo,
        UIColor.systemBlue,
        UIColor.systemPurple
    ]
    var buttons: [UIButton] = []
    
    @IBOutlet weak var C: UIButton!
    @IBOutlet weak var D: UIButton!
    @IBOutlet weak var E: UIButton!
    @IBOutlet weak var F: UIButton!
    @IBOutlet weak var G: UIButton!
    @IBOutlet weak var A: UIButton!
    @IBOutlet weak var B: UIButton!
    
    var lastNote: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttons = [C, D, E, F, G, A, B]
    }

    @IBAction func keyPressed(_ sender: UIButton) {
        
        let note: String = sender.currentTitle!
        
        playSound(note: note)
        changeOpacity(sender)
        
        if note != lastNote {
            changeColor(buttons: buttons, colors: colors)
        }
        
        lastNote = note
    }
    
    func playSound(note: String) {
        let url = Bundle.main.url(forResource: note, withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
    
    func changeOpacity(_ sender: UIButton) {
        sender.layer.opacity = 0.8
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.layer.opacity = 1
        }
    }
    
    func changeColor(buttons: [UIButton], colors: [UIColor]) {
        var usedNumbers: [Int] = []
        var usedNumLength = 0
        
        while usedNumLength < buttons.count {
            var exists: Bool = false
            let generatedNum = Int.random(in: 0...colors.count - 1)
            
            if !usedNumbers.isEmpty {
                for j in 0...(usedNumbers.count - 1 )  {
                    if generatedNum == usedNumbers[j] {
                        exists = true
                        break
                    }
                }
            }
            
            if (!exists) {
                usedNumbers.append(generatedNum)
                buttons[usedNumLength].backgroundColor = colors[generatedNum]
                usedNumLength += 1
            }
        }
    }
}
