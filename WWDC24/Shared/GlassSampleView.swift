//
//  GlassSampleView.swift
//  WWDC24
//
//  Created by Leonardo Modro on 17/06/25.
//

import SwiftUI

@available(iOS 26.0, *)
struct GlassSampleView: View {
    
    let badgeImages: [String] = ["airplane.circle.fill", "car.circle.fill", "tram.circle.fill", "sailboat.circle.fill", "bicycle.circle.fill"]
    @State private var isExpanded = false
    
    @Namespace var namespace
    
    var body: some View {
        GlassEffectContainer(spacing: 20) {
            VStack {
                if isExpanded {
                    VStack(spacing: 16) {
                        ForEach(badgeImages.enumerated(), id: \.0) { index, image in
                            Image(systemName: image)
                                .frame(width: 32, height: 32)
                                .font(.system(size: 28))
                                .padding()
                                .glassEffect()
                                .glassEffectID("image\(index)", in: namespace)
                        }
                    }
                    .symbolColorRenderingMode(.gradient)
                    .symbolRenderingMode(.palette)
                }
                
                Image(systemName: isExpanded ? "xmark" : "plus")
                    .contentTransition(.symbolEffect(.replace))
                    .frame(width: 32, height: 32)
                    .font(.system(size: 28))
                    .padding()
                    .glassEffect(.regular.interactive())
                    .glassEffectID("badgeToggle", in: namespace)
                    .padding(16)
                    .onTapGesture {
                        withAnimation { isExpanded.toggle() }
                    }
            }
        }
    }
}
