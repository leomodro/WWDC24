//
//  WWDCItems.swift
//  WWDC24
//
//  Created by Leonardo Modro on 14/06/25.
//

import Foundation

enum WWDCItems: CaseIterable {
    case foundationModel, sheet, actionSheet, webView, components
    
    var description: String {
        switch self {
        case .foundationModel:
            return "Foundation Models"
        case .sheet:
            return "Sheets"
        case .actionSheet:
            return "Action Sheets"
        case .webView:
            return "SwiftUI Web View"
        case .components:
            return "UI Components"
        }
    }
}
