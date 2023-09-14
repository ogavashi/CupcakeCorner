//
//  OrderView.swift
//  CupcakeCorner
//
//  Created by Oleg Gavashi on 14.09.2023.
//

import SwiftUI

struct OrderView: View {
    @StateObject var order = Order()
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Cupcake type", selection: $order.data.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.data.quantity)", value: $order.data.quantity, in: 1...20)
                }
                Section {
                    Toggle("Special requests ?", isOn: $order.data.specialRequest.animation())
                    if order.data.specialRequest {
                        Toggle("Add extra frosting", isOn: $order.data.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.data.extraSprinkles)
                    }
                }
                Section {
                    NavigationLink {
                        DeliveryDetailsView(order: order)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("CupcakeCorner")
        }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
            .preferredColorScheme(.dark)
    }
}
