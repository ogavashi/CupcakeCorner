//
//  Order.swift
//  CupcakeCorner
//
//  Created by Oleg Gavashi on 14.09.2023.
//

import Foundation

struct OrderStruct: Codable {    
    var type = 0
    var quantity = 1
    
    var extraFrosting = false
    var extraSprinkles = false
    
    var deliveryDetails = DeliveryDetails()
    
    var specialRequest = false {
        didSet {
            if !specialRequest {
                extraFrosting = false
                extraSprinkles = false
            }
        }
    }
    
    var hasValidDeliveryDetails: Bool {
        !deliveryDetails.name.trimmingCharacters(in: .whitespaces).isEmpty &&
        !deliveryDetails.streetAdress.trimmingCharacters(in: .whitespaces).isEmpty &&
        !deliveryDetails.city.trimmingCharacters(in: .whitespaces).isEmpty &&
        !deliveryDetails.zip.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var cost: Double {
        var cost = Double(quantity) * 2
        
        cost += Double(type) / 2
        
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if extraSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
}
