//
//  FriendListVC.swift
//  week2-practice
//
//  Created by 김태형 on 2020/05/16.
//  Copyright © 2020 김태형. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SDWebImage
import Kingfisher

class FriendListVC: UIViewController {
    
    
    @IBOutlet weak var friendListTableView: UITableView!
    @IBOutlet weak var lbFriend: UILabel!
    @IBOutlet var popupView: UIView!
    

    var friendArrayList = [FriendData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadUser()
        setupView()
        setUpData()
    }
    
    @IBAction func actionAddFriend(_ sender: Any) {
        if popupView.isHidden == true{
            popupView.isHidden = false
        }else{
            popupView.isHidden = true
        }
        print("press")
    }
    
    @IBAction func actionPopupClose(_ sender: Any) {
        popupView.isHidden = true
    }
    @IBAction func actionAddId(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddFriendByIdVC") as! AddFriendByIdVC
        vc.modalPresentationStyle = .overFullScreen
        present(vc,animated: true)
    }
    @IBAction func actionEditFriend(_ sender: Any) {
        let alert = UIAlertController(title: "유의사항", message: "도착 예정시간에 맞춰 음식을 준비하므로 \n\"꼭\" 늦지않게 주의해주세요. \n※ 매장측에서 주문 접수가 시작되면 \n환불이 불가합니다." , preferredStyle: .actionSheet)
        let OKAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: {
            (_)in
        })
        let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.default, handler: {
            (_)in
            self.dismiss(animated: true, completion: nil)
        })
        let thirdAction = UIAlertAction(title: "확인(다시보지않기)", style: UIAlertAction.Style.default, handler: {
            (_)in
            
        })
        alert.addAction(OKAction)
        alert.addAction(thirdAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func setupView(){
        friendListTableView.delegate = self
        friendListTableView.dataSource = self
        
        attributeText()
        
        
        popupView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(popupView)
        popupView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        popupView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        popupView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        popupView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        popupView.isHidden = true
        
        
        
        
    }
    func attributeText(){
        let labelText = lbFriend.text
        let strokeTextAttributes = [
            NSAttributedString.Key.strokeColor : UIColor.black,
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.strokeWidth : -2.0,
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18),
            ] as [NSAttributedString.Key : Any]
        
        lbFriend.attributedText = NSAttributedString(string: labelText!, attributes: strokeTextAttributes)
    }
    func setUpData(){
//        for index in 0..<20 {
//            let item = FriendData("홍길동\(index)", "상태 메시지 \(index)")
//            friendArrayList.append(item)
//        }
    }
    func showAlertMessage(vc: UIViewController, titleStr:String, messageStr:String) -> Void {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert);
        let action = UIAlertAction(title: "확인", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
    }
    
    
    func downloadUser(){
        print("download start")
        let url = "https://my.api.mockaroo.com/members_with_avatar.json?key=44ce18f0"
        Alamofire.request(url,method: .get)
            .validate().responseJSON { (response) in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
//                    print(json)

                    
                    let list: Array<JSON> = json.arrayValue
                    for index in 0..<list.count{
                        let item = list[index]
                        let name = item["name"].stringValue
                        let job = item["job"].stringValue
                        let imageURL = item["avatar"].stringValue
                        
                        let profile = FriendData(name,job,imageURL)
                        self.friendArrayList.append(profile)
                    
                        
                    }
                    
                    
                    self.friendListTableView.reloadData()
    
                    break
                case .failure(let err):
                    print(err)
                    break
                }
        }
    }
    
    
    
}
extension FriendListVC : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendArrayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendListTVC") as! FriendListTVC
        cell.selectionStyle = .none
        
        let item = friendArrayList[indexPath.row]
        cell.lbContent.text = item.content
        cell.lbName.text = item.name
        
//        print(item.imageURL!)
        
        guard let url = URL(string: item.imageURL!) else{
            print("paowiejfoiawjefoijaweoijweiojr")
            return cell
        }
        print(url)
    
//        cell.imageView?.sd_setImage(with: url, completed: nil)
//        cell.imageView?.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
        let imageresurce = ImageResource(downloadURL: url)
        cell.imageView!.kf.setImage(with: imageresurce)
//        cell.imageView!.kf.setImage(with: url, placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        let vc = storyboard?.instantiateViewController(withIdentifier: "FriendDetailVC") as? FriendDetailVC
        vc?.modalPresentationStyle = .overFullScreen
        present(vc!,animated: true)
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

