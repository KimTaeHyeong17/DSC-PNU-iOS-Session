//
//  FriendDetailVC.swift
//  week2-practice
//
//  Created by 김태형 on 2020/05/16.
//  Copyright © 2020 김태형. All rights reserved.
//

import UIKit
import SDWebImage

class FriendDetailVC: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.asCircle()
        // Do any additional setup after loading the view.
        
        let urlstr = "https://cdn.pixabay.com/photo/2017/08/30/01/05/milky-way-2695569_960_720.jpg"
        
        let url = URL(string: urlstr)
        profileImage.sd_setImage(with: url, placeholderImage: UIImage(named: "Image"))
        backgroundImage.sd_setImage(with: url)
        
        
    }
    
    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension UIImageView {
    func asCircle(){
        self.layer.cornerRadius = self.frame.width/2
        self.layer.masksToBounds = true
    }
}
