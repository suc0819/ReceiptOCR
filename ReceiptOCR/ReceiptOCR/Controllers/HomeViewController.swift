//
//  HomeViewController.swift
//  ReceiptOCR
//
//  Created by h2171435 on 2026/06/07.
//

import UIKit

class HomeViewController:  UIViewController{

    @IBOutlet weak var receiptImageView: UIImageView!
    let ocrController = OCRController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func selectImageTapped(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    @IBAction func startAnalyzeTapped(_ sender: Any) {
        guard let image = receiptImageView.image else {
            let alert = UIAlertController(title: "알림", message: "영수증 이미지를 선택해주세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            present(alert, animated: true)
            return
        }
        
        ocrController.analyze(image: image){
            result in
            self.saveToHistory(result)
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "showResult", sender: result)
            }
        }
    }
    
    @IBAction func viewHistoryTapped(_ sender: Any) {
        performSegue(withIdentifier: "showHistory", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "showResult" {
            let vc = segue.destination as! ResultViewController
            vc.receiptData = sender as? ReceiptData
        }
    }

}

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        receiptImageView.image = image
        picker.dismiss(animated: true)
    }
}

extension HomeViewController{
    func saveToHistory(_ receipt: ReceiptData) {
        var history: [ReceiptData] = []
        if let data = UserDefaults.standard.data(forKey: "receiptHistory"),
           let decoded = try? JSONDecoder().decode([ReceiptData].self, from: data) {
            history = decoded
        }
        history.insert(receipt, at: 0)
        if let encoded = try? JSONEncoder().encode(history) {
            UserDefaults.standard.set(encoded, forKey: "receiptHistory")
        }
    }
}
