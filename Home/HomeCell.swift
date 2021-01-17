//
//  HomeCell.swift
//  NewsViewsNetwork
//
//  Created by Likhit Garimella on 17/01/21.
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    // Outlets
    @IBOutlet var cardView: UIView!
    @IBOutlet var widthConstraint: NSLayoutConstraint!
    
    // linking feed VC & feed cell
    var homeFeedVC: HomeViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // constraint
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.size.width
        widthConstraint.constant = screenWidth - (2 * 12)
        
    }
    
}   // #30
