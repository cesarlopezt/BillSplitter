//
//  ContentView.swift
//  BillSplitter
//
//  Created by Cesar Lopez on 3/2/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeopleIndex = 0
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused
    
    let tipPercentages = [0, 10, 15, 20, 25]
    let currency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "USD")
    
    var totalAmount: Double {
        let tipSelection = Double(tipPercentage)
        let tipAmount = tipSelection / 100 * checkAmount
        return checkAmount + tipAmount
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeopleIndex + 2)
        return totalAmount / peopleCount
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currency)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeopleIndex) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }.pickerStyle(.menu)
                }
                
                Section {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("How much tip you want to leave?")
                }

                Section {
                    Text(totalAmount, format: currency)
                } header: {
                    Label("Total Amount", systemImage: "dollarsign.circle.fill")
                }
                
                Section {
                    Text(totalPerPerson, format: currency)
                } header: {
                    Label("Amount per person", systemImage: "dollarsign.circle.fill")
                }
            }
            .navigationTitle("Bill Splitter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
