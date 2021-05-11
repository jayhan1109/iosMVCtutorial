//
//  ViewController.swift
//  BountyListPracticeMVC
//
//  Created by Jeongho Han on 2021-05-11.
//

import UIKit

class BountyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var bountyTableView: UITableView!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bountyTableView.delegate = self
        bountyTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bountyInfoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ListCell else {
            return UITableViewCell()
        }
        
        cell.imgView.image = bountyInfoList[indexPath.row].image
        cell.nameLabel.text = bountyInfoList[indexPath.row].name
        cell.bountyLabel.text = "\(bountyInfoList[indexPath.row].bounty)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            let vc = segue.destination as? DetailViewController
            
            if let idx = sender as? Int{
                vc?.bountyInfo = bountyInfoList[idx]
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

class ListCell: UITableViewCell{
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
}
