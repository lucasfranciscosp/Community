//
//  Profile.swift
//  Community
//
//  Created by Pamella Alvarenga on 25/08/23.
//


import AuthenticationServices
import UIKit

class ProfileViewController: UIViewController {
    
    private let signInButton = ASAuthorizationAppleIDButton()
    private let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(signInButton)
        view.addSubview(label)

        view.backgroundColor = UIColor(red: 234.0/255, green: 216.0/255, blue: 212.0/255, alpha: 1.0)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        signInButton.cornerRadius = 100
        title = "Perfil"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureLabel()
        addConstraints()
        
    }

    
    private func addConstraints() {

        label.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
       // Add
        NSLayoutConstraint.activate([
            
            signInButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16),
            signInButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 50),
            signInButton.widthAnchor.constraint(equalToConstant: 358),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 26.5),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -26.5),
            label.bottomAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.bottomAnchor, constant: -400)
        
        ])
        
    }
 
    @objc func didTapSignIn() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
        
    }
    
    private func configureLabel() {
        label.text = "Entre com o AppleID para criar e salvar Comunidades e Eventos de interesse."
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 0

        
    }
    
    
}

extension UIViewController: ASAuthorizationControllerDelegate {
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("failed!")
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            let firstName = credentials.fullName?.givenName
            let lastName = credentials.fullName?.familyName
            let email = credentials.email
            
            // Criar uma instância da tela de perfil do usuário
            let profileScreen = LoggedProfileViewController()
            
            // Configurar os dados do usuário na tela de perfil, se necessário
            // profileScreen.firstName = firstName
            // profileScreen.lastName = lastName
            // profileScreen.email = email
            
            // Empurrar a tela de perfil do usuário para a pilha de visualizações
            navigationController?.pushViewController(profileScreen, animated: true)
            
        default:
            break
        }
    }
}

extension UIViewController: ASAuthorizationControllerPresentationContextProviding {
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
