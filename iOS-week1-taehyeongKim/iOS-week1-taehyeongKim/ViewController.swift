//
//  ViewController.swift
//  iOS-week1-taehyeongKim
//
//  Created by 김태형 on 2020/05/09.
//  Copyright © 2020 김태형. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var blueView: UIView!
    @IBOutlet weak var tfpw: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var btnShowBlueView: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        blueView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(blueView)
        blueView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        blueView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        blueView.topAnchor.constraint(equalTo: self.tfpw.bottomAnchor).isActive = true
        blueView.bottomAnchor.constraint(equalTo: btnLogin.topAnchor).isActive = true
        blueView.isHidden = true
    }
    
    @IBAction func actionLogin(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SecondVC") as! SecondVC
//        vc.modalPresentationStyle = .fullScreen
//        vc.modalPresentationStyle = .formSheet
//        present(vc,animated: true)
//
        self.navigationController?.pushViewController(vc, animated: true)


    }
    
    @IBAction func actionSHow(_ sender: Any) {
        if blueView.isHidden == true{
            blueView.isHidden = false
            btnShowBlueView.setTitle("파란뷰 감추기", for: .normal)
        }else{
            blueView.isHidden = true
            btnShowBlueView.setTitle("파란뷰 보이기", for: .normal)
        }
    }
    

}

