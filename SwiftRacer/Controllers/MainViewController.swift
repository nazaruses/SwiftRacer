//
//  MainViewController.swift
//  Swift Racer
//
//  Created by Nazar Dremach on 29/7/23.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func startRace(_ sender: Any) {
        
        let destination  = RaceViewController()
        navigationController?.pushViewController(destination, animated: true)
    }
    
}
