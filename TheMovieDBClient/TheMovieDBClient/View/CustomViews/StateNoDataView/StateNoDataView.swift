//
//  StateNoDataView.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/22/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UIKit

class StateNoDataView: UIView {

    // This property must be bound to the whole view in Interface Builder
    @IBOutlet private weak var contentView: UIView!
    
    override init(frame: CGRect) { // From Code
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) { // From IB
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        
        // Name of the .xib file
        let nibName = className(some: self)
        
        // Load and add this custom view
        Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        addSubview(contentView)
        
        // Expand to fill its parent
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}

private func className(some: Any) -> String {
    return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
}
