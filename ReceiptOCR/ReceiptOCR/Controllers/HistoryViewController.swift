//
//  HistoryViewController.swift
//  ReceiptOCR
//
//  Created by h2171435 on 2026/06/07.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var historyTableView: UITableView!
    
    var historyList: [ReceiptData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.delegate = self
        historyTableView.dataSource = self
        loadHistory()
    }
    
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
        let item = historyList[indexPath.row]
        cell.textLabel?.text = item.storeName ?? "정보 없음"
        cell.detailTextLabel?.text = "\(item.date ?? "날짜 없음") | \(item.totalAmount ?? 0)원"
        return cell
    }
}

extension HistoryViewController{
    func loadHistory(){
        if let data = UserDefaults.standard.data(forKey: "receiptHistory"), let decoded = try? JSONDecoder().decode([ReceiptData].self, from: data){
            historyList = decoded
            print("불러오기 완료: \(historyList.count)개")
        } else {print("저장된 기록 없음")}
        historyTableView.reloadData()
    }
}
