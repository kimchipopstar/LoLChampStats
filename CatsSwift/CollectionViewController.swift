//
//  CollectionViewController.swift
//  CatsSwift
//
//  Created by Jaewon Kim on 2017-11-10.
//  Copyright © 2017 Jaewon Kim. All rights reserved.
//

import UIKit



class CollectionViewController: UICollectionViewController {
    var photoArray:[UIImage] = [UIImage]()
    let lolApiKey:String = "RGAPI-fdf678aa-1e3d-4999-8e9f-10d2194fd00c"
    let lolChampionsUrlstring = "http://ddragon.leagueoflegends.com/cdn/6.24.1/data/en_US/champion.json"
    var championsArray:[Champion] = [Champion]()

    override func viewDidLoad() {
        super.viewDidLoad()
        photoArray.append(#imageLiteral(resourceName: "IMG_0078"))
        self.championsUrlRequestAndSession(lolChampionsUrlString: lolChampionsUrlstring)
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return championsArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:PhotoCell = collectionView.dequeueReusableCell(withReuseIdentifier:
            "Cell", for: indexPath) as! PhotoCell
    
        cell.titleLabel.text = championsArray[indexPath.row].name
    
        return cell
    }
    
    func championsUrlRequestAndSession(lolChampionsUrlString:String) {
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
                    print(championDetail["name"]!)
                    let champion:Champion = Champion()
                    champion.name = championDetail["name"] as! String
                    let imageDetail = championDetail["image"] as! [String:Any]
                    champion.image = imageDetail["full"] as! String
                    print(champion.image)
                    print(champion.name)
                    self.championsArray.append(champion)
                }

                
                
                
//                for (key,value) in champs {
//                    print("champs have \(key)")
//                    let champsDetail = champs[key] as! [String:Any]
//                    for (key,value) in champsDetail {
//                        print("champsDetail have \(key)")
//                        let champion:Champion = Champion();
//                        champion.name = champsDetail["name"] as! String
//                        let champsImage = champsDetail["image"] as! [String:Any]
//                        for (key,value) in champsImage {
//                            print(key)
//                            champion.image = champsImage["full"] as! String
//                            self.championsArray.append(champion)
//                        }
//                    }
//
//                }
                
//                for (key,value) in champs {
//                    print("champs have \(key)")
//                    let champsDetail = champs[key] as! [String:Any]
//                    for (key,value) in champsDetail {
//                        print("champsDetail have \(key)")
//
//                        let champsImage = champsDetail["image"] as! [String:Any]
//                        for (key,value) in champsImage {
//                            print(key)
//                            let champion:Champion = Champion();
//                            champion.name = champsDetail["name"] as! String
//                            champion.image = champsImage["full"] as! String
//                            self.championsArray.append(champion)
//                        }
//                    }
//
//                }
                
            } catch let jsonError {
                    print(jsonError)
            }
            
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }.resume()
    }

}
