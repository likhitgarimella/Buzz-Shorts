//
//  MiscellanyCell.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 07/02/21.
//

import UIKit
// import Firebase
import SDWebImage

/// If a View needs data, it should ask controllers...

class MiscellanyCell: UICollectionViewCell {
    
    // Outlets
    @IBOutlet var cardView: UIView!
    @IBOutlet var widthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var miscNewsPic: UIImageView!
    @IBOutlet weak var leftTagString: UILabel!
    @IBOutlet weak var headingString: UILabel!
    @IBOutlet weak var readTimeString: UILabel!
    
    // linking feed VC & feed cell
    var miscellanyFeedVC: MiscellanyViewController?
    
    var miscellanyPost: MiscellanyModel? {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        
        if let photoUrlString = miscellanyPost?.photoUrl {
            let photoUrl = URL(string: photoUrlString)
            miscNewsPic.sd_setImage(with: photoUrl)
        }
        
        leftTagString.text = miscellanyPost?.leftTag
        headingString.text = miscellanyPost?.heading
        readTimeString.text = miscellanyPost?.readTime
        
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
