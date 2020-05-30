//
//  AddFriendByIdVC.swift
//  week2-practice
//
//  Created by TaeHyeong Kim on 2020/05/22.
//  Copyright © 2020 김태형. All rights reserved.
//

import UIKit

class AddFriendByIdVC: UIViewController {

    @IBOutlet weak var ifId: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ifId.layer.addBorder([.bottom], color: .black, width: 1)

    }

    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
