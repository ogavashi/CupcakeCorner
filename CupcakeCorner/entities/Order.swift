//
//  Order.swift
//  CupcakeCorner
//
//  Created by Oleg Gavashi on 14.09.2023.
//

import Foundation

class Order: ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var data = OrderStruct()
}
