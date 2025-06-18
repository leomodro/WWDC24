//
//  SearchViewModel.swift
//  WWDC24
//
//  Created by Leonardo Modro on 17/06/25.
//

import Observation
import SwiftUI

struct SearchImage {
    let id: UUID = UUID()
    let imageName: String
    var thumbnailImage: UIImage?
}

@Observable class SearchViewModel {
    
    var images: [SearchImage] = []
    
    func loadImages() async {
        guard images.isEmpty else { return }
        images = (1...19).map { SearchImage(imageName: "image\($0)") }
        
        // This works, but it takes more time and resources
        // Even using @concurrent and offloading to another Thread, still takes time
        // awaiting one generation to start another.
        // for index in images.indices {
        //    images[index].thumbnailImage = await generateThumbnail(for: images[index])
        // }
        
        // withTaskGroup allows to perform thumbnail generation concurrently.
        // No longer waiting one response to start another. Work is split into multiple threads
        await withTaskGroup(of: (Int, UIImage?).self) { group in
            for index in images.indices {
                group.addTask {
                    let img = await self.generateThumbnail(for: self.images[index].imageName)
                    return (index, img)
                }
            }
            
            for await (index, thumbnail) in group {
                images[index].thumbnailImage = thumbnail
            }
        }
    }
    
    @concurrent func generateThumbnail(for image: String, size: CGSize = CGSize(width: 300, height: 200)) async -> UIImage? {
        guard let originalImage = UIImage(named: image) else { return nil }
        
        let renderer = UIGraphicsImageRenderer(size: size)
        let thumbnail = renderer.image { _ in
            originalImage.draw(in: CGRect(origin: .zero, size: size))
        }
        return thumbnail
    }
    
}
