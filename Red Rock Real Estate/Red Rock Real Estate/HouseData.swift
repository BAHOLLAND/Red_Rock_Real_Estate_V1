//
//  HouseData.swift
//  Red Rock Real Estate

import Foundation
import UIKit

class HouseData {
    
    //stored properties
    var listPrice: Int
    var lotSqft: Int
    var sqft: Int
    var baths: Int
    var garage: Int
    var stories: Int
    var beds: Int
    var postalCode: String
    var state: String
    var city: String
    var line: String
    var address: String
    
    
    //initializer
    init(listPrice: Int, lotSqft: Int, sqft: Int, baths: Int, garage: Int, stories: Int, beds: Int, postalCode: String, state: String, city: String, line: String) {
        
        self.listPrice = listPrice
        self.lotSqft = lotSqft
        self.sqft = sqft
        self.baths = baths
        self.garage = garage
        self.stories = stories
        self.beds = beds
        self.postalCode = postalCode
        self.state = state
        self.city = city
        self.line = line
        self.address = "\(line) \(city) \(state) \(postalCode)"
    }
}
