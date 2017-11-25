//
//  ViewController.swift
//  CatsSwift
//
//  Created by Jaewon Kim on 2017-11-23.
//  Copyright © 2017 Jaewon Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ChampDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
//    @IBOutlet weak var attackLabel: UILabel!
//    @IBOutlet weak var defenseLabel: UILabel!
//    @IBOutlet weak var magicLabel: UILabel!
//    @IBOutlet weak var difficultyLabel: UILabel!
    var passedChamp:Champion = Champion()
    
    @IBOutlet weak var collectionViewView: UIView!
    @IBOutlet weak var attackCollectionView: UICollectionView!
    @IBOutlet weak var defenseCollectionView: UICollectionView!
    @IBOutlet weak var magicCollectionView: UICollectionView!
    @IBOutlet weak var difficultyCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        attackCollectionView.
//        self.attackLabel.text = String.init(format: "%i / 10", passedChamp.attack!)
//        self.defenseLabel.text = String.init(format: "%i / 10", passedChamp.defense!)
//        self.magicLabel.text = String.init(format: "%i / 10", passedChamp.magic!)
//        self.difficultyLabel.text = String.init(format: "%i / 10", passedChamp.difficulty!)
//        self.title = passedChamp.name
        self.view.addSubview(collectionViewView)
        collectionViewView.addSubview(attackCollectionView)
        collectionViewView.addSubview(defenseCollectionView)
        collectionViewView.addSubview(magicCollectionView)
        collectionViewView.addSubview(difficultyCollectionView)

//        self.view.addSubview(attackCollectionView)
//        self.view.addSubview(defenseCollectionView)
//        self.view.addSubview(magicCollectionView)
//        self.view.addSubview(difficultyCollectionView)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == attackCollectionView {
            return passedChamp.attack!
        } else if collectionView == defenseCollectionView {
            return passedChamp.defense!
        } else if collectionView == magicCollectionView {
            return passedChamp.magic!
        } else {
            return passedChamp.difficulty!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == attackCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "attackCell", for: indexPath)
            return cell
        } else if collectionView == defenseCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "defenseCell", for: indexPath)
            return cell
        } else if collectionView == magicCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "magicCell", for: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "difficultyCell", for: indexPath)
            return cell
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func passChamion(champion: Champion) {
        passedChamp = champion
    }
}
