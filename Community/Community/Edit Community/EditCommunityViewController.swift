//
//  EditCommunityViewController.swift
//  Community
//
//  Created by Clissia Bozzer Bovi on 30/08/23.
//

import UIKit

class EditCommunityViewController: UIViewController {

    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var addImageView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var tagTextField: UITextField!
    var comunnity: Comunidade?
    var isSaving: Bool = false {
        didSet {
            isSaving ? showLoading() : dismissLoading()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        configureScreen()
        configureNavigationBar()
        configureLayout()
        addImageAction()
        dismissKeyboardView() 
    }
    
    func setData() {
        guard let comunnity = comunnity else { return }
        image.image = comunnity.image
        location.text = comunnity.city_district
        nameTextField.text = comunnity.name
        tagTextField.text = comunnity.tags.replacingOccurrences(of: "$", with: "")
        descriptionTextView.text = comunnity.description
    }
    
    private func configureScreen() {
        nameTextField.delegate = self
        tagTextField.delegate = self
        descriptionTextView.delegate = self
    }

    private func configureNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Concluir", style: .plain, target: self, action: #selector(conclude))
    }
    
    private func configureLayout() {
        descriptionTextView.clipsToBounds = true
        descriptionTextView.layer.cornerRadius = 5
        view.backgroundColor = PaleteColor.color2
        image.layer.cornerRadius = 10
        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func addImageAction() {
        let action = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        addImageView.addGestureRecognizer(action)
    }

    private func dismissKeyboardView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    private func showLoading () {
        loadingView.isHidden = false
    }

    private func dismissLoading () {
        loadingView.isHidden = true
    }

    private func saveEdition() {
        navigationItem.rightBarButtonItem?.isEnabled = false
        Task.init(priority: .high) {
            await comunnity?.updateData()
            isSaving = false
            self.dismiss(animated: true)
        }
        isSaving = true
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func selectImage() {
        let viewController = UIImagePickerController()
        viewController.sourceType = .photoLibrary
        viewController.delegate = self
        viewController.allowsEditing = true
        self.present(viewController, animated: true)
    }

    @objc private func cancel() {
        self.dismiss(animated: true)
    }
    
    @objc private func conclude() {
        let reviewAllert = UIAlertController(title: "Alteração",
                                                       message: "Suas alterações foram enviadas para revisão e logo sua Comunidade será atualizada.",
                                              preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirmar", style: .default) {_ in
            self.saveEdition()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        reviewAllert.addAction(confirmAction)
        reviewAllert.addAction(cancelAction)
        self.present(reviewAllert, animated: true, completion: nil)
    }
}

extension EditCommunityViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            image.image = selectedImage
        } else {
            image.image = UIImage(named: "images")
        }

        self.dismiss(animated: true)
    }
}

extension EditCommunityViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray || textView.textColor == .red {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Descrição"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= 850
    }
}

extension EditCommunityViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "Insira um Nome" || textField.text == "Insira uma Tag" || textField.text == "Insira um Nome" {
            textField.text = ""
            textField.textColor = .black
        }
    }
}
