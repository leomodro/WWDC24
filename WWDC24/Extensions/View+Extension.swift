//
//  View+Extension.swift
//  WWDC24
//
//  Created by Leonardo Modro on 12/06/24.
//

import SwiftUI

extension View {
    func alert(with item: Binding<Alerts?>) -> some View {
        let isPresented = Binding<Bool>(
            get: { item.wrappedValue != nil },
            set: {
                if $0 == false {
                    item.wrappedValue = nil
                }
            }
        )
        let alertItem = item.wrappedValue
        return alert(alertItem?.title ?? "", isPresented: isPresented) {
            buildAlertButtons(for: alertItem)
        } message: {
            buildAlertMessage(for: alertItem)
        }
    }
    
    @ViewBuilder private func buildAlertButtons(for item: Alerts?) -> some View {
        if let item = item {
            item.alertButton()
        }
    }
    
    @ViewBuilder private func buildAlertMessage(for item: Alerts?) -> some View {
        if let item = item, !item.message.isEmpty {
            Text(item.message)
        }
    }
    
    func hardScrollEdgeEffect() -> some View {
        if #available(iOS 26.0, *) {
            return self.scrollEdgeEffectStyle(.hard, for: .all)
        }
        return self
    }
    
    func minimizableTabView() -> some View {
        if #available(iOS 26.0, *) {
            return self.tabBarMinimizeBehavior(.onScrollDown)
        }
        return self
    }
    
    func bottomAccessory<Content>(@ViewBuilder content: () -> Content) -> some View where Content : View {
        if #available(iOS 26.0, *) {
            return self.tabViewBottomAccessory(content: content)
        }
        return self
    }
}
