//
//  RaceViewController.swift
//  Swift Racer
//
//  Created by Nazar Dremach on 29/7/23.
//

import UIKit

class RaceViewController: UIViewController {
   // MARK: - Additional Types
    enum ElementPosition {
        case left, center,right
    }
    // MARK: - UI ELEMENTS
    @IBOutlet weak var carPositionSegmentControl: UISegmentedControl!
    
    var carImage = UIImageView(image: UIImage(named: "raceCar"))
    var treeImage = UIImageView(image: UIImage(named: "tree"))
    var rockImage = UIImageView(image: UIImage(named: "rock"))
    
    //MARK: - Coordinates
    var screenWidth: CGFloat = 0
    var screenHeight: CGFloat = 0
    var bottomSafeAreaPadding: CGFloat = 0
    var topSafeAreaPadding: CGFloat = 0
    var navigationBarHeight: CGFloat = 0
    
    var leftOriginCoordinate: CGFloat = 0
    var centerOriginCoordinate: CGFloat = 0
    var rightOriginCoordinate: CGFloat = 0
    
    var elementSize: CGFloat = 0
    var defaultPadding:CGFloat = 20
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        setupCoordinates()
        setupFrames()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(
            withDuration: 5,
            animations: { [weak self] in
                self?.rockImage.frame.origin.y = self?.screenHeight ?? 0
            },
            completion: { [weak self] _ in
                self?.setupFrames()
            }
        )
        
    }
    
    //MARK: - Setup Views
    func setupCoordinates() {
        screenWidth = view.frame.size.width
        screenHeight = view.frame.size.height
        bottomSafeAreaPadding = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        topSafeAreaPadding = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
        navigationBarHeight = navigationController?.navigationBar.frame.size.height ?? 0
        
        elementSize = screenWidth / 4
        leftOriginCoordinate = elementSize / 4
        centerOriginCoordinate = elementSize + 2 * leftOriginCoordinate
        rightOriginCoordinate = 2 * elementSize + 3 * leftOriginCoordinate
    }
    func setupFrames() {
        carPositionSegmentControl.selectedSegmentIndex = 1
        setupCar()
        setupTree()
        setupRock()
    }
    
    func setupCar() {
        let yCoordinatedOfCar = screenHeight - bottomSafeAreaPadding - defaultPadding - elementSize
        carImage.frame = CGRect(x: centerOriginCoordinate,
                                y: yCoordinatedOfCar,
                                width: elementSize,
                                height: elementSize)
        
        carImage.layer.shadowColor = UIColor.white.cgColor
        carImage.layer.shadowOpacity = 1
        carImage.layer.shadowOffset = .zero
        carImage.layer.shadowRadius = 10
        
        view.addSubview(carImage)
        
    }
    
    func setupTree() {
        let yCoordinateOfTree = (screenHeight - elementSize) / 2
        treeImage.frame = CGRect(x: leftOriginCoordinate,
                                 y: yCoordinateOfTree,
                                 width: elementSize,
                                 height: elementSize)
        
        view.addSubview(treeImage)
    }
    
    func setupRock() {
        let yCoordinateOfRock = topSafeAreaPadding + navigationBarHeight + defaultPadding
        rockImage.frame = CGRect(x: rightOriginCoordinate,
                                 y: yCoordinateOfRock,
                                 width: elementSize,
                                 height: elementSize)
        
        view.addSubview(rockImage)
    }
    //MARK: - Moves
    @IBAction func changeCarPosition(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            moveCarTo(.left)
            moveRockTo(.center)
            moveTreeTo(.right)
        case 2:
            moveRockTo(.left)
            moveTreeTo(.center)
            moveCarTo(.right)
        default:
            moveTreeTo(.left)
            moveCarTo(.center)
            moveRockTo(.right)
        }
    }
    func moveCarTo(_ position: ElementPosition) {
        switch position {
        case .left:
            carImage.frame.origin.x = leftOriginCoordinate
        case .center:
            carImage.frame.origin.x = centerOriginCoordinate
        case .right:
            carImage.frame.origin.x = rightOriginCoordinate
        }
    }
    
    func moveTreeTo(_ position: ElementPosition) {
        switch position {
        case .left:
            treeImage.frame.origin.x = leftOriginCoordinate
        case .center:
            treeImage.frame.origin.x = centerOriginCoordinate
        case .right:
            treeImage.frame.origin.x = rightOriginCoordinate
        }
    }
    
    func moveRockTo(_ position: ElementPosition) {
        switch position {
        case .left:
            rockImage.frame.origin.x = leftOriginCoordinate
        case .center:
            rockImage.frame.origin.x = centerOriginCoordinate
        case .right:
            rockImage.frame.origin.x = rightOriginCoordinate
        }
    }
}
