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
    
    var evento: Evento?
    func setEvento(_ evento: Evento) {
        self.evento = evento
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = PaleteColor.color2
        view.addSubview(scrollView)
        layout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let layout = view.safeAreaLayoutGuide
        scrollView.centerXAnchor.constraint(equalTo: layout.centerXAnchor).isActive = true
        scrollView.centerYAnchor.constraint(equalTo: layout.centerYAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: layout.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: layout.heightAnchor).isActive = true
    }
    
    func layout() {
        let appbar: UIView = {
            let stack = UIStackView()
            let fechar = UIButton(type: .system)
            fechar.setTitle("Fechar", for: .normal)
            fechar.addTarget(self, action: #selector(popView), for: .touchUpInside)
            let btnPadding = UIStackView()
            btnPadding.addArrangedSubview(fechar)
            btnPadding.axis = .horizontal
            btnPadding.distribution = .equalCentering
            
            
            let evento = UILabel()
            evento.text = "Evento"
            evento.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            let rightPad = UIView()
        
            NSLayoutConstraint.activate([
                btnPadding.widthAnchor.constraint(equalToConstant: 70),
                rightPad.widthAnchor.constraint(equalToConstant: 70)
            ])
            
            [btnPadding, evento, rightPad].forEach {stack.addArrangedSubview($0)}
            stack.axis = .horizontal
            stack.distribution = .equalCentering
            stack.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
    //        rightPad.backgroundColor = .red
    //        evento.backgroundColor = .blue
    //        btnPadding.backgroundColor = .yellow
            return stack
        }()
        
        let divider: UIView = {
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
        
        lazy var eventDescription: UIView = {
          let description = UILabel()
            description.numberOfLines = 0
            description.translatesAutoresizingMaskIntoConstraints = false
            
            
            description.text = self.evento?.description
            
            let leftPad = UIView()
            leftPad.translatesAutoresizingMaskIntoConstraints = false
            let rightPad = UIView()
            rightPad.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                leftPad.widthAnchor.constraint(equalToConstant: 15),
                rightPad.widthAnchor.constraint(equalToConstant: 15),
            ])
            
            let padding = UIStackView()
            padding.axis = .horizontal
            padding.addArrangedSubview(leftPad)
            padding.addArrangedSubview(description)
            padding.addArrangedSubview(rightPad)

            return padding
        }()
        
        var card: UIView = {
            
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
                text.text = evento?.name
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
                
                stack.addArrangedSubview(generateDescriptionRow(evento?.city_district ?? "", "location"))
                stack.addArrangedSubview(generateDescriptionRow(evento?.dataHorario ?? "", "clock"))
                stack.addArrangedSubview(generateDescriptionRow(evento?.nomeComunidade ?? "", "person.3"))
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
        
        scrollView.addSubview(body)
       
        body.addArrangedSubview(appbar)
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
    }
    
    @objc func popView() {
        self.dismiss(animated: true)
    }
}

