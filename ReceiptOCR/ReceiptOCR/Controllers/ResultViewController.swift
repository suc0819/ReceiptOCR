//
//  ResultViewController.swift
//  ReceiptOCR
//
//  Created by h2171435 on 2026/06/07.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var rawTextView: UITextView!
    
    var receiptData: ReceiptData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        displayResult()
        // Do any additional setup after loading the view.
    }
    
}

extension ResultViewController{
    func displayResult(){
        guard let data = receiptData else { return }
        storeNameLabel.text = "상호명: \(data.storeName ?? "정보 없음")"
        dataLabel.text = "날짜: \(data.date ?? "정보 없음")"
        amountLabel.text = "금액: \(data.totalAmount ?? 0)원"
        rawTextView.text = data.rawText
    }
}
