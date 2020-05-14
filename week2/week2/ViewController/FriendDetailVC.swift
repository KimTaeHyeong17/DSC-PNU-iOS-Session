//
//  FriendDetailVC.swift
//  week2
//
//  Created by 김태형 on 2020/05/14.
//  Copyright © 2020 김태형. All rights reserved.
//

import UIKit

class FriendDetailVC: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }
    func setupView(){
        profileImageView.asCircle()
    }
    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension UIImageView{
    func asCircle(){
        self.layer.cornerRadius = self.frame.width / 2;
        self.layer.masksToBounds = true
    }

}
