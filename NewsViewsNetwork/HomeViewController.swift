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
    
    func SideMenuProp() {
        
        let menu = MenuController(with: ["Home", "India", "World", "Finance", "Tech", "Auto", "Sports", "Entertainment", "Health", "Lifestyle", "Travel", "Astro"])
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
    
    func didSelectMenuItem(named: String) {
        
        sideMenu?.dismiss(animated: true, completion: { [weak self] in
            
            self?.title = named
            
            if named == "Home" {
                self?.indiaController.view.isHidden = true
                self?.worldController.view.isHidden = true
            }
            else if named == "India" {
                self?.indiaController.view.isHidden = false
                self?.worldController.view.isHidden = true
            }
            else if named == "World" {
                self?.indiaController.view.isHidden = true
                self?.worldController.view.isHidden = false
            }
            /*
            else if named == "Finance" {
                self?.view.backgroundColor = .white
            }
            else if named == "Tech" {
                self?.view.backgroundColor = .blue
            }
            else if named == "Auto" {
                self?.view.backgroundColor = .green
            }
            else if named == "Sports" {
                self?.view.backgroundColor = .white
            }
            else if named == "Entertainment" {
                self?.view.backgroundColor = .blue
            }
            else if named == "Health" {
                self?.view.backgroundColor = .green
            }
            else if named == "Lifestyle" {
                self?.view.backgroundColor = .white
            }
            else if named == "Travel" {
                self?.view.backgroundColor = .blue
            }
            else if named == "Astro" {
                self?.view.backgroundColor = .green
            }
            */
            
        })
        
    }
    
}   // #116
