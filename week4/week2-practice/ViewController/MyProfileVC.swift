//
//  MyProfileVC.swift
//  week2-practice
//
//  Created by TaeHyeong Kim on 2020/05/22.
//  Copyright © 2020 김태형. All rights reserved.
//

import UIKit

class MyProfileVC: UIViewController {
    
    @IBOutlet weak var lbSwitch: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var horizontalScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStoreImage()
        // Do any additional setup after loading the view.
        horizontalScrollView.delegate = self
    }
    
    func setUpStoreImage() {
        let images = [
                    "Image",
                    "ic_background_login",
                    "Image",
                    "ic_background_login"]
        pageControl.layoutIfNeeded()
        pageControl.numberOfPages = images.count
        for i in 0..<images.count{
            let imageView = UIImageView()
            imageView.image = UIImage(named: images[i])
            imageView.contentMode = .scaleAspectFill //  사진의 비율을 맞춤.
            imageView.clipsToBounds = true
            let xPosition = self.view.frame.width * CGFloat(i)
            
            imageView.frame = CGRect(x: xPosition, y: 0,
                                     width: self.horizontalScrollView.frame.width,
                                     height: self.horizontalScrollView.frame.height) // 즉 이미지 뷰가 화면 전체를 덮게 됨.
            horizontalScrollView.contentSize.width =
                self.view.frame.width * CGFloat(1+i)
            horizontalScrollView.addSubview(imageView)
            imageView.layoutIfNeeded()
        }
    }
    
    @IBAction func actionSwitch(_ sender: UISwitch) {
        if sender.isOn{
            lbSwitch.text = "스위치 켜짐"
        }else{
            lbSwitch.text = "스위치 꺼짐"
        }
    }
    @IBAction func actionSlider(_ sender: UISlider) {
        lbSwitch.text = "슬라이더 값 \(sender.value)"
    }
    @IBAction func actionStepper(_ sender: UIStepper) {
        lbSwitch.text = "stepper \(sender.value)"
    }
    @IBAction func actionActivityIndicator(_ sender: Any) {
        self.startActivityIndicator()
    }
    @IBAction func actionActivityStop(_ sender: Any) {
        self.stopActivityIndicator()
    }
}
extension MyProfileVC : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floor(scrollView.contentOffset.x / UIScreen.main.bounds.width))
    }
    
}
extension UIViewController {
    var activityIndicatorTag: Int { return 999999 }
    var loadingTag: Int{return 1234321}
}
extension UIViewController {
    func startActivityIndicator(style: UIActivityIndicatorView.Style = .large, location: CGPoint? = nil) {
        //Set the position - defaults to `center` if no`location`
        //argument is provided
        let loc = location ?? self.view.center
        //Ensure the UI is updated from the main thread
        //in case this method is called from a closure
        DispatchQueue.main.async {
//            //Create the activity indicator
            let activityIndicator = UIActivityIndicatorView(style: style)
            //Add the tag so we can find the view in order to remove it later

            activityIndicator.tag = self.activityIndicatorTag
            //Set the location

            activityIndicator.center = loc
            activityIndicator.hidesWhenStopped = true
            //Start animating and add the view

            activityIndicator.startAnimating()
            self.view.addSubview(activityIndicator)
            
            
            
//            let imageView = UIImageView(image: UIImage(named: "new_ic_loading"))
//            let animation = CABasicAnimation(keyPath: "transform.rotation")
//            animation.fromValue = 0
//            animation.toValue =  Double.pi * 2.0
//            animation.duration = 1.5
//            animation.repeatCount = .infinity
//            animation.isRemovedOnCompletion = false
//
//            imageView.layer.add(animation, forKey: "spin")
//            imageView.tag = self.loadingTag
//            imageView.center = loc
//            self.view.addSubview(imageView)
            
        }
    }
    
    func stopActivityIndicator() {
        //Again, we need to ensure the UI is updated from the main thread!
        DispatchQueue.main.async {
//            Here we find the `UIActivityIndicatorView` and remove it from the view
            if let activityIndicator = self.view.subviews.filter(
                { $0.tag == self.activityIndicatorTag}).first as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
            
            
            
//            if let loadingIndicator = self.view.subviews.filter(
//                { $0.tag == self.loadingTag}).first as? UIImageView {
//                loadingIndicator.stopAnimating()
//                loadingIndicator.removeFromSuperview()
//            }
            
            
        }
    }
}
