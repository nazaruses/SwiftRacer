//
//  MainViewController.swift
//  Swift Racer
//
//  Created by Nazar Dremach on 29/7/23.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var greetingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(updateUserName(_:)),
            name: NSNotification.Name("updateUserName"),
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    func updateUserName(_ notification: Notification) {
        var username = "User"
        if let newName = notification.userInfo?["username"] as? String {
            username = newName
        }
        
        greetingLabel.text = "Hi, \(username)!"
    }
        
        @IBAction func startRace(_ sender: Any) {
            
            let destination  = RaceViewController()
            navigationController?.pushViewController(destination, animated: true)
        }
    }

