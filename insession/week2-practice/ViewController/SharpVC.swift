//
//  SharpVC.swift
//  week2-practice
//
//  Created by TaeHyeong Kim on 2020/06/01.
//  Copyright © 2020 김태형. All rights reserved.
//

import UIKit
import Kingfisher
import SDWebImage

class SharpVC: UIViewController {

    @IBOutlet weak var testTableView: UITableView!
    
    let url = "https://robohash.org/aliquamquiaaccusamus.png?size=50x50&set=set1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        testTableView.delegate = self
        testTableView.dataSource = self
    }

   

}
extension SharpVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SharpTVC") as! SharpTVC
        cell.selectionStyle = .none
//        cell.testImageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "Image"))
        
        let imageresurce = ImageResource(downloadURL: URL(string: url)!)
        cell.testImageView!.kf.setImage(with: imageresurce)
 
        
        return cell
    }
    
    
}
