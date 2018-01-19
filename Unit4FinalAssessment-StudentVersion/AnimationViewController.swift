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
    case resume = "resume"
}
class AnimationViewController: UIViewController {
    let animationView = CustomAnimationView()
    var currentAnimation: String! = "Default"
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
            animationView.imageView.layer.removeAllAnimations()
            self.animateSnowMan()
             animationView.pickerView.isHidden = true
            
              self.animationView.button.setTitle("pause", for: .normal)
            self.buttonState = .pause
        case .pause:
            pause(layer: animationView.imageView.layer)
            
              self.animationView.button.setTitle("resume", for: .normal)
            self.buttonState = .resume
        case .resume:
             resume(layer: animationView.imageView.layer)
            self.animationView.button.setTitle("pause", for: .normal)
            self.buttonState = .pause
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
        animationView.imageView.layer.removeAllAnimations()
        if currentAnimation == "Default" {
            defaultAnimate()
        } else {
            if let valArr = Model.manager.getVals()[currentAnimation] {
                customAnimation(offSetfrom: valArr[2], y: valArr[3], scaleX: valArr[0], scaleY: valArr[1], numOfFlip: valArr[4], duration: valArr[5])
            }
        }

        
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
    
    func pause(layer: CALayer) {
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0
        layer.timeOffset = pausedTime
    }
    
    func resume(layer: CALayer) {
        let pausedTime = layer.timeOffset
        layer.speed = 1
        layer.timeOffset = 0
        layer.beginTime = 0
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }
//  let widthMultiplierVal = UserDefaults.standard.value(forKey: <#T##String#>)
    
    func defaultAnimate() {
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.x") //*** ketPath must be the exact right string. it's set by default, not custom. ***
        animation.delegate = self
        let angleRadian = CGFloat(.pi * 2.0 )// 360
        
        animation.fromValue = 0 // degree
        animation.byValue = angleRadian
        animation.duration = 4.0 //seconds
        animation.repeatCount = 1.0
        animationView.imageView.layer.add(animation, forKey: nil)
        
}
    
    func customAnimation(offSetfrom x: Double, y: Double, scaleX: Double, scaleY: Double, numOfFlip: Double, duration: Double) {
       
        let rotationX = CABasicAnimation(keyPath: "transform.rotation.x") //*** ketPath must be the exact right string. it's set by default, not custom. ***
        rotationX.delegate = self
        let angleRadian = CGFloat(.pi * 2.0 )// 360
        rotationX.fromValue = 0 // degree
        rotationX.byValue = angleRadian
        rotationX.duration = duration //seconds
        rotationX.repeatCount = Float(numOfFlip)
        
        let rotationY = CABasicAnimation(keyPath: "transform.rotation.y")
        rotationY.delegate = self
        rotationY.fromValue = 0
        rotationY.byValue = angleRadian
        rotationY.duration = duration
        rotationY.repeatCount = Float(numOfFlip)
        
        let rotationZ = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationZ.delegate = self
        rotationZ.fromValue = 0
        rotationZ.byValue = angleRadian
        rotationZ.duration = duration
        rotationZ.repeatCount = Float(numOfFlip)
        
       let animationScale = CABasicAnimation(keyPath: "transform.scale")
        animationScale.delegate = self
        animationScale.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        let fromValue = CATransform3DMakeScale(1, 1, 0)
        let toValue = CATransform3DMakeScale(CGFloat(scaleX), CGFloat(scaleY), 0)
       animationScale.fromValue = fromValue
        animationScale.toValue = toValue
        animationScale.duration = duration
        animationScale.repeatCount = Float(numOfFlip)
        
    
        let positionAnimation = CABasicAnimation(keyPath: "position")
        positionAnimation.delegate = self
        positionAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        positionAnimation.fromValue = self.animationView.imageView.layer.position
        positionAnimation.toValue = CGPoint(x: (self.animationView.imageView.layer.position.x + CGFloat(x)), y: (self.animationView.imageView.layer.position.y + CGFloat(y)))
        positionAnimation.duration = duration
        positionAnimation.repeatCount = Float(numOfFlip)
        
        
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.delegate = self
        groupAnimation.animations = [rotationX, animationScale, positionAnimation]
        groupAnimation.duration = duration
        self.animationView.imageView.layer.add(groupAnimation, forKey: nil)
        
         print(x, y,scaleX, scaleY, numOfFlip, duration)
        // final values
      // self.animationView.imageView.layer.position = CGPoint(x: x, y: y)//self.animationView.imageView.layer.position

    
    
    }
}
extension AnimationViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.animationView.button.setTitle("start", for: .normal)
        self.buttonState = .start
        animationView.pickerView.isHidden = false
        
    }
}
/*
   self.box.transform = CGAffineTransform(rotationAngle: CGFloat.pi).scaledBy(x: 0.1, y: 0.1)
 
 //        let otherAnimation = UIViewPropertyAnimator(duration: 4.0, curve: UIViewAnimationCurve.easeIn) {
 //
 //            self.animationView.imageView.transform = CGAffineTransform(scaleX: CGFloat(scaleX), y: CGFloat(scaleY)).translatedBy(x: CGFloat(x), y: CGFloat(x))
 //        }
 
 
 //        otherAnimation.addCompletion({_ in
 //
 //            self.animationView.imageView.layer.transform = CATransform3DMakeAffineTransform(self.animationView.imageView.transform)
 //
 //        })
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
 
 }
 propertyAnimator.startAnimation()
 
 */
 
 
 
 
 
