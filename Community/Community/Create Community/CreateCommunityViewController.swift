//
//  CreateCommunityViewController.swift
//  Community
//
//  Created by Clissia Bozzer Bovi on 21/08/23.
//

import UIKit

class CreateCommunityViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imagePicker: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var tagTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var symbolView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    var fetchedAddress: Address?
    var isSaving: Bool = false {
        didSet {
            isSaving ? showLoading() : dismissLoading()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        dismissKeyboardView()
        setLayout()
        addImageAction()
    }

    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+300)
    }

    private func setNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Concluir", style: .plain, target: self, action: #selector(create))
        navigationItem.title = "Comunidade"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(close))
    }

    private func setLayout() {
        locationLabel.text = fetchedAddress?.stateDistrict
        nameTextField.delegate = self
        tagTextField.delegate = self
        descriptionTextField.delegate = self
        descriptionTextField.clipsToBounds = true
        descriptionTextField.layer.cornerRadius = 5
        descriptionTextField.text = "Descrição"
        descriptionTextField.textColor = UIColor.lightGray
        view.backgroundColor = PaleteColor.color2
    }
    
    private func dismissKeyboardView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    private func addImageAction() {
        let action = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        symbolView.addGestureRecognizer(action)
    }

    private func showAllert() {
        let missingInformationAlert = UIAlertController(title: "Imagem",
                                                       message: "Por favor, preencha todos os campos e selecione uma imagem antes de continuar!",
                                              preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        missingInformationAlert.addAction(cancelAction)
        self.present(missingInformationAlert, animated: true, completion: nil)
    }

    private func showLoading () {
        loadingView.isHidden = false
    }

    private func dismissLoading () {
        loadingView.isHidden = true
    }

    private func isDataValid(_ name: String, _ tag: String, _ description: String) -> Bool {
        let isNameValid = isTextValid(name)
        let isTagValid = isTextValid(tag)
        let isDescriptionValid = isDescriptionValid(description)

        if !isNameValid || !isTagValid || !isDescriptionValid {
            textFieldErrorMessage(isNameValid, isTagValid, isDescriptionValid)
            return false
        } else {
            return true
        }
    }

    private func textFieldErrorMessage(_ isNameValid: Bool , _ isTagValid: Bool, _ isDescriptionValid: Bool) {
        if !isNameValid {
            nameTextField.text = "Insira um Nome"
            nameTextField.textColor = UIColor.red
        }

        if !isTagValid {
            tagTextField.text = "Insira uma Tag"
            tagTextField.textColor = UIColor.red
        }

        if !isDescriptionValid {
            descriptionTextField.text = "Insira uma Descrição"
            descriptionTextField.textColor = UIColor.red
        }
    }

    private func isTextValid(_ text: String) -> Bool {
        if text == "" {
            return false
        }
        return true
    }

    private func isDescriptionValid(_ text: String) -> Bool {
        if !isTextValid(text) || text == "Descrição" {
            return false
        }
        return true
    }

    private func saveCommunity(_ community: Comunidade) {
        Task.init(priority: .high) {
            await community.saveInDatabase()
            isSaving = false
            self.dismiss(animated: true)
        }
        isSaving = true
    }

    @objc private func create() {
        guard let name = nameTextField.text, let tag = tagTextField.text, let description = descriptionTextField.text, let fetchedAddress = fetchedAddress, let image = image.image else {
            _ = isDataValid(nameTextField.text ?? "", tagTextField.text ?? "", descriptionTextField.text ?? "")
            showAllert()
            return
        }

        view.endEditing(true)

        if isDataValid(name, tag, description)  {
            navigationItem.rightBarButtonItem?.isEnabled = false
            let community = Comunidade(
                description: description,
                name: name,
                tags: tag,
                image: image,
                country: fetchedAddress.country,
                city: fetchedAddress.city,
                state: fetchedAddress.state,
                city_district: fetchedAddress.stateDistrict)
            saveCommunity(community)
        }
    }

    @objc private func close() {
        self.dismiss(animated: true)
    }

    @objc private func selectImage() {
        let viewController = UIImagePickerController()
        viewController.sourceType = .photoLibrary
        viewController.delegate = self
        viewController.allowsEditing = true
        self.present(viewController, animated: true)
    }
}

extension CreateCommunityViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            image.image = selectedImage
        } else {
            image.image = UIImage(named: "images")
        }

        imagePicker.isHidden = true
        self.dismiss(animated: true)
    }
}

extension CreateCommunityViewController: UITextViewDelegate {
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

extension CreateCommunityViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "Insira um Nome" || textField.text == "Insira uma Tag" || textField.text == "Insira um Nome" {
            textField.text = ""
            textField.textColor = .black
        }
    }
}
