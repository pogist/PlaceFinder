//
//  PlaceDetailsView.swift
//  PlaceFinder
//
//  Created by Murilo da Paixão on 15/07/2018.
//  Copyright © 2018 Murilo da Paixão. All rights reserved.
//

import UIKit

class PlaceDetailsView: UIView {
    
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeAddress: UILabel!
    
    @IBInspectable var masksToBounds: Bool = false {
        didSet {
            self.layer.masksToBounds = masksToBounds
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
}
