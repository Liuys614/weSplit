//
//  ContentView.swift
//  switftUI
//
//  Created by Louis Liu on 2022/12/16.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 20.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 15
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [5, 10, 15, 18, 20, 25]
    
    var totalPerPerson: Double{
        var amount = Double(checkAmount)
        amount *= Double(tipPercentage)/100.0
        amount /= Double(1+numberOfPeople)
        return amount
    }
    
    var total: Double{
        var amount = Double(checkAmount)
        amount *= 1.0 + (Double(tipPercentage)/100.0)
        amount /= Double(1+numberOfPeople)
        return amount
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Amount", value: $checkAmount,
                              format: .currency(code: Locale.current.currency?.identifier ?? "USD")
                              
                    )
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    .onAppear{
                        UITextField.appearance().clearButtonMode = .whileEditing
                    }
                    
                    Picker("numbe of people", selection: $numberOfPeople){
                        ForEach(1..<20){
                            Text("\($0) people")
                        }
                    }
                    Picker("tip percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text( $0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Check")
                }
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header:{
                    Text("Tips")
                }
                Section{
                    Text(total, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header:{
                    Text("Total")
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("We Split").font(.title)
                    }
                }
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
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
