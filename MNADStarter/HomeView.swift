//
//  ContentView.swift
//  MNADStarter
//
//  Created by Visal Rajapakse on 2023-06-30.
//

import SwiftUI

struct HomeView: View {
    
    // Dictionary to get the rate agains the LKR for a given currency
    let rates = [
        "USD": 308.81,
        "GBP": 390.31,
        "AUD": 204.40,
        "CAD": 232.82,
        "EURO":334.92,
    ]
    
    @AppStorage("selectedCurrency") private var selectedCurrency = "USD"
    
    @State private var inputValue = ""
    @State private var outputValue = ""
    @State private var isReversed = false
    
    // SAMPLE INIT to demonstrate usage of caseiterable enums
    init() {
        let listOfCurrencies = Currencies.allCases // [.usd, .gbp]
        let stringValueOfUSD = listOfCurrencies[0].rawValue // "USD"
        let usdRate = rates[stringValueOfUSD] // 308.81
    }
    
    var body: some View {
        VStack {
            VStack (alignment: .leading){
                Text("Currency Converter")
                    .font(.title)
                HStack {
                    TextField(isReversed ? "Enter LKR" : "Enter \(selectedCurrency)", text: $inputValue)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .onChange(of: inputValue) { newValue in
                            if !isReversed {
                                convert()
                            }
                        }
                    
                    Picker("Currency", selection: $selectedCurrency) {
                        ForEach(Array(rates.keys.sorted()), id: \.self) { currency in
                            Text(currency).tag(currency)
                        }
                    }
                }
                HStack {
                    TextField(isReversed ? "Enter \(selectedCurrency)" : "Enter LKR", text: $outputValue)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .disabled(!isReversed)
                        .onChange(of: outputValue) { newValue in
                            if isReversed {
                                reverseConvert()
                            }
                        }
                    Text("LKR")
                }
                HStack {
                    Text("Switch Calculation")
                    Toggle("", isOn: $isReversed)
                }
                Spacer()
            }
            .padding()
            VStack(alignment: .center) {
                Button {
                    inputValue = ""
                    outputValue = ""
                    print("Resetting TextFields")
                }label: {
                    HStack  {
                        Text("Reset TextFields")
                    }
                }
                .foregroundColor(.red)
                .padding(.horizontal,30)
                .padding(.vertical,10)
                .background(
                    .red
                        .opacity(0.3)
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
            }
        }
        
    }
    
    // MARK: USE THESE FUNCTIONS WITHIN A SWIFTUI `onChange()` VIEW MODIFIER
    func convert() {
        // To convert from foreign currency (F) to LKR you need to multiply the value of currency by the
        guard let value = Double(inputValue),
              let rate = rates[selectedCurrency] else {
            outputValue = ""
            return
        }
        if isReversed {
            outputValue = String(format: "%.2f", value / rate)
        } else {
            outputValue = String(format: "%.2f", value * rate)
        }
    }
    
    func reverseConvert() {
        // To convert LKR to a foreign currency you need to divide the value of currency by the rate (R):
        guard let value = Double(outputValue),
              let rate = rates[selectedCurrency] else {
            inputValue = ""
            return
        }
        
        inputValue = String(format: "%.2f", value * rate)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
