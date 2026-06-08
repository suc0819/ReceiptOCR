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
            print("이미지 없음")
            return
        }
        
        ocrController.analyze(image: image){
            result in
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "showResult", sender: result)
            }
        }
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
