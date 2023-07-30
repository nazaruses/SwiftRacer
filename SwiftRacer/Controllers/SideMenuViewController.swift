//
//  SideMenuViewController.swift
//  Swift Racer
//
//  Created by Nazar Dremach on 30/7/23.
//

import UIKit

class SideMenuViewController: UIViewController {

    let ball = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    
    let panGesture = UIPanGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        panGesture.addTarget(self, action: #selector(pan))
        
        ball.backgroundColor = .red
        ball.isHidden = true
        ball.layer.cornerRadius = 10
        
        view.addSubview(ball)
        
        let lSwipe = UISwipeGestureRecognizer()
        lSwipe.direction = .left
        lSwipe.addTarget(self, action: #selector(swipe))
        
        let rSwipe = UISwipeGestureRecognizer()
        rSwipe.direction = .right
        rSwipe.addTarget(self, action: #selector(swipe))
        
        view.addGestureRecognizer(lSwipe)
        view.addGestureRecognizer(rSwipe)

    }
    
    @objc func pan(sender: UIPanGestureRecognizer) {
        ball.isHidden = false
        ball.center = sender.location(in: view)
        if sender.state == .ended{
            ball.isHidden = true
        }
    }
    
    @objc
    func swipe(sender: UISwipeGestureRecognizer) {
       
        switch sender.direction {
        case .left:
            print("L")
        case .right:
            print("R")
        default:
            break
        }
    }
   
    @IBAction func switchTouches(_ sender: UISwitch) {
        if sender.isOn {
            view.addGestureRecognizer(panGesture)
        } else {
            view
                .removeGestureRecognizer(panGesture)
        }
    }
}
