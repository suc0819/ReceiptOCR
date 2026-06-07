//
//  TextAnalysisService.swift
//  ReceiptOCR
//
//  Created by h2171435 on 2026/06/07.
//

import Foundation

class TextAnalysisService {
    
    // 상호명 추출
    func extractStoreName(from text: String) -> String? {
        return text.components(separatedBy: "\n").first?.trimmingCharacters(in: .whitespaces)
    }
    
    // 날짜 추출
    func extractDate(from text: String) -> String? {
        let pattern = #"\d{4}[-./]\d{2}[-./]\d{2}"#
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return nil }
        let range = NSRange(text.startIndex..., in: text)
        guard let match = regex.firstMatch(in: text, range: range) else { return nil }
        guard let swiftRange = Range(match.range, in: text) else { return nil }
        return String(text[swiftRange])
    }
    
    // 금액 추출
    func extractAmount(from text: String) -> Int? {
        let keywords = ["합계", "총액", "TOTAL", "total", "결제금액", "받을금액"]
        let lines = text.components(separatedBy: "\n")
        
        for line in lines {
            for keyword in keywords {
                if line.contains(keyword) {
                    let numbers = line.components(separatedBy: CharacterSet.decimalDigits.inverted)
                        .joined()
                    if let amount = Int(numbers), amount > 0 {
                        return amount
                    }
                }
            }
        }
        return nil
    }
}
