//
//  EnvironmentCell.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 07/02/21.
//

import UIKit
// import Firebase
import SDWebImage

/// If a View needs data, it should ask controllers...

class EnvironmentCell: UICollectionViewCell {
    
    // Outlets
    @IBOutlet var cardView: UIView!
    @IBOutlet var widthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var environmentNewsPic: UIImageView!
    @IBOutlet weak var leftTagString: UILabel!
    @IBOutlet weak var headingString: UILabel!
    @IBOutlet weak var readTimeString: UILabel!
    
    // linking feed VC & feed cell
    var environmentFeedVC: EnvironmentViewController?
    
    var environmentPost: EnvironmentModel? {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        
        if let photoUrlString = environmentPost?.photoUrl {
            let photoUrl = URL(string: photoUrlString)
            environmentNewsPic.sd_setImage(with: photoUrl)
        }
        
        leftTagString.text = environmentPost?.leftTag
        headingString.text = environmentPost?.heading
        readTimeString.text = environmentPost?.readTime
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // initial text
        leftTagString.text = ""
        headingString.text = ""
        readTimeString.text = ""
        
        // number of lines
        leftTagString.numberOfLines = 0
        headingString.numberOfLines = 0
        readTimeString.numberOfLines = 0
        
        // constraint
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.size.width
        widthConstraint.constant = screenWidth - (2 * 12)
        
    }
    
}   // #68
