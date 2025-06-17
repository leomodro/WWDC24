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
    @FocusState private var isFocused: Bool
    
    var body: some View {
        Form {
            Section {
                Slider(value: $sliderValue, in: 1...10, step: 1)
                Stepper(value: $stepperValue, in: 1...10, step: 1) {
                    Text("\(stepperValue)".excludeLocalization)
                }
                Toggle(isOn: $toggleValue) {
                    Text(.toggle)
                }
            } header: {
                Text(.header)
            } footer: {
                Text(.footer)
            }
            
            Section {
                TextField("Some text field", text: $textFieldInput)
                    .focused($isFocused)
                if #available(iOS 26.0, *) {
                    TextEditor(text: $textEditor)
                        .frame(height: 150)
                        .focused($isFocused)
                }
            }
            
            Button(.showAlert) {
                shouldShowAlert.toggle()
            }
        }
        .alert(.thisIsAnAlert, isPresented: $shouldShowAlert) {
            Button(.primary) { }
//            Button("Destructive", role: .destructive) { }
            Button(.cancel, role: .cancel) { }
        } message: {
            Text(.thisIsSomeInformativeMessage)
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button(.done) {
                    isFocused = false
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(.components)
    }
}

#Preview {
    GeneralComponentsView()
}
