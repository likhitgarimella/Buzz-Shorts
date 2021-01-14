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
        
        SideMenuProp()
        AddChildControllers()
        
    }
    
    private func AddChildControllers() {
        
        addChild(indiaController)
        addChild(worldController)
        
        view.addSubview(indiaController.view)
        view.addSubview(worldController.view)
        
        indiaController.view.frame = view.bounds
        worldController.view.frame = view.bounds
        
        /// View Controller Lifecycle
        indiaController.didMove(toParent: self)
        worldController.didMove(toParent: self)
        
        indiaController.view.isHidden = true
        worldController.view.isHidden = true
        
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
    
}   // #114
