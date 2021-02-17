//
//  EntertainmentCell.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 17/01/21.
//

import UIKit
// import Firebase
import SDWebImage

/// If a View needs data, it should ask controllers...

class EntertainmentCell: UICollectionViewCell {
    
    // Outlets
    @IBOutlet var cardView: UIView!
    @IBOutlet var widthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var entertainmentNewsPic: UIImageView!
    @IBOutlet weak var leftTagString: UILabel!
    @IBOutlet weak var headingString: UILabel!
    @IBOutlet weak var readTimeString: UILabel!
    
    // linking feed VC & feed cell
    var entertainmentFeedVC: EntertainmentViewController?
    
    var entertainmentPost: EntertainmentModel? {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        
        if let photoUrlString = entertainmentPost?.photoUrl {
            let photoUrl = URL(string: photoUrlString)
            entertainmentNewsPic.sd_setImage(with: photoUrl)
        }
        
        leftTagString.text = entertainmentPost?.leftTag
        headingString.text = entertainmentPost?.heading
        readTimeString.text = entertainmentPost?.readTime
        
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
