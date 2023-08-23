//
//  CommonData.swift
//  MAD CW2
//
//  Created by user239258 on 8/19/23.
//

import UIKit

class CommonData{
    static let titles = ["Mr", "Mrs", "Ms", "Miss"]
    
    static func imageToBase64(image: UIImage) -> String {
        if let imageData = image.pngData() {
            return imageData.base64EncodedString(options: [])
        }
        return ""
    }
    
    static func base64ToImage(_ base64String: String) -> UIImage? {
        if let imageData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) {
            return UIImage(data: imageData)
        }
        return nil
    }
}
