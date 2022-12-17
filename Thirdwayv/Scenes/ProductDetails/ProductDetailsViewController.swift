//  
//  ProductDetailsViewController.swift
//  Thirdwayv
//
//  Created by mohammed balegh on 16/12/2022.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var productImageView: ImageLoader!

    // MARK: Properties
    private let viewModel: ProductDetailsViewModelType

    // MARK: Init

    init(viewModel: ProductDetailsViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
    }

    func setup(data: Product) {
        productImageView.loadImageWithUrl(data.image.url)
        productDescriptionLabel.text = data.productDescription
    }

    func setupButton() {
        dismissButton.applyLightShadow()
    }

    @IBAction func dismissTapped(_ sender: Any) {
        dismiss(animated: true)
    }

}

// MARK: - Actions

extension ProductDetailsViewController {}

// MARK: - Configurations

extension ProductDetailsViewController {}

// MARK: - Private Handlers

private extension ProductDetailsViewController {}
