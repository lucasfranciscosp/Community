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
    
    private let button: UIView = {

        let btn = UIButton(type: .system)
        let image = UIImage(systemName: "arrow.clockwise.circle")
        let imageView = UIImageView(image: image)
        
        
//        btn.setImage(image, for: .normal)
//        btn.imageView?.contentMode = .scaleToFill
        btn.addSubview(imageView)
        btn.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            btn.heightAnchor.constraint(equalToConstant: 40),
            btn.widthAnchor.constraint(equalToConstant: 40),
            
            imageView.leadingAnchor.constraint(equalTo: btn.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: btn.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: btn.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: btn.bottomAnchor),
        ])
        return btn
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
        stack.addArrangedSubview(button)
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
        stack.arrangedSubviews[0].addGestureRecognizer(UITapGestureRecognizer(target: controller, action: #selector(controller.refreshDataFromButtom)))
    }
}
