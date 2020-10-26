//
//  AddPhotoViewController.swift
//  FITstagram
//
//  Created by Lukáš Hromadník on 26/10/2020.
//

import UIKit

final class AddPhotoViewController: UIViewController {
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
        print("cancel tapped")
    }
    
    @IBAction func createTapped() {
        print(textView.text ?? "")
        view.endEditing(true)
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

extension AddPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        image = info[.originalImage] as? UIImage
        picker.dismiss(animated: true)
    }
}
