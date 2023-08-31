//
//  CardEventoView.swift
//  Community
//
//  Created by Caio Melloni dos Santos on 30/08/23.
//

import UIKit

class CardEventoView: UICollectionViewCell {
    let card: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = PaleteColor.cardLight
        vw.heightAnchor.constraint(equalToConstant: 330).isActive = true
        vw.layer.cornerRadius = 10.00
        return vw
    }()
    
    let cover: UIImageView = {
        let vw = UIImageView()
        vw.image = UIImage(named: "Image")
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.layer.cornerRadius = 10.00
        return vw
    }()
    
    let title: UILabel = {
        let text = UILabel()
        text.text = "Campeonato"
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
        
        stack.addArrangedSubview(generateDescriptionRow("Rua dos Cocais", "location"))
        stack.addArrangedSubview(generateDescriptionRow("07/09 14:00h", "clock"))
        stack.addArrangedSubview(generateDescriptionRow("Rainha do Bairro", "person.3"))
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(card)
        card.addSubview(cover)
        card.addSubview(title)
        card.addSubview(infosStack)
        
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

fileprivate func generateDescriptionRow(_ description: String, _ systemImage: String) -> UIView {
    let text = UILabel()
    text.text = description
    text.font = UIFont.preferredFont(forTextStyle: .body)
    text.textColor = .secondaryLabel
    text.translatesAutoresizingMaskIntoConstraints = false
    text.widthAnchor.constraint(equalToConstant: 150).isActive = true
    
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
