//
//  KeyProvider.swift
//  PlaceFinder
//
//  Created by Murilo da Paixão on 11/07/2018.
//  Copyright © 2018 Murilo da Paixão. All rights reserved.
//

/**
 This protocol tells which configuration keys must be provided to the app.
 
 Usage:
    - Create a struct called DefaultKeyProvider and provide your api key, just like that:
 
     struct DefaultKeyProvider: KeyProvider {
 
         var googleMapsAPIKey: String {
            return "Your api key goes here..."
         }
     }
 */
protocol KeyProvider {
    var googleMapsAPIKey: String { get }
}
