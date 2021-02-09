//
//  DetailViewController.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 08/02/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var nameLbl1: UILabel!
    @IBOutlet weak var nameLbl2: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    var name = ""
    
    func Properties() {
        
        heading.numberOfLines = 0
        body.numberOfLines = 0
        body.contentMode = .topLeft
        body.sizeToFit()
        
    }
    
    func Function() {
        
        nameLbl1.text = name.capitalized
        nameLbl2.text = name
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        view.backgroundColor = .white
        
        Properties()
        Function()
        
    }
    
}   // #50
