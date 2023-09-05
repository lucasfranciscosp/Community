//
//  CardEventoView.swift
//  Community
//
//  Created by Caio Melloni dos Santos on 30/08/23.
//

import UIKit

class CardEventoView: UICollectionViewCell {
    
    var superView: UICollectionViewController?
    
    var eventTitle: String = ""
    var bairro: String = ""
    var dataHorario: String = ""
    var nomeComunidade: String = ""
    var descricao: String = ""
    var evento: Evento?
    

    

    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    func setUpCell() {
        let card: UIButton = {
            let vw = UIButton(type: .custom)
            vw.translatesAutoresizingMaskIntoConstraints = false
            vw.backgroundColor = PaleteColor.cardLight
            vw.heightAnchor.constraint(equalToConstant: 330).isActive = true
            vw.layer.cornerRadius = 10.00
            vw.clipsToBounds = true
            return vw
        }()
        
        let cover: UIImageView = {
            let vw = UIImageView()
            vw.image = evento?.image
            vw.translatesAutoresizingMaskIntoConstraints = false
            vw.contentMode = .scaleAspectFill
            vw.clipsToBounds = true

            return vw
        }()
        
        let title: UILabel = {
            let text = UILabel()
            text.text = eventTitle
            text.font = UIFont.preferredFont(forTextStyle: .title1)
            text.translatesAutoresizingMaskIntoConstraints = false
            return text
        }()
        
        
        
        let infosStack: UIStackView = {
            let stack = UIStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            stack.alignment = .leading
            stack.distribution = .equalCentering
            
            stack.addArrangedSubview(generateDescriptionRow(bairro, "location"))
            stack.addArrangedSubview(generateDescriptionRow(dataHorario, "clock"))
            stack.addArrangedSubview(generateDescriptionRow(nomeComunidade, "person.3"))
            return stack
        }()
        
        addSubview(card)
        card.addSubview(cover)
        card.addSubview(title)
        card.addSubview(infosStack)
        
        setAutoLayout(card: card, cover: cover, title: title, infosStack: infosStack)
        
        card.addTarget(self, action: #selector(cardTapped), for: .touchUpInside)
    }
    
    @objc func cardTapped() {
        let vc = EventoModalViewController()
        vc.setEvento(evento!)
        vc.modalPresentationStyle = .formSheet
        vc.preferredContentSize = .init(width: 500, height: 800)
        superView?.present(vc, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAutoLayout(card: UIView, cover: UIView, title: UIView, infosStack: UIView) {
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: topAnchor),
            card.leadingAnchor.constraint(equalTo: leadingAnchor),
            card.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            cover.widthAnchor.constraint(equalTo: card.widthAnchor),
            cover.topAnchor.constraint(equalTo: card.topAnchor),
            cover.bottomAnchor.constraint(equalTo: card.centerYAnchor),
            
            title.topAnchor.constraint(equalTo: cover.bottomAnchor, constant: 12),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            title.heightAnchor.constraint(equalToConstant: 30),
            
            infosStack.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 12),
            infosStack.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -12),
            infosStack.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            infosStack.trailingAnchor.constraint(equalTo: card.trailingAnchor)
        ])
    }
    
    func configure(_ collectionView: UICollectionViewController, _ evento: Evento) {
       superView = collectionView
        self.eventTitle = evento.name
        self.bairro = evento.city_district
        self.dataHorario = evento.dataHorario
        self.nomeComunidade = evento.nomeComunidade
        self.descricao = evento.description
        self.evento = evento
        
        setUpCell()
    }
    
    func setDataCell(evento: Evento) {
        self.title.text = evento.name
        self.cover.image = evento.image
        
    }
}

func generateDescriptionRow(_ description: String, _ systemImage: String) -> UIView {
    let text = UILabel()
    text.text = description
    text.font = UIFont.preferredFont(forTextStyle: .body)
    text.textColor = .secondaryLabel
    text.translatesAutoresizingMaskIntoConstraints = false
    text.widthAnchor.constraint(equalToConstant: 180).isActive = true
    let image = UIImageView(image: UIImage(systemName: systemImage))
    image.tintColor = .secondaryLabel
    image.translatesAutoresizingMaskIntoConstraints = false
    
    let imageContainer = UIView()
    imageContainer.translatesAutoresizingMaskIntoConstraints = false
    imageContainer.addSubview(image)
    NSLayoutConstraint.activate([
        imageContainer.widthAnchor.constraint(equalToConstant: 35),
        
        image.centerYAnchor.constraint(equalTo: imageContainer.centerYAnchor),
        image.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor),
    ])
    
    let stack = UIStackView(arrangedSubviews: [imageContainer, text])
    stack.axis = .horizontal
    stack.distribution = .equalSpacing
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.widthAnchor.constraint(equalToConstant: 195).isActive = true
    return stack
}
