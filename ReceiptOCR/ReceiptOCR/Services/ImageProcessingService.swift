//
//  ImageProcessingService.swift
//  ReceiptOCR
//
//  Created by h2171435 on 2026/06/07.
//

import UIKit
import CoreImage

class ImageProcessingService {
    func preprocess(_ image: UIImage) -> UIImage {
        guard let ciImage = CIImage(image: image) else { return image }
        
        // 흑백 처리
        let grayscale = ciImage.applyingFilter("CIColorControls",
            parameters: [kCIInputSaturationKey: 0.0])
        
        // 대비 증가
        let contrast = grayscale.applyingFilter("CIColorControls",
            parameters: [kCIInputContrastKey: 1.5])
        
        // CIImage → UIImage 변환
        let context = CIContext()
        guard let cgImage = context.createCGImage(contrast, from: contrast.extent) else { return image }
        
        return UIImage(cgImage: cgImage)
    }
}
