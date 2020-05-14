//
//  FriendListVC.swift
//  week2
//
//  Created by 김태형 on 2020/05/14.
//  Copyright © 2020 김태형. All rights reserved.
//

import UIKit

class FriendListVC: UIViewController {
    
    @IBOutlet weak var friendTableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    
    var dataForTable = [FriendData]()
    var selectedIndexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    func setupView(){
        friendTableView.delegate = self
        friendTableView.dataSource = self
    }
    
    func showAlertMessage(vc: UIViewController, titleStr:String, messageStr:String) -> Void {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert);
        let action = UIAlertAction(title: "확인", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
    }

}
extension FriendListVC : UITableViewDataSource, UITableViewDelegate{
//    //sections
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
//        let label = UILabel()
//        label.frame = CGRect.init(x: 0, y: 0, width: headerView.frame.width, height: headerView.frame.height)
//        label.text = "     \(section)"
//        label.font = UIFont.boldSystemFont(ofSize: 18)
//        label.textColor = UIColor.black
//        label.backgroundColor = UIColor(red: 0.88, green: 0.88, blue: 0.88, alpha: 1.0)
//
//        headerView.addSubview(label)
//        return headerView
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendListTVC") as! FriendListTVC
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FriendDetailVC") as? FriendDetailVC
        vc?.modalPresentationStyle = .overFullScreen
        present(vc!,animated: true)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y == 0) {
            headerView.layer.addBorder([.bottom], color: .white, width: 1)
            print("top")
        }else{
            headerView.layer.addBorder([.bottom], color: .gray, width: 1)
            print("not top")
        }
        
        
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title:  "차단", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            // Call edit action
            // Reset state
            success(true)
            self.showAlertMessage(vc: self, titleStr: "차단", messageStr: "\(indexPath)")

        })
        
        let shareAction = UIContextualAction(style: .normal, title:  "숨김", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            // Call edit action
            // Reset state
            success(true)
            self.showAlertMessage(vc: self, titleStr: "숨김", messageStr: "\(indexPath)")
        })
        return UISwipeActionsConfiguration(actions:[deleteAction,shareAction])
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let starAction = UIContextualAction(style: .destructive, title:  "즐겨찾기", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            success(true)
            self.showAlertMessage(vc: self, titleStr: "즐겨찾기", messageStr: "\(indexPath)")
            
        })
        starAction.image = UIImage(systemName: "star")
        starAction.backgroundColor = .lightGray
        return UISwipeActionsConfiguration(actions: [starAction])
    }
    
    
    
}
extension CALayer {
    //전에 layout if needed 해야함
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}
extension FriendDetailVC {

    class  FriendData {
        var title: String? // Title for a row
        var content: [String]? // Content after row selection
        init (_ str: String?){ // Takes row title in initialisation
            title = str
        }
    }

}
