//
//  ProductsListViewController.swift
//  Thirdwayv
//
//  Created by mohammed balegh on 15/12/2022.
//

import UIKit

class ProductsListViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var productsCollectionView: UICollectionView!

    // MARK: Properties
    var selectedCell: ProductCollectionViewCell?
    private let viewModel: ProductsListViewModelType
    private let popup = AlertPopup()
    private var selectedCellImageViewSnapshot: UIView?
    private var animator: Animator?

    // MARK: Init

    init(viewModel: ProductsListViewModelType) {
        self.viewModel = ProductsListViewModel(getProducts: ProductsList())
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
        viewModel.loadProducts()
        setupCollectionView()
        bindViewModel()
    }

    func presentSecondViewController(with data: Product) {
        let secondViewController = ProductDetailsViewController(viewModel: ProductDetailsViewModel())
        let _ = secondViewController.view
        secondViewController.transitioningDelegate = self

        secondViewController.modalPresentationStyle = .custom
        secondViewController.setup(data: data)
        present(secondViewController, animated: true)
    }

}

extension ProductsListViewController {
    func setupCollectionView() {
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        productsCollectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCollectionViewCell")
        if let layout = productsCollectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
    }
}

extension ProductsListViewController {
    func bindViewModel() {
        viewModel.products.observe(on: self) { [weak self] _ in
            if self!.viewModel.products.value.count > 0 {
                self?.productsCollectionView.reloadData()
            } else if self!.viewModel.products.value.count == 0 && NetworkMonitor.shared.isConnected.value == false {
                self?.view.addSubview(self!.popup)
                self?.popup.presentAsInternetConnectionError()
            }
        }
    }
}

// MARK: - collectionView
extension ProductsListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.products.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        cell.setup(product: viewModel.products.value[indexPath.row])
        return cell
    }
}

extension ProductsListViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let productHeight = viewModel.products.value[indexPath.row].image.height
        return CGFloat(productHeight)
    }
}

extension ProductsListViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedCell = collectionView.cellForItem(at: indexPath) as? ProductCollectionViewCell
        selectedCellImageViewSnapshot = selectedCell?.productImageView.snapshotView(afterScreenUpdates: false)
        presentSecondViewController(with: viewModel.products.value[indexPath.row])
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.products.value.count - 3 {
            viewModel.loadProducts()
        }
    }
}

// MARK: - Actions

extension ProductsListViewController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let firstViewController = presenting as? ProductsListViewController,
              let secondViewController = presented as? ProductDetailsViewController,
              let selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
        else { return nil }

        animator = Animator(type: .present, firstViewController: firstViewController, secondViewController: secondViewController, selectedCellImageViewSnapshot: selectedCellImageViewSnapshot)
        return animator
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let secondViewController = dismissed as? ProductDetailsViewController,
              let selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
        else { return nil }

        animator = Animator(type: .dismiss, firstViewController: self, secondViewController: secondViewController, selectedCellImageViewSnapshot: selectedCellImageViewSnapshot)
        return animator
    }
}
