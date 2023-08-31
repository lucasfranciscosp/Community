//
//  EventoModalViewController.swift
//  Community
//
//  Created by Caio Melloni dos Santos on 31/08/23.
//

import UIKit

import UIKit

class EventoModalViewController: UIViewController, UIScrollViewDelegate {
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.delegate = self
        scroll.backgroundColor = PaleteColor.color2
        return scroll
    }()
    
    lazy var body :UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var divider: UIView = {
        let vw = UIView()
        vw.backgroundColor = .separator
        vw.translatesAutoresizingMaskIntoConstraints = false
        let padding = UIView()
        padding.translatesAutoresizingMaskIntoConstraints = false
        padding.addSubview(vw)
        padding.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        NSLayoutConstraint.activate([
            vw.heightAnchor.constraint(equalToConstant: 1),
            vw.widthAnchor.constraint(equalTo: padding.widthAnchor, multiplier: 0.95),
            vw.centerXAnchor.constraint(equalTo: padding.centerXAnchor),
            vw.centerYAnchor.constraint(equalTo: padding.centerYAnchor)
        ])

        return padding
    }()
    
    
    lazy var card: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = PaleteColor.color2
        vw.heightAnchor.constraint(equalToConstant: 330).isActive = true
        vw.layer.cornerRadius = 10.00
        vw.clipsToBounds = true
        
        let cardCover: UIImageView = {
            let vw = UIImageView()
            vw.image = UIImage(named: "Image")
            vw.translatesAutoresizingMaskIntoConstraints = false
            vw.contentMode = .scaleAspectFill
            vw.clipsToBounds = true
            
            return vw
        }()
        
        let cardTitle: UILabel = {
            let text = UILabel()
            text.text = "Campeonato"
            text.font = UIFont.preferredFont(forTextStyle: .title1)
            text.translatesAutoresizingMaskIntoConstraints = false
            return text
        }()
        
        let cardInfosStack: UIStackView = {
            let stack = UIStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            stack.alignment = .leading
            stack.distribution = .equalCentering
            
            stack.addArrangedSubview(generateDescriptionRow("Rua dos Cocais", "location"))
            stack.addArrangedSubview(generateDescriptionRow("07/09 14:00h", "clock"))
            stack.addArrangedSubview(generateDescriptionRow("Rainha do Bairro", "person.3"))
            return stack
        }()
        
        [cardCover, cardTitle, cardInfosStack].forEach {vw.addSubview($0)}
        
        NSLayoutConstraint.activate([
            cardCover.widthAnchor.constraint(equalTo: vw.widthAnchor),
            cardCover.topAnchor.constraint(equalTo: vw.topAnchor),
            cardCover.bottomAnchor.constraint(equalTo: vw.centerYAnchor),
            
            cardTitle.topAnchor.constraint(equalTo: cardCover.bottomAnchor, constant: 12),
            cardTitle.leadingAnchor.constraint(equalTo: vw.leadingAnchor, constant: 12),
            cardTitle.heightAnchor.constraint(equalToConstant: 30),
            
            cardInfosStack.topAnchor.constraint(equalTo: cardTitle.bottomAnchor, constant: 12),
            cardInfosStack.bottomAnchor.constraint(equalTo: vw.bottomAnchor, constant: -12),
            cardInfosStack.leadingAnchor.constraint(equalTo: cardTitle.leadingAnchor),
            cardInfosStack.trailingAnchor.constraint(equalTo: vw.trailingAnchor)
        ])
        
        return vw
    }()
    
    
    
    lazy var eventDescription: UIView = {
      let vw = UILabel()
        vw.numberOfLines = 0
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        var lorem = ""
        for _ in 0...333 {
            lorem += " lorem"
        }
        
        vw.text = lorem
        
        let padding = UIView()
        padding.translatesAutoresizingMaskIntoConstraints = false
        padding.addSubview(vw)

        NSLayoutConstraint.activate([
            vw.leadingAnchor.constraint(equalTo: padding.leadingAnchor, constant: 15),
            vw.trailingAnchor.constraint(equalTo: padding.trailingAnchor, constant: -4),
            vw.topAnchor.constraint(equalToSystemSpacingBelow: padding.topAnchor, multiplier: 1),
            padding.heightAnchor.constraint(equalTo: vw.heightAnchor, constant: 20)
        ])

        return padding
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = PaleteColor.color2
        view.addSubview(scrollView)
        scrollView.addSubview(body)
        
        body.addArrangedSubview(card)
        body.addArrangedSubview(divider)
        body.addArrangedSubview(eventDescription)
        
        NSLayoutConstraint.activate([
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            body.topAnchor.constraint(equalTo: scrollView.topAnchor),
            body.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            body.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
         
        // Crie um botão "back" com título
        let backButton = UIBarButtonItem(title: "Fechar", style: .plain, target: self, action: #selector(fecharModal))
        
        // Defina o botão "back" como o botão esquerdo da barra de navegação
        navigationItem.leftBarButtonItem = backButton
        
        
        backButton.target = self
        backButton.action = #selector(fecharModal)
        
       


    }
    
    @objc func fecharModal() {
        print("fechar!")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let layout = view.safeAreaLayoutGuide
        scrollView.centerXAnchor.constraint(equalTo: layout.centerXAnchor).isActive = true
        scrollView.centerYAnchor.constraint(equalTo: layout.centerYAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: layout.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: layout.heightAnchor).isActive = true
    }
}

