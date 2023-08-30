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
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(card)
        
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: topAnchor),
            card.leadingAnchor.constraint(equalTo: leadingAnchor),
            card.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
