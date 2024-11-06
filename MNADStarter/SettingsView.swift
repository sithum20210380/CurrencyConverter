//
//  DataController.swift
//  ContactApp
//
//  Created by Sithum Raveesha on 2024-11-06.
//

import SwiftUI

enum Currencies: String, CaseIterable {
    case usd = "USD"
    case gbp = "GBP"
    case CAD = "CAD"
    case EURO = "EURO"
}

struct SettingsView: View {
    @AppStorage("selectedCurrency") private var selectedCurrency = "USD"
    
    @Binding var currency: Currencies
    
    init(currency: Binding<Currencies>) {
        _currency = currency
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Settings")
                .font(.largeTitle)
            Text("Currency")
                .font(.title)
            
            Picker("Select Default Currency", selection: $selectedCurrency) {
                ForEach(Currencies.allCases, id: \.self) { currency in
                    Text(currency.rawValue).tag(currency.rawValue)
                }
            }
            .pickerStyle(WheelPickerStyle())
            Spacer()
        }
        .padding()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(currency: .constant(Currencies.usd))
    }
}
