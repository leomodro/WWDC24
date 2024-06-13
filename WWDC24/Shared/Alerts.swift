//
//  Alerts.swift
//  WWDC24
//
//  Created by Leonardo Modro on 12/06/24.
//

import SwiftUI

enum Alerts: Identifiable {
    var id: String { String(reflecting: self) }
    
    case unableToFetchData
}

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}

// MARK: - Properties
extension Alerts {
    var title: String {
        switch self {
        case .unableToFetchData:
            return "Something went wrong".localized
        }
    }
    
    var message: String {
        switch self {
        case .unableToFetchData:
            return "We were unable to fetch data at this time. Try again later".localized
        }
    }
    
    @ViewBuilder func alertButton() -> some View {
        switch self {
        case .unableToFetchData:
            Button("Ok", action: { })
        }
    }
}
