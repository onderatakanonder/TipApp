//
//  ContentView.swift
//  TipApp
//
//  Created by Önder Atakan Önder on 23.10.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var totalPrice = 0.0
    @State private var numbersOfPeople = 2
    @State private var tipPercantage = 20
    
    @FocusState private var priceFocused: Bool
    //fiyatın değişikliğinin takibini sağlıyor
    
    let tipPercentes = [0,10,15,20,25,]
    
    var totalPerPeople : Double {
        let peopleCount = Double(numbersOfPeople+2)
        let tipSelection = Double(tipPercantage)
        
        let tipValue = totalPrice / 100 * tipSelection
        let grandTotal = totalPrice + tipValue
        let amountPerPeople = grandTotal / peopleCount
        
        return amountPerPeople
    }
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section {
                    TextField("Amount",
                              value: $totalPrice,
                              format: .currency(code: Locale.current.currency? .identifier ?? "USD"))
                    
                    Picker("Number of People",
                           selection: $numbersOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    
                }
                Section("NE KADAR BAHŞİŞ VERMEK İSTERSİN?") {
                    Picker("Tip Percentage", selection: $tipPercantage) {
                        ForEach(tipPercentes, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section ("KİŞİ BAŞINA DÜŞEN ÜCRET") {
                    Text(totalPerPeople, format: .currency(code: Locale.current.currency? .identifier ?? "USD"))
                }
                
                .navigationTitle("TIPAPP")
                .toolbar{
                    if priceFocused {
                        Button("Done") {
                            priceFocused = false
                        }
                    }
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
}
