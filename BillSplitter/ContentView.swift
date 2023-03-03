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
    
    let tipPercentages = [0, 10, 15, 20, 25]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeopleIndex + 2)
        let tipSelection = Double(tipPercentage)
        let tipAmount = tipSelection / 100 * checkAmount
        return (checkAmount + tipAmount) / peopleCount
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                    
                    Picker("Number of People", selection: $numberOfPeopleIndex) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }.pickerStyle(.navigationLink)
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
                    Text(totalPerPerson,
                         format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("Bill Splitter")
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
