//
//  CheckOutView.swift
//  CupcakeCorner
//
//  Created by Oleg Gavashi on 14.09.2023.
//

import SwiftUI

struct CheckOutView: View {
    @ObservedObject var order: Order
    
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    @State private var showAlert = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                    }
                    else if phase.error != nil {
                        VStack {
                            Image(systemName: "photo")
                                .font(.system(size: 128))
                            Text("Could not load image")
                                .font(.title)
                        }
                    }
                    else {
                        ProgressView()
                    }
                }
                .frame(height: 233)
                
                Text("Your total is \(order.data.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert(alertTitle, isPresented: $showAlert) {
            Button("Ok") {
               
            }
        } message: {
            Text(alertMessage)
        }
    }
    
    func placeOrder() async {
        do {
            let encoded = try JSONEncoder().encode(order.data)
            
            let url = URL(string: "https://reqres.in/api/cupcakes")!
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(OrderStruct.self, from: data)
            
            alertTitle = "Thank you"
            alertMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showAlert = true
        }
        catch {
            alertTitle = "Network error"
            alertMessage = "Could not place your order, please try again"
            showAlert = true
        }
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CheckOutView(order: Order())
                .preferredColorScheme(.dark)
        }
    }
}
