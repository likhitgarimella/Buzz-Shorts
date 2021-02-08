//
//  DetailViewController.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 08/02/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // print(name)
        lbl.text = name.capitalized
        // img.image = UIImage(named: name)
        
    }
    
}   // #28
