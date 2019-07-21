//
//  Language+UIKit.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 7/20/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UIKit

extension UILabel {
    
    func set(text key: LanguageKey) {
        text = Language.get(key)
    }
}

extension UIButton {
    
    func set(title key: LanguageKey, for state: UIControl.State = .normal) {
        self.setTitle(Language.get(key), for: state)
    }
}

extension UIAlertAction {
    
    convenience init(title key: LanguageKey, style: UIAlertAction.Style = .default,
                     handler: ((UIAlertAction) -> Void)? = nil) {
        self.init(title: Language.get(key), style: style, handler: handler)
    }
}

extension UIAlertController {
    
    convenience init(title key: LanguageKey, message: LanguageKey, style: UIAlertController.Style = .alert) {
        self.init(title: Language.get(key), message: Language.get(message), preferredStyle: style)
    }
}

extension UITabBarItem {
    
    convenience init(title key: LanguageKey, image: UIImage? = nil, tag: Int) {
        self.init(title: Language.get(key), image: image, tag: tag)
    }
}

extension UIViewController {
    
    func set(title key: LanguageKey) {
        title = Language.get(key)
    }
}

extension UITextField {
    
    func set(placeholder key: LanguageKey) {
        placeholder = Language.get(key)
    }
    
    func set(text key: LanguageKey) {
        text = Language.get(key)
    }
}
