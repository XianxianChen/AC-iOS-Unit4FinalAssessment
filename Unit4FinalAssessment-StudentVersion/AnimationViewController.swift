//
//  AnimationViewController.swift
//  Unit4FinalAssessment-StudentVersion
//
//  Created by C4Q  on 1/11/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
enum ButtonState: String {
    case start = "start"
    case pause = "pause"
}
class AnimationViewController: UIViewController {
    let animationView = CustomAnimationView()
    var currentAnimation: String! = "Width Multiplier"
    var buttonState = ButtonState.start
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.9, alpha: 1.0)
        self.view.addSubview(animationView)
        self.animationView.button.setTitle("start", for: .normal)
        setupAniamtionView()
        self.animationView.pickerView.delegate = self
         self.animationView.pickerView.dataSource = self
        
        animationView.button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
   @objc func buttonPressed() {
        switch self.buttonState{
        case .start:
            self.animateSnowMan()
            self.animationView.imageView.startAnimating()
              self.animationView.button.setTitle("pause", for: .normal)
            self.buttonState = .pause
        case .pause:
            self.animationView.imageView.stopAnimating()
            let animator = UIViewPropertyAnimator()
            animator.stopAnimation(true)
            self.animationView.imageView.layoutIfNeeded()
              self.animationView.button.setTitle("start", for: .normal)
            self.buttonState = .start
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.animationView.pickerView.reloadAllComponents()
    }
    func setupAniamtionView() {
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        animationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        animationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        animationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
     func animateSnowMan() {
        
        if currentAnimation == "Default" {
            defaultAnimate()
        } else {
            if let valArr = Model.manager.getVals()[currentAnimation] {
                customAnimation(offSetfrom: valArr[2], y: valArr[3], scaleX: valArr[0], scaleY: valArr[1], numOfFlip: valArr[4])
            }
        }
//        switch currentAnimation {
//        case "Width Multiplier":
//            customAnimation(offSetfrom: -50, y: -50, scaleX: 1.5, scaleY: 1.5, numOfFlip: 3)
//            //defaultAnimate()
//        default:
//            defaultAnimate()
//        }
        
    }
    
}

extension AnimationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Model.manager.getSettings().count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       return Model.manager.getSettings()[row]
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.currentAnimation = Model.manager.getSettings()[row]
    }
}
extension AnimationViewController {
    
 
//  let widthMultiplierVal = UserDefaults.standard.value(forKey: <#T##String#>)
    
    func defaultAnimate() {
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.x") //*** ketPath must be the exact right string. it's set by default, not custom. ***
        
        let angleRadian = CGFloat(.pi * 2.0 )// 360
        
        animation.fromValue = 0 // degree
        animation.byValue = angleRadian
        animation.duration = 4.0 //seconds
        animation.repeatCount = Float.infinity
        animationView.imageView.layer.add(animation, forKey: nil)
        
}
    
    func customAnimation(offSetfrom x: Double, y: Double, scaleX: Double, scaleY: Double, numOfFlip: Double) {
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.x") //*** ketPath must be the exact right string. it's set by default, not custom. ***
        
        let angleRadian = CGFloat(.pi * 2.0 )// 360
      
        animation.fromValue = 0 // degree
        animation.byValue = angleRadian
        animation.duration = 4.0 //seconds
        animation.repeatCount = Float(numOfFlip)
        animationView.imageView.layer.add(animation, forKey: nil)
        
        let origianlPosition: CGRect = self.animationView.imageView.frame
        
        let finalPosition = origianlPosition.offsetBy(dx: CGFloat(x), dy: CGFloat(y))
        UIView.animate(withDuration: 4.0, animations: {
            self.animationView.imageView.frame = finalPosition
            self.animationView.imageView.transform = CGAffineTransform(scaleX: CGFloat(scaleX), y: CGFloat(scaleY))
        }){(success) in
            print("")
        }
    }
    
    
}
/*
   self.box.transform = CGAffineTransform(rotationAngle: CGFloat.pi).scaledBy(x: 0.1, y: 0.1)
 */
/*
 
 UIView.animate(withDuration: 3.0, animations: {
 self.squareView.frame = finalPosition
 self.squareView.backgroundColor = .yellow
 // let translate = CGAffineTransform(translationX: 20, y: 50)
 // let rotate = CGAffineTransform(rotationAngle: CGFloat.pi * 2)
 // let scale = CGAffineTransform(scaleX: 0.2, y: 0.2)
 //  self.squareView.transform = translate.concatenating(rotate)
 }) { (success) in
 self.animateButtonOutlet.isEnabled = true
 }
 */
 
 
/*
 var widthConstraint = NSLayoutConstraint()
 var centerXConstraint = NSLayoutConstraint()
 widthConstraint.isActive = false
 widthConstraint = viewToAnimate.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
 widthConstraint.isActive = true
 centerXConstraint.constant = -100
       propertyAnimator.addAnimations {
 self.view.layoutIfNeeded() // put in animation to change the layout slowly
 
 }        propertyAnimator.startAnimation()
 
 */
 
 
 
 
 
