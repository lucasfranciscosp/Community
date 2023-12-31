//
//  LoggedProfileViewController.swift
//  Community
//
//  Created by Pamella Alvarenga on 30/08/23.
//

import Foundation
import UIKit

class LoggedProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView()
    
    let tableViewContent = [
        CellContent(image: "person.3.fill", title: "Minhas Comunidades", description: "Administre as comunidades criadas e salvas"),
        CellContent(image: "party.popper.fill", title: "Meus eventos", description: "Administre os eventos criados e salvos")
    ]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profileView = UIView()
        let profileImageView = UIImageView()
        let labelNomeUsuario = UILabel()
        //let editProfileButton = UIButton()
        
        // Configurar a UIView para a foto de perfil e o botão de edição
        profileView.translatesAutoresizingMaskIntoConstraints = false
               view.addSubview(profileView)
               NSLayoutConstraint.activate([
                   profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
                   profileView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                   profileView.heightAnchor.constraint(equalToConstant: 180),
                   profileView.widthAnchor.constraint(equalToConstant: 180)
               ])
        
        profileView.addSubview(profileImageView)

        // Configurar a UIImageView para a foto de perfil
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.image = UIImage(named: "profile_defalu_image") // Imagem padrão
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 90 // Corner radius desejado
        profileImageView.clipsToBounds = true
        profileView.addSubview(profileImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: profileView.leadingAnchor),
            profileImageView.trailingAnchor.constraint(equalTo: profileView.trailingAnchor),
            profileImageView.topAnchor.constraint(equalTo: profileView.topAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: profileView.bottomAnchor)
        ])
        
        // Configurar o botão de edição da foto de perfil
//        editProfileButton.translatesAutoresizingMaskIntoConstraints = false
//        editProfileButton.setImage(UIImage(systemName: "camera"), for: .normal) // Ícone de câmera
//        editProfileButton.addTarget(self, action: #selector(editProfileImage), for: .touchUpInside)
//        profileView.addSubview(editProfileButton)
                        
        
        
        let customView = CustomView()
        
        customView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(customView)
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 321),
            customView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customView.widthAnchor.constraint(equalToConstant: 358), // Defina a largura desejada
            customView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -104),
        ])

        customView.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 96
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.clear
        tableView.layer.cornerRadius = customView.layer.cornerRadius
        tableView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: customView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: customView.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: customView.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: customView.bottomAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(labelNomeUsuario)
        labelNomeUsuario.text = "Fulaninho"
        labelNomeUsuario.font = UIFont.systemFont(ofSize: 34)

        labelNomeUsuario.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelNomeUsuario.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 4),
            labelNomeUsuario.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelNomeUsuario.bottomAnchor.constraint(equalTo: customView.topAnchor, constant: -48)

            //labelNomeUsuario.bottomAnchor.constraint(equalTo: customView.topAnchor, constant: -104),
        ])

        
        view.backgroundColor = UIColor(red: 234.0/255, green: 216.0/255, blue: 212.0/255, alpha: 1.0)
       
        title = "Perfil"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.hidesBackButton = true
    }
    
    
    @objc func editProfileImage() {
            // Implemente a lógica para permitir que o usuário selecione ou edite a foto de perfil aqui
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        let cellContent = tableViewContent[indexPath.row]
        cell.logoImage.image = UIImage(systemName: cellContent.image)
        cell.titulo.text = cellContent.title
        cell.descricao.text = cellContent.description
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       
        if indexPath.row == 0 {
            let userCommunitiesVC = UserCommunitiesViewController()
            
            navigationController?.pushViewController(userCommunitiesVC, animated: true)
        }
        
        if indexPath.row == 1 {
            let userEventsVC = UserEventsViewController()
            navigationController?.pushViewController(userEventsVC, animated: true)
        }
    }
}

class CustomView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        
        self.layer.cornerRadius = 100
        self.backgroundColor = UIColor(red:246.0/255, green:238.0/255, blue:233.0/255, alpha: 1.0)
        self.clipsToBounds = true
    }
}

struct CellContent {
    var image: String
    var title: String
    var description: String
}

class CustomCell: UITableViewCell {
    let logoImage = UIImageView()
    let titulo = UILabel()
    let descricao = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(logoImage)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.tintColor = .orange
        
        addSubview(titulo)
        titulo.translatesAutoresizingMaskIntoConstraints = false
        titulo.font = UIFont.boldSystemFont(ofSize: 17)

        addSubview(descricao)
        descricao.translatesAutoresizingMaskIntoConstraints = false
        descricao.textColor = .lightGray
        descricao.font = UIFont.systemFont(ofSize: 15)
        descricao.numberOfLines = 0

        
        NSLayoutConstraint.activate([
                    logoImage.centerYAnchor.constraint(equalTo: centerYAnchor),
                    logoImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                    logoImage.heightAnchor.constraint(equalToConstant: 29),
                    logoImage.widthAnchor.constraint(equalToConstant: 51),

                    titulo.topAnchor.constraint(equalTo: topAnchor, constant: 14),
                    titulo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80),
                    
                    descricao.topAnchor.constraint(equalTo: topAnchor, constant: 38),
                    descricao.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80),
                    descricao.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -36)
        ])

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
