//
//  MovieDetailCompanyCell.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/24/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailCompanyCell: UITableViewCell {
    
    // This property must be bound to the whole view in Interface Builder
    @IBOutlet private weak var allContentView: UIView!
    
    // MARK: Outlets
    @IBOutlet private weak var companyImage: UIImageView!
    @IBOutlet private weak var companyLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    
    // From Code
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    // From IB
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
}

// MARK: Init
extension MovieDetailCompanyCell {
    
    private func commonInit() {
        
        // Name of the .xib file
        let nibName = className(some: self)
        
        // Load and add this custom view
        Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        addSubview(allContentView)
        
        // Expand to fill its parent
        allContentView.frame = self.bounds
        allContentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        // This prevent the cell to change its color when selected
        selectionStyle = .none
    }
}

// MARK: Setup
extension MovieDetailCompanyCell {
    
    func setup(name: String, logoPath: String?, originCountry: String) {
        
        if originCountry.count > 0 {
            companyLabel.text = "\(name) (\(originCountry))"
        } else {
            companyLabel.text = name
        }
        
        guard let logoImageUrl = logoPath,
              let logoResourceUrl = URL(string: logoImageUrl) else {
                
            companyImage.image = Image.AppIconWhite.image()
            return
        }
        
        let posterPlaceholder = Image.AppIconWhite.image()
        let posterResource = ImageResource(downloadURL: logoResourceUrl, cacheKey: logoImageUrl)
        let options: [KingfisherOptionsInfoItem] = [.transition(.fade(0.5)), .cacheOriginalImage]
        
        companyImage.kf.setImage(
            with: posterResource,
            placeholder: posterPlaceholder,
            options: options,
            progressBlock: nil,
            completionHandler: { _ in })
    }
}
