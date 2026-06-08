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
        
        for (index, line) in lines.enumerated() {
            for keyword in keywords {
                if line.uppercased() == keyword.uppercased() ||
                   line.uppercased().hasPrefix(keyword.uppercased() + " ") ||
                   line.uppercased().hasPrefix(keyword.uppercased() + "\t") {
                    // 같은 줄에서 먼저 찾기
                    let cleaned = line.replacingOccurrences(of: ",", with: "")
                    let numbers = cleaned.components(separatedBy: CharacterSet.decimalDigits.inverted)
                        .joined()
                    if let amount = Int(numbers), amount > 0 {
                        return amount
                    }
                    // 다음 줄에서 찾기
                    if index + 1 < lines.count {
                        let nextCleaned = lines[index + 1].replacingOccurrences(of: ",", with: "")
                        let nextNumbers = nextCleaned.components(separatedBy: CharacterSet.decimalDigits.inverted)
                            .joined()
                        if let amount = Int(nextNumbers), amount > 0 {
                            return amount
                        }
                    }
                }
            }
        }
        
        // fallback
        let excludeKeywords = ["CASH", "CHANGE", "CARD", "거스름돈", "받은금액", "잔돈"]
        let filteredLines = lines.filter { line in
            !excludeKeywords.contains(where: { line.uppercased().contains($0) })
        }
        let filteredText = filteredLines.joined(separator: "\n")
        let allCleaned = filteredText.replacingOccurrences(of: ",", with: "")
        let numbers = allCleaned.components(separatedBy: CharacterSet.decimalDigits.inverted)
            .compactMap { Int($0) }
            .filter { $0 > 100 }
        return numbers.max()
    }
}
