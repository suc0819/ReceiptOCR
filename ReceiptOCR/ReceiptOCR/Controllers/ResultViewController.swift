//
//  ResultViewController.swift
//  ReceiptOCR
//
//  Created by h2171435 on 2026/06/07.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dividerView: UIView!
    @IBOutlet weak var rawTextView: UITextView!
    
    var receiptData: ReceiptData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayResult()
        dividerView.backgroundColor = UIColor.systemGray4
    }
    
}

extension ResultViewController{
    func displayResult(){
        guard let data = receiptData else { return }
        
        storeNameLabel.text = "상호명: \(data.storeName ?? "정보 없음")"
        storeNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        dateLabel.text = "날짜: \(data.date ?? "정보 없음")"
        dateLabel.font = UIFont.systemFont(ofSize: 16)
        
        let formattedAmount = NumberFormatter.localizedString(from: NSNumber(value: data.totalAmount ?? 0), number: .decimal)
        amountLabel.text = "금액: \(formattedAmount)원"
        amountLabel.font = UIFont.systemFont(ofSize: 16)
        
        rawTextView.text = data.rawText
        rawTextView.isEditable = false
        rawTextView.font = UIFont.systemFont(ofSize: 13)
    }
}
