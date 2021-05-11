//
//  ViewController.swift
//  BountyListPracticeMVC
//
//  Created by Jeongho Han on 2021-05-11.
//

import UIKit

class BountyViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
 
    @IBOutlet weak var bountyCollectionView: UICollectionView!
    
    let bountyInfoList: [BountyInfo] = [
        BountyInfo(name: "brook", bounty: 33000000),
        BountyInfo(name: "chopper", bounty: 50),
        BountyInfo(name: "franky", bounty: 44000000),
        BountyInfo(name: "luffy", bounty: 30000000),
        BountyInfo(name: "nami", bounty: 160000000),
        BountyInfo(name: "robin", bounty: 8000000),
        BountyInfo(name: "sanji", bounty: 77000000),
        BountyInfo(name: "zoro", bounty: 12000000),
    ]
    
    var sortedInfoList: [BountyInfo] {
        return bountyInfoList.sorted { (prev, next) in
            prev.bounty > next.bounty
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bountyCollectionView.delegate = self
        bountyCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bountyInfoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? GridCell else {
            return UICollectionViewCell()
        }
        
        cell.imgView.image = sortedInfoList[indexPath.item].image
        cell.nameLabel.text = sortedInfoList[indexPath.item].name
        cell.bountyLabel.text = "\(sortedInfoList[indexPath.item].bounty)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 10
        let textHeight: CGFloat = 65
        
        let width = (collectionView.bounds.width - itemSpacing) / 2
        let height = width / 7 * 10 + textHeight
        
        return CGSize(width: width, height: height)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            let vc = segue.destination as? DetailViewController
            
            if let idx = sender as? Int{
                vc?.bountyInfo = sortedInfoList[idx]
            }
        }
    }
    
}

struct BountyInfo {
    let name: String
    let bounty: Int
    
    var image: UIImage? {
        return UIImage(named: name)
    }
}

class GridCell: UICollectionViewCell{
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
}
