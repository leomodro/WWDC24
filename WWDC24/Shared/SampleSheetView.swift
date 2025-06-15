//
//  SampleSheetView.swift
//  WWDC24
//
//  Created by Leonardo Modro on 14/06/25.
//

import SwiftUI

struct SampleSheetView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Text(.sheetWithMediumAndLargePresentationDetent)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
                .presentationDetents([.medium, .large])
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        if #available(iOS 26.0, *) {
                            Button(role: .close) {
                                dismiss()
                            }
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        if #available(iOS 26.0, *) { Button(role: .confirm) { } }
                    }
                }
        }
    }
}

#Preview {
    SampleSheetView()
}
