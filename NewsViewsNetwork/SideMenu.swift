//
//  SideMenu.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 13/01/21.
//

import Foundation
import UIKit

protocol MenuControllerDelegate {
    func didSelectMenuItem(named: SideMenuItem)
}

enum SideMenuItem: String, CaseIterable {
    case home = "Home"
    case india = "India"
    case world = "World"
    case finance = "Finance"
    case tech = "Tech"
    case auto = "Auto"
    case sports = "Sports"
    case entertainment = "Entertainment"
    case health = "Health"
    case lifestyle = "Lifestyle"
    case travel = "Travel"
    case astro = "Astro"
    case property = "Property"
    case education = "Education"
    case food = "Food"
    case environment = "Environment"
    case offbeat = "Offbeat News"
    case topten = "Top Ten"
    case stories = "Stories"
    case diy = "DIY"
    case moodfresh = "Moodfresh"
    case hot = "Hot from the Oven"
    case gaming = "Gaming"
    case jobs = "Jobs & Job Alerts"
    case photo = "Photo Gallery"
    case videos = "Videos"
    case miscellany = "Miscellany"
}

class MenuController: UITableViewController {
    
    public var delegate: MenuControllerDelegate?
    
    private let menuItems: [SideMenuItem]
    
    init(with menuItems: [SideMenuItem]) {
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
        cell.textLabel?.text = menuItems[indexPath.row].rawValue
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
    
}   // #90
