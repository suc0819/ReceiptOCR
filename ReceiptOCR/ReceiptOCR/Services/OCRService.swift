//
//  OCRService.swift
//  ReceiptOCR
//
//  Created by h2171435 on 2026/06/07.
//

import UIKit
import Vision

class OCRService {
    
    func recognize(image: UIImage, completion: @escaping (String) -> Void) {
        guard let cgImage = image.cgImage else { return }
        
        let request = VNRecognizeTextRequest { request, error in
            let observations = request.results as? [VNRecognizedTextObservation]
            let text = observations?
                .compactMap { $0.topCandidates(1).first?.string }
                .joined(separator: "\n") ?? ""
            completion(text)
        }
        
        request.recognitionLanguages = ["ko-KR", "en-US"]
        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true
        
        let handler = VNImageRequestHandler(cgImage: cgImage)
        try? handler.perform([request])
    }
}

