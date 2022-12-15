//
//  ProductsListViewController.swift
//  Thirdwayv
//
//  Created by mohammed balegh on 15/12/2022.
//

import UIKit

class ProductsListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, PinterestLayoutDelegate {
    // MARK: Outlets

    @IBOutlet weak var productsCollectionView: UICollectionView!
    // MARK: Properties

    private let viewModel: ProductsListViewModelType

    // MARK: Init

    init(viewModel: ProductsListViewModelType) {
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
        setupCollectionView()
    }
}

extension ProductsListViewController {
    func setupCollectionView() {
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        productsCollectionView.register(UINib(nibName: "productsCollectionView", bundle: nil), forCellWithReuseIdentifier: "productsCollectionView")
        if let layout = productsCollectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        productsCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - collectionView
extension ProductsListViewController {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        <#code#>
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
}

// MARK: - Actions

extension ProductsListViewController {}

// MARK: - Configurations

extension ProductsListViewController {}

// MARK: - Private Handlers

private extension ProductsListViewController {}
