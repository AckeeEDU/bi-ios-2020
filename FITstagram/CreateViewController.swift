//
//  CreateViewController.swift
//  FITstagram
//
//  Created by Lukáš Hromadník on 26/10/2020.
//

import UIKit

final class CreateViewController: UIViewController {
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var selectPhotoButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage? {
        didSet {
            selectPhotoButton.isHidden = image != nil
            imageView.image = image
        }
    }
    
    override func loadView() {
        super.loadView()
        
        imageView.layer.cornerRadius = 4
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    @IBAction func cancelTapped() {
        dismiss(animated: true)
    }
    
    @IBAction func createTapped() {
        print(textView.text ?? "")
        view.endEditing(true)
        
        let username = UserDefaults.standard.string(forKey: "username") ?? "username"
        
        var urlRequest = URLRequest(url: URL(string: "https://ackeeedu.000webhostapp.com/api.php/records/posts")!)
        urlRequest.allHTTPHeaderFields = ["Content-Type": "application/json"]
        urlRequest.httpMethod = "POST"
        
        let body: [String: Any?] = [
            "image": image?.jpegData(compressionQuality: 0.5)?.base64EncodedString(),
            "username": username,
            "caption": textView.text ?? "",
            "lat": nil,
            "lon": nil,
            "location": nil
        ]
        urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: body)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("[ERROR]", error.localizedDescription)
                return
            }
            
            guard let data = data else { assertionFailure(); return }
            
            print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
    }
    
    @IBAction func selectPhotoTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    @IBAction func locationTapped() {
        print("location tapped")
    }
}

extension CreateViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        image = info[.originalImage] as? UIImage
        picker.dismiss(animated: true)
    }
}
