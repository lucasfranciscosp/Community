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
        CellContent(image: "person.3", title: "Minhas Comunidades", description: "Administre as comunidades criadas e salvas"),
        CellContent(image: "party.popper.fill", title: "Meus eventos", description: "Administre os eventos criados e salvos")
    ]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customView = CustomView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(customView)
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 321),
            customView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customView.widthAnchor.constraint(equalToConstant: 358), // Defina a largura desejada
            customView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -104)
        ])

        customView.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: customView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: customView.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: customView.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: customView.bottomAnchor)
        ])
        
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = UIColor(red: 234.0/255, green: 216.0/255, blue: 212.0/255, alpha: 1.0)
       
        title = "Perfil"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.hidesBackButton = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "cell \(indexPath.row + 1)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("cell tapped")
    }

    
}

class CustomView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        
        self.layer.cornerRadius = 100
        self.layer.backgroundColor = UIColor.white.cgColor
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
        addSubview(titulo)
        addSubview(descricao)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
