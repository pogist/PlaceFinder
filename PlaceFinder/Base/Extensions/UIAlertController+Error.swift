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
        self.init(title: "An error has occurred", message: error.localizedDescription, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        self.addAction(okAction)
    }
}
