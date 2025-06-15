//
//  GeneralComponentsView.swift
//  WWDC24
//
//  Created by Leonardo Modro on 14/06/25.
//

import SwiftUI

struct GeneralComponentsView: View {
    
    @State private var sliderValue: Double = 0
    @State private var stepperValue: Int = 0
    @State private var toggleValue: Bool = false
    @State private var textFieldInput: String = ""
    @State private var textEditor: AttributedString = "Rich text editor"
    @State private var shouldShowAlert: Bool = false
    
    var body: some View {
        Form {
            Section {
                Slider(value: $sliderValue, in: 1...10, step: 1)
                Stepper(value: $stepperValue, in: 1...10, step: 1) {
                    Text("\(stepperValue)")
                }
                Toggle(isOn: $toggleValue) {
                    Text("Toggle")
                }
            } header: {
                Text("Header")
            } footer: {
                Text("Footer")
            }
            
            Section {
                TextField("Some text field", text: $textFieldInput)
                if #available(iOS 26.0, *) {
                    TextEditor(text: $textEditor)
                        .frame(height: 150)
                }
            }
            
            Button("Show alert") {
                shouldShowAlert.toggle()
            }
        }
        .alert("This is an alert", isPresented: $shouldShowAlert) {
            Button("Primary") { }
//            Button("Destructive", role: .destructive) { }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("This is some informative message")
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Components")
    }
}

#Preview {
    GeneralComponentsView()
}
