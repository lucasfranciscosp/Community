//
//  CreateCommunity2ViewController.swift
//  Community
//
//  Created by Clissia Bozzer Bovi on 31/08/23.
//

import UIKit

class CreateCommunityViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var addImageView: UIView!
    @IBOutlet weak var symbolView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var tagTextField: UITextField!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var descriptionContainerView: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var descriptionView: UIView!
    let defaultCornerRadius: CGFloat = 10
    let topCorners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    let bottomCorners: CACornerMask = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    var fetchedAddress: Address?
    var isSaving: Bool = false {
        didSet {
            isSaving ? showLoading() : dismissLoading()
        }
    }

    override func viewDidLoad() {
        setNavigationBar()
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
        locationLabel.text = fetchedAddress?.address.cityDistrict
        nameTextField.delegate = self
        tagTextField.delegate = self
        descriptionTextView.delegate = self
        descriptionTextView.text = "Descreva o tema"
        descriptionTextView.textColor = UIColor.lightGray
        view.backgroundColor = PaleteColor.color2
        setCorners()
    }
    
    private func setCorners() {
        nameView.layer.cornerRadius = defaultCornerRadius
        nameView.layer.maskedCorners = topCorners
        tagView.layer.cornerRadius = defaultCornerRadius
        tagView.layer.maskedCorners = bottomCorners
        descriptionView.layer.cornerRadius = defaultCornerRadius
        descriptionView.layer.maskedCorners = topCorners
        descriptionContainerView.layer.cornerRadius = defaultCornerRadius
        descriptionContainerView.layer.maskedCorners = bottomCorners
        image.layer.cornerRadius = defaultCornerRadius
        image.layer.maskedCorners = topCorners
        addImageView.layer.cornerRadius = defaultCornerRadius
        addImageView.layer.maskedCorners = topCorners
    }
    
    private func addImageAction() {
        let action = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        symbolView.addGestureRecognizer(action)
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
            descriptionTextView.text = "Insira uma Descrição"
            descriptionTextView.textColor = UIColor.red
        }
    }

    private func isTextValid(_ text: String) -> Bool {
        if text == "" {
            return false
        }
        return true
    }

    private func isDescriptionValid(_ text: String) -> Bool {
        if !isTextValid(text) || text == "Descreva o tema" {
            return false
        }
        return true
    }
    
    
    private func saveCommunity(_ community: Comunidade) -> Void {
        Task.init(priority: .high) {
            await community.saveInDatabase()
            isSaving = false
            self.dismiss(animated: true)
        }
        isSaving = true
    }
    
    private func showImageAllert() {
        let missingInformationAllert = UIAlertController(title: "Imagem",
                                                       message: "Por favor, preencha todos os campos e selecione uma imagem antes de continuar!",
                                              preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        missingInformationAllert.addAction(cancelAction)
        self.present(missingInformationAllert, animated: true, completion: nil)
    }
    
    private func showReviewAllert(completion: @escaping ()-> Void) {
        let reviewAllert = UIAlertController(title: "Moderação",
                                                       message: "Para garantir um espaço respeitoso para todos, nós revisamos todas as comunidades adicionadas. A sua Comunidade será enviada para revisão. ",
                                              preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirmar", style: .default) {_ in
            completion()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        reviewAllert.addAction(confirmAction)
        reviewAllert.addAction(cancelAction)
        self.present(reviewAllert, animated: true, completion: nil)
    }
    
    private func showLoading () {
        loadingView.isHidden = false
    }

    private func dismissLoading () {
        loadingView.isHidden = true
    }
    
    @IBAction func getPicture(_ sender: Any) {
        selectImage()
    }
    
    @objc func create() {
        guard let name = nameTextField.text, let tag = tagTextField.text, let description = descriptionTextView.text, let fetchedAddress = fetchedAddress, let image = image.image else {
            _ = isDataValid(nameTextField.text ?? "", tagTextField.text ?? "", descriptionTextView.text ?? "")
            showImageAllert()
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
                country: fetchedAddress.address.country,
                city: fetchedAddress.address.city,
                state: fetchedAddress.address.state,
                city_district: fetchedAddress.address.cityDistrict)
            showReviewAllert() {
                self.saveCommunity(community)
            }
        }
    }
    
    @objc private func selectImage() {
        let viewController = UIImagePickerController()
        viewController.sourceType = .photoLibrary
        viewController.delegate = self
        viewController.allowsEditing = true
        self.present(viewController, animated: true)
    }
    
    @objc func close() {
        self.dismiss(animated: true)
    }
}

extension CreateCommunityViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            image.image = selectedImage
        } else {
            image.image = UIImage(named: "images")
        }

        addImageView.isHidden = true
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
            textView.text = "Descreva o tema"
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

