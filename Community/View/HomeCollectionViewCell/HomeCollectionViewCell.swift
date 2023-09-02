//
//  HomeCollectionViewCell.swift
//  Community
//
//  Created by Clissia Bozzer Bovi on 16/08/23.
//

import UIKit

struct HomeCollectionViewCellData {
    let image: UIImage
    let tags: String
    let name: String
    let location: String
}


class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var comunnityReviewSize: NSLayoutConstraint!
    @IBOutlet weak var spacing: NSLayoutConstraint!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var tags: UILabel!
    @IBOutlet weak var communityReview: UIStackView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var location: UILabel!
    private var communityInReview: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setCell(data: HomeCollectionViewCellData) {
        setCellData(data)
        setCellLayout()
        setComunnityReview()
        setGradient()
    }
    
    private func setCellData(_ data: HomeCollectionViewCellData) {
        self.name.text = data.name
        self.tags.text = data.tags
        self.location.text = data.location
        self.image.image = data.image
    }
    
    private func setCellLayout() {
        self.layer.cornerRadius = 15
    }

    private func setComunnityReview() {
        if !communityInReview {
            communityReview.isHidden = true
            comunnityReviewSize.constant = 0
            spacing.constant = 0
        }
    }

    private func setGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x : 0.0, y : 0.6)
        gradient.endPoint = CGPoint(x :0.0, y: 1.0)
        gradient.frame = gradientView.bounds
        self.gradientView.layer.addSublayer(gradient)
    }
}
