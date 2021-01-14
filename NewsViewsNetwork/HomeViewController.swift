//
//  HomeViewController.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 16/12/20.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController, MenuControllerDelegate {
    
    private var sideMenu: SideMenuNavigationController?
    
    private let indiaController = IndiaViewController()
    private let worldController = WorldViewController()
    private let financeController = FinanceViewController()
    private let techController = TechViewController()
    private let autoController = AutoViewController()
    private let sportsController = SportsViewController()
    private let entertainmentController = EntertainmentViewController()
    private let healthController = HealthViewController()
    private let lifestyleController = LifestyleViewController()
    private let travelController = TravelViewController()
    private let astroController = AstroViewController()
    
    func SideMenuProp() {
        
        let menu = MenuController(with: SideMenuItem.allCases)
        menu.delegate = self
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        SideMenuProp()
        AddChildControllers()
        
    }
    
    private func AddChildControllers() {
        
        addChild(indiaController)
        addChild(worldController)
        addChild(financeController)
        addChild(techController)
        addChild(autoController)
        addChild(sportsController)
        addChild(entertainmentController)
        addChild(healthController)
        addChild(lifestyleController)
        addChild(travelController)
        addChild(astroController)
        
        view.addSubview(indiaController.view)
        view.addSubview(worldController.view)
        view.addSubview(financeController.view)
        view.addSubview(techController.view)
        view.addSubview(autoController.view)
        view.addSubview(sportsController.view)
        view.addSubview(entertainmentController.view)
        view.addSubview(healthController.view)
        view.addSubview(lifestyleController.view)
        view.addSubview(travelController.view)
        view.addSubview(astroController.view)
        
        indiaController.view.frame = view.bounds
        worldController.view.frame = view.bounds
        financeController.view.frame = view.bounds
        techController.view.frame = view.bounds
        autoController.view.frame = view.bounds
        sportsController.view.frame = view.bounds
        entertainmentController.view.frame = view.bounds
        healthController.view.frame = view.bounds
        lifestyleController.view.frame = view.bounds
        travelController.view.frame = view.bounds
        astroController.view.frame = view.bounds
        
        /// View Controller Lifecycle
        indiaController.didMove(toParent: self)
        worldController.didMove(toParent: self)
        financeController.didMove(toParent: self)
        techController.didMove(toParent: self)
        autoController.didMove(toParent: self)
        sportsController.didMove(toParent: self)
        entertainmentController.didMove(toParent: self)
        healthController.didMove(toParent: self)
        lifestyleController.didMove(toParent: self)
        travelController.didMove(toParent: self)
        astroController.didMove(toParent: self)
        
        /// Keep all hidden initially
        indiaController.view.isHidden = true
        worldController.view.isHidden = true
        financeController.view.isHidden = true
        techController.view.isHidden = true
        autoController.view.isHidden = true
        sportsController.view.isHidden = true
        entertainmentController.view.isHidden = true
        healthController.view.isHidden = true
        lifestyleController.view.isHidden = true
        travelController.view.isHidden = true
        astroController.view.isHidden = true
        
    }
    
    @IBAction func didTapMenuButton() {
        
        present(sideMenu!, animated: true)
        
    }
    
    func didSelectMenuItem(named: SideMenuItem) {
        
        sideMenu?.dismiss(animated: true, completion: { [weak self] in
            
            self?.title = named.rawValue
            
            switch named {
            
            case .home:
                self?.indiaController.view.isHidden = true
                self?.worldController.view.isHidden = true
            case .india:
                self?.indiaController.view.isHidden = false
                self?.worldController.view.isHidden = true
            case .world:
                self?.indiaController.view.isHidden = true
                self?.worldController.view.isHidden = false
            case .finance:
                //
            case .tech:
                //
            case .auto:
                //
            case .sports:
                //
            case .entertainment:
                //
            case .health:
                //
            case .lifestyle:
                //
            case .travel:
                //
            case .astro:
                //
            }
            
        })
        
    }
    
}   // #162
