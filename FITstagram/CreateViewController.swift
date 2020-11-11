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
    
    let viewModel: CreateViewModel
    
    // MARK: - Initialization
    
    init?(coder: NSCoder, viewModel: CreateViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        
        imageView.layer.cornerRadius = 4
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        
        viewModel.viewModelDidChange = { [weak self] viewModel in
            self?.selectPhotoButton.isHidden = viewModel.image != nil
            self?.imageView.image = viewModel.image
        }
    }
    
    // MARK: - Actions
    
    @IBAction func cancelTapped() {
        dismiss(animated: true)
    }
    
    @IBAction func createTapped() {
        print(textView.text ?? "")
        view.endEditing(true)
        
        viewModel.createPost { success in
            if success {
                DispatchQueue.main.async { [weak self] in
                    self?.dismiss(animated: true)
                }
            }
        }
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
        viewModel.image = info[.originalImage] as? UIImage
        picker.dismiss(animated: true)
    }
}

extension CreateViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        print(#function, textView.text ?? "")
        viewModel.caption = textView.text ?? ""
    }
}
