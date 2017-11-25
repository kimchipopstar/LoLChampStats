//
//  ViewController.swift
//  CatsSwift
//
//  Created by Jaewon Kim on 2017-11-23.
//  Copyright © 2017 Jaewon Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ChampDelegate {
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var magicLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    var passedChamp:Champion = Champion()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.attackLabel.text = String.init(format: "%i / 10", passedChamp.attack!)
        self.defenseLabel.text = String.init(format: "%i / 10", passedChamp.defense!)
        self.magicLabel.text = String.init(format: "%i / 10", passedChamp.magic!)
        self.difficultyLabel.text = String.init(format: "%i / 10", passedChamp.difficulty!)
        self.title = passedChamp.name
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func passChamion(champion: Champion) {
        passedChamp = champion
    }
}
