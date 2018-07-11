//
//  AppDelegate.swift
//  PlaceFinder
//
//  Created by Murilo da Paixão on 11/07/2018.
//  Copyright © 2018 Murilo da Paixão. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // This line should break. To fix it instantiate your own default key provider instead.
        // See also: KeyProvider
        let defaultKeyProvider = DefaultKeyProvider()
        
        GMSServices.provideAPIKey(defaultKeyProvider.googleMapsAPIKey)
        GMSPlacesClient.provideAPIKey(defaultKeyProvider.googleMapsAPIKey)
        
        return true
    }
}

