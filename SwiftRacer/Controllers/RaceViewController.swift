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
    
    var carImage = UIImageView(image: UIImage(named: "raceCar"))
    var treeImage = UIImageView(image: UIImage(named: "tree"))
    var rockImage = UIImageView(image: UIImage(named: "rock"))
    
    //MARK: - Coordinates
    var screenWidth: CGFloat = 0
    var screenHeight: CGFloat = 0
    var bottomSafeAreaPadding: CGFloat = 0
    var topSafeAreaPadding: CGFloat = 0
    var navigationBarHeight: CGFloat = 0
    
    let treeTopSpacing: CGFloat = 200
    let rockTopSpasing: CGFloat = 50
    let treeBottomSpacing: CGFloat = 700
    let rockBottomSpacing: CGFloat = 200
    
    let obstaclesSpeed: Double = 300
    
    var leftOriginCoordinate: CGFloat = 0
    var centerOriginCoordinate: CGFloat = 0
    var rightOriginCoordinate: CGFloat = 0
    
    var carPosition = ElementPosition.center
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
        animateObstacles()
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
        
        // Gestures
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(carSwipeGesture))
        leftSwipe.direction = .left
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(carSwipeGesture))
        rightSwipe.direction = .right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
        view.addSubview(carImage)
        
    }
    
    func setupTree() {
        let yCoordinateOfTree = -elementSize - treeTopSpacing
        treeImage.frame = CGRect(x: leftOriginCoordinate,
                                 y: yCoordinateOfTree,
                                 width: elementSize,
                                 height: elementSize)
        
        view.addSubview(treeImage)
    }
    
    func setupRock() {
        let yCoordinateOfRock = -elementSize - rockTopSpasing
        rockImage.frame = CGRect(x: rightOriginCoordinate,
                                 y: yCoordinateOfRock,
                                 width: elementSize,
                                 height: elementSize)
        
        view.addSubview(rockImage)
    }
    //MARK: - Moves
    
    @objc
    func carSwipeGesture(sender: UISwipeGestureRecognizer) {
        let destinationPosition: ElementPosition
        if sender.direction == .left {
            switch carPosition {
            case .left, .center:
                destinationPosition = .left
            case .right:
                destinationPosition = .center
            }
        } else  {
            switch carPosition {
            case .right, .center:
                destinationPosition = .right
            case .left:
                destinationPosition = .center
            }
        }
            moveCarTo(destinationPosition)
    }
    
    func moveCarTo(_ position: ElementPosition) {
        let destinationCoordinate: CGFloat
        switch position {
        case .left:
            destinationCoordinate = leftOriginCoordinate
        case .center:
            destinationCoordinate = centerOriginCoordinate
        case .right:
            destinationCoordinate = rightOriginCoordinate
        }
        carPosition = position
        
        UIView.animate(
            withDuration: 0.3,
            animations: { [weak self] in
                self?.carImage.frame.origin.x = destinationCoordinate
        }
                       )
        
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
    
    func animateObstacles() {
        let treeS = screenHeight + treeTopSpacing + treeBottomSpacing
        let rockS = screenHeight + rockTopSpasing + rockBottomSpacing
        
        let treeT = Double(treeS) / obstaclesSpeed
        let rockT = Double(rockS) / obstaclesSpeed
        
        UIView.animate(withDuration: treeT, delay: 0, options: [.curveLinear, .repeat]) { [weak self] in
            self?.treeImage.frame.origin.y = (self?.screenHeight ?? 1000) + (self?.treeBottomSpacing ?? 0)
        }
        UIView.animate(withDuration: rockT, delay: 0, options: [.curveLinear, .repeat]) { [weak self] in
            self?.rockImage.frame.origin.y = (self?.screenHeight ?? 1000) + (self?.rockBottomSpacing ?? 0)
        }
    }
}
