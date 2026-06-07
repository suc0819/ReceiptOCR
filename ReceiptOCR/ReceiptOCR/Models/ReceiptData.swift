//
//  ReveiptData.swift
//  ReceiptOCR
//
//  Created by h2171435 on 2026/06/07.
//

import Foundation

struct ReceiptData: Identifiable, Codable {
    var id: UUID = UUID()
    var storeName: String?
    var totalAmount: Int?
    var date: String?
    var rawText: String
    var createdAt: Date = Date()
}
