//
//  ProductCollectionViewCell.swift
//  Thirdwayv
//
//  Created by mohammed balegh on 15/12/2022.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productImageView: ImageLoader!

    override func awakeFromNib() {
        super.awakeFromNib()

        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1
    }

    func setup(product: Product) {
        productImageView.loadImageWithUrl(product.image.url)
        productPriceLabel.text = String(product.price) + "$"
        productDescriptionLabel.text = product.productDescription
        
    }

}
