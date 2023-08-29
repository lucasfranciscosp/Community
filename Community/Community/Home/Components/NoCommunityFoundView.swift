//
//  NoCommunityFoundView.swift
//  Community
//
//  Created by Caio Melloni dos Santos on 29/08/23.
//

import UIKit


class NoCommunityFoundView: UIView {
    private let text: UILabel = {
        let label = UILabel()
        label.text = "Nenhuma Comunidade encontrada."
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        return label
    }()
    
    private var icon: UIImageView = {
        let icon = UIImageView(image: UIImage(systemName:  "arrow.clockwise.circle"))
        icon.translatesAutoresizingMaskIntoConstraints = true
        icon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        icon.isUserInteractionEnabled = true
        return icon
    }()
    
    let stack = UIStackView()
    
    init() {
        super.init(frame: .zero)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func buildLayout() {
        
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.alignment = .center
        stack.addArrangedSubview(icon)
        stack.addArrangedSubview(text)
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
    }
    
    func configure(_ controller: HomeViewController) {
        stack.arrangedSubviews[0].addGestureRecognizer(UITapGestureRecognizer(target: controller, action: #selector(controller.refreshData)))
    }
}
