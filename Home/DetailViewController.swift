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
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLbl2: UILabel!
    @IBOutlet weak var readTime: UILabel!
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var body: UILabel!
    
    var url = ""
    var name = ""
    var time = ""
    var head = ""
    var desc = ""
    
    func Properties() {
        
        heading.numberOfLines = 0
        heading.contentMode = .topLeft
        heading.sizeToFit()
        body.numberOfLines = 0
        body.contentMode = .topLeft
        body.sizeToFit()
        
    }
    
    func Function() {
        
        nameLbl1.text = name.capitalized
        nameLbl2.text = name
        readTime.text = time
        heading.text = head
        body.text = desc
        
        let photoUrl = URL(string: url)
        image.sd_setImage(with: photoUrl)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        view.backgroundColor = .white
        
        Properties()
        Function()
        
    }
    
}   // #62
