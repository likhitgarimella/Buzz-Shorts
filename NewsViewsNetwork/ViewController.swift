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
    
}

protocol MenuControllerDelegate {
    
    func didSelectMenuItem(named: String)
    
}

class MenuController: UITableViewController {
    
    public var delegate: MenuControllerDelegate?
    
    private let menuItems: [String]
    
    init(with menuItems: [String]) {
        self.menuItems = menuItems
        super.init(nibName: nil, bundle: nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .white
        view.backgroundColor = .white
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row]
        cell.textLabel?.textColor = .darkGray
        cell.backgroundColor = .white
        cell.contentView.backgroundColor = .white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        /// Relay to delegate about menu item selection
        let selectedItem = menuItems[indexPath.row]
        delegate?.didSelectMenuItem(named: selectedItem)
    }
    
}   // #137
