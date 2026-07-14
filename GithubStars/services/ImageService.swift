//
//  ImageService.swift
//  GithubStars
//
//  Created by Alex Rodrigues on 19/12/18.
//  Copyright © 2018 Alex Rodrigues. All rights reserved.
//

import UIKit

actor ImageService {

    static let shared = ImageService()

    private let imageCache = NSCache<NSString, UIImage>()

    func downloadImage(from urlString: String) async -> UIImage? {
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            return cachedImage
        }

        guard let url = URL(string: urlString) else {
            return nil
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else {
                return nil
            }
            imageCache.setObject(image, forKey: urlString as NSString)
            return image
        } catch {
            return nil
        }
    }
}
