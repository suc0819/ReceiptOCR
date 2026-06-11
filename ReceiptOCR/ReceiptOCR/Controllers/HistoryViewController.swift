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
    var groupedHistory: [(month: String, items: [ReceiptData])] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.delegate = self
        historyTableView.dataSource = self
        loadHistory()
        historyTableView.tableFooterView = UIView()
    }
    
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedHistory.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedHistory[section].items.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let month = groupedHistory[section].month
        let total = groupedHistory[section].items
            .compactMap { $0.totalAmount }
            .reduce(0, +)
        let formatted = NumberFormatter.localizedString(from: NSNumber(value: total), number: .decimal)
        return "\(month)  |  총 \(formatted)원"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
        let item = groupedHistory[indexPath.section].items[indexPath.row]
        let formatted = NumberFormatter.localizedString(from: NSNumber(value: item.totalAmount ?? 0), number: .decimal)
        cell.textLabel?.text = item.storeName ?? "정보 없음"
        cell.detailTextLabel?.text = "\(item.date ?? "날짜 없음") | \(formatted)원"
        return cell
    }
}

extension HistoryViewController{
    func loadHistory(){
        if let data = UserDefaults.standard.data(forKey: "receiptHistory"), let decoded = try? JSONDecoder().decode([ReceiptData].self, from: data){
            historyList = decoded
            groupByMonth()
        }
        historyTableView.reloadData()
    }
    
    func groupByMonth() {
        var dict: [String: [ReceiptData]] = [:]
        
        for item in historyList {
            let month = String(item.date?.prefix(7) ?? "날짜 없음")
            if dict[month] == nil {
                dict[month] = []
            }
            dict[month]?.append(item)
        }
        
        groupedHistory = dict.sorted { $0.key > $1.key }
            .map { (month: $0.key, items: $0.value) }
    }
}
