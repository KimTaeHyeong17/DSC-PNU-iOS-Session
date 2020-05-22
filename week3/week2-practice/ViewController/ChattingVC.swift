//
//  ChattingVC.swift
//  week2-practice
//
//  Created by TaeHyeong Kim on 2020/05/22.
//  Copyright © 2020 김태형. All rights reserved.
//

import UIKit

class ChattingVC: UIViewController {
    
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    
    @IBOutlet weak var segView: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    private func setupView(){
        view1.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view1)
        view1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        view1.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        view1.topAnchor.constraint(equalTo: self.segView.bottomAnchor).isActive = true
        view1.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        view1.isHidden = false
        
        view2.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view2)
        view2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        view2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        view2.topAnchor.constraint(equalTo: self.segView.bottomAnchor).isActive = true
        view2.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        view2.isHidden = true
        
    }
    
    
    @IBAction func segChangedAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            view1.isHidden = false
            view2.isHidden = true

        case 1:
            view1.isHidden = true
            view2.isHidden = false

        default:
            break;
        }
    }
    
    
    
}

