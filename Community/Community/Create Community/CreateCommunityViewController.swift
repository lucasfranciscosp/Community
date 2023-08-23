//
//  CreateCommunityViewController.swift
//  Community
//
//  Created by Clissia Bozzer Bovi on 21/08/23.
//

import UIKit

class CreateCommunityViewController: UIViewController {

    @IBOutlet weak var imagePicker: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var tagTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var locationLabel: UIView!
    @IBOutlet weak var symbolView: UIView!
    @IBOutlet weak var image: UIImageView!
    private var fetchedAddress: Address?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setLayout()
        addImageAction()
        Localization().getAddress() { endereco in
            if let endereco = endereco {
                // Usar os dados de endereço aqui
                self.fetchedAddress = endereco
                print(endereco.address.city)
                print(endereco.address.cityDistrict)
            } else {
                // Caso onde não achar o endereço baseado na latitude e longitude
            }
        }

    }
    
    private func setNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(create))
        navigationItem.title = "Comunidade"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(close))
    }
    
    private func setLayout() {
       // locationLabel.text = logica de pegar loc
        imagePicker.layer.cornerRadius = 10
        imagePicker.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        image.layer.cornerRadius = 10
        image.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.backgroundColor = PaleteColor.color2
    }
    
    private func addImageAction() {
        let action = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        symbolView.addGestureRecognizer(action)
    }
    
    private func showAllert() {
        let missingInformationAlert = UIAlertController(title: "Campos não preenchidos",
                                                       message: "Por favor, preencha todos os campos antes de continuar!",
                                              preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        missingInformationAlert.addAction(cancelAction)
        self.present(missingInformationAlert, animated: true, completion: nil)
    }
    
    @objc private func create() {
        guard let name = nameTextField.text, let tag = tagTextField.text, let description = descriptionTextField.text else { return }
        if name == "" || tag == "" || description == "" {
            showAllert()
        } else {
            //salvar
            //aqui esta printando em optional
            if let address = fetchedAddress {
                print(address.address.postcode)
            }
            //Comunidade(image: "", tags: tag, name: name, location: "", description: description)
            // aqui só printando optional
            print(fetchedAddress?.address.country)
            self.dismiss(animated: true)
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
