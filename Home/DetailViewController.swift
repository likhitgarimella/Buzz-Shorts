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
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var nameLbl2: UILabel!
    @IBOutlet weak var readTime: UILabel!
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    var photourl = ""
    
    var name = ""
    var time = ""
    var head = ""
    var desc = ""
    var url = ""
    
    // private let shareURLString = "https://ayecracy.com"
    
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
        urlLabel.text = url
        
        let photoUrl = URL(string: photourl)
        newsImage.sd_setImage(with: photoUrl)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        view.backgroundColor = .white
        
        Properties()
        Function()
        
    }
    
    @IBAction func sharePressed(_ sender: UIButton) {
        
        let taptic = UIImpactFeedbackGenerator(style: .medium)
        taptic.prepare()
        taptic.impactOccurred()
        
        let activityVC = UIActivityViewController(activityItems: [nameLbl1.text!, heading.text!, urlLabel.text!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
        
    }
    
}   // #80
