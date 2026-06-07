//
//  OCRController.swift
//  ReceiptOCR
//
//  Created by h2171435 on 2026/06/07.
//

import UIKit

class OCRController {
    
    private let imageProcessor = ImageProcessingService()
    private let ocrService = OCRService()
    private let textAnalyzer = TextAnalysisService()
    
    func analyze(image: UIImage, completion: @escaping (ReceiptData) -> Void) {
        
        // 1. 이미지 전처리
        let processedImage = imageProcessor.preprocess(image)
        
        // 2. OCR 수행
        ocrService.recognize(image: processedImage) { rawText in
            
            // 3. 텍스트 분석
            let result = ReceiptData(
                storeName: self.textAnalyzer.extractStoreName(from: rawText),
                totalAmount: self.textAnalyzer.extractAmount(from: rawText),
                date: self.textAnalyzer.extractDate(from: rawText),
                rawText: rawText
            )
            
            completion(result)
        }
    }
}
