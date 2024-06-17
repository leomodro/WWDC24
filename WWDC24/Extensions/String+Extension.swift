//
//  String+Extension.swift
//  WWDC24
//
//  Created by Leonardo Modro on 17/06/24.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
