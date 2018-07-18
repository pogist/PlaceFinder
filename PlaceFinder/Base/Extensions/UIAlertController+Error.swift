//
//  UIAlertController+Error.swift
//  PlaceFinder
//
//  Created by Murilo da Paixão on 17/07/2018.
//  Copyright © 2018 Murilo da Paixão. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    convenience init(for error: Error) {
        let title = NSLocalizedString("ErrorAlertTitle", comment: "Title for error alert")
        self.init(title: title, message: error.localizedDescription, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        self.addAction(okAction)
    }
}
