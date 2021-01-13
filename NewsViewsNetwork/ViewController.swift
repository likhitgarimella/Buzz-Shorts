//
//  ViewController.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 16/12/20.
//

import UIKit
import SideMenu

class ViewController: UIViewController, MenuControllerDelegate {
    
    private var sideMenu: SideMenuNavigationController?
    
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
        
    }
    
    @IBAction func didTapMenuButton() {
        
        present(sideMenu!, animated: true)
        
    }
    
    func didSelectMenuItem(named: String) {
        
        sideMenu?.dismiss(animated: true, completion: { [weak self] in
            
            if named == "Home" {
                self?.view.backgroundColor = .white
            }
            else if named == "India" {
                self?.view.backgroundColor = .purple
            }
            else if named == "World" {
                self?.view.backgroundColor = .blue
            }
            else if named == "Finance" {
                self?.view.backgroundColor = .green
            }
            else if named == "Tech" {
                self?.view.backgroundColor = .yellow
            }
            else if named == "Auto" {
                self?.view.backgroundColor = .red
            }
            else if named == "Sports" {
                self?.view.backgroundColor = .white
            }
            else if named == "Entertainment" {
                self?.view.backgroundColor = .purple
            }
            else if named == "Health" {
                self?.view.backgroundColor = .blue
            }
            else if named == "Lifestyle" {
                self?.view.backgroundColor = .green
            }
            else if named == "Travel" {
                self?.view.backgroundColor = .yellow
            }
            else if named == "Astro" {
                self?.view.backgroundColor = .red
            }
            
        })
        
    }
    
}   // #85
