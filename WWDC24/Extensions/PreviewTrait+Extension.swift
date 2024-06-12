//
//  PreviewTrait+Extension.swift
//  WWDC24
//
//  Created by Leonardo Modro on 12/06/24.
//

import SwiftUI

extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor static var userListPreview: Self = .modifier(UserListPreview())
}
