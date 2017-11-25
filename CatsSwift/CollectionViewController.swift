//
//  CollectionViewController.swift
//  CatsSwift
//
//  Created by Jaewon Kim on 2017-11-10.
//  Copyright © 2017 Jaewon Kim. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    let lolApiKey:String = "RGAPI-fdf678aa-1e3d-4999-8e9f-10d2194fd00c"
    let lolChampionsUrlstring = "http://ddragon.leagueoflegends.com/cdn/6.24.1/data/en_US/champion.json"
    let lolSquareImageUrl = "http://ddragon.leagueoflegends.com/cdn/6.24.1/img/champion/"
    var championsArray:[Champion] = [Champion]()
    var delegate:ChampDelegate?
    var sendingChamp:Champion = Champion()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.urlRequestAndSessionForGettingNameAndImage(lolChampionsUrlString: lolChampionsUrlstring)
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return championsArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:PhotoCell = collectionView.dequeueReusableCell(withReuseIdentifier:
            "Cell", for: indexPath) as! PhotoCell
    
        let champion:Champion = championsArray[indexPath.row]
        cell.imageView.image = self.imageDataFromChampion(champion: champion)
        cell.titleLabel.text = champion.name
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detail") {
            let vc:ViewController = segue.destination as! ViewController
            self.delegate = vc
            delegate?.passChamion(champion: sendingChamp)
        }
        
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        delegate?.passChamion(champion: championsArray[indexPath.row])
        let photoCell:PhotoCell = collectionView.cellForItem(at: indexPath) as! PhotoCell
        photoCell.vibration()
        sendingChamp = championsArray[indexPath.row]
        performSegue(withIdentifier: "detail", sender: self)
    }
    
    
    

    
    func urlRequestAndSessionForGettingNameAndImage(lolChampionsUrlString:String) {
        guard let url = URL.init(string: lolChampionsUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, reponse, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            
            do {
                let serializedData:[String:Any] = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as! [String : Any]
                
                let champsInData = serializedData["data"] as! [String:Any]
                
                for (key,value) in champsInData {
                    let championDetail = champsInData[key] as! [String:Any]
                    let champion:Champion = Champion()
                    champion.name = championDetail["name"] as? String
                    let imageDetail = championDetail["image"] as! [String:Any]
                    champion.image = imageDetail["full"] as? String
                    let info = championDetail["info"] as! [String:Any]
                    champion.attack = info["attack"] as? Int
                    champion.defense = info["defense"] as? Int
                    champion.magic = info["magic"] as? Int
                    champion.difficulty = info["difficulty"] as? Int
                    self.championsArray.append(champion)
                    self.championsArray.sort(by: {$0.name! < $1.name!})
                }
                
            } catch let jsonError {
                    print(jsonError)
            }
            
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }.resume()
    }
    
    func imageDataFromChampion(champion:Champion) -> UIImage {
        let url:URL = URL.init(string: String.init(format: "\(lolSquareImageUrl)%@", champion.image!))!
        var data:Data = Data()
        do {
             data = try Data.init(contentsOf: url)
        } catch let dataError{
            print(dataError)
        }
        return UIImage.init(data: data)!
    }

}
