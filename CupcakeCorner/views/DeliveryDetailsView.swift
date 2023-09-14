//
//  DeliveryDetailsView.swift
//  CupcakeCorner
//
//  Created by Oleg Gavashi on 14.09.2023.
//

import SwiftUI

struct DeliveryDetailsView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.data.deliveryDetails.name)
                TextField("Street adress", text: $order.data.deliveryDetails.streetAdress)
                TextField("City", text: $order.data.deliveryDetails.city)
                TextField("Zip", text: $order.data.deliveryDetails.zip)
            }
            
            Section {
                NavigationLink {
                  CheckOutView(order: order)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(!order.data.hasValidDeliveryDetails)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DeliveryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DeliveryDetailsView(order: Order())
                .preferredColorScheme(.dark)
        }
    }
}
