//
//  ProductsCollesctionViewController.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 08/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import UIKit
import EBSSwiftUtils

protocol ProductsCollesctionViewInput: AnyObject {
	func setupInitialState()
    func didUpdateCollectionStructure(cells: [ProductsCollesctionCellType])
}

protocol ProductsCollesctionViewOutput {
    func viewIsReady()
    func pagination(pag: Int)
}

final class ProductsCollesctionViewController: BaseVC, StoryboardInstantiable {
	static var storyboardName: String = "ProductsCollesction"
	
    var presenter: ProductsCollesctionViewOutput!
    var moduleInput: ProductsCollesctionModuleInput!
    private var isLoading: Bool = false
    private var countProductPerPage: Bool?
    private var cells: [ProductsCollesctionCellType] = []
    private var page: Int = 1

    
    // MARK: - Outlets
    
    @IBOutlet private weak var collectionView: UICollectionView!

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        presenter.viewIsReady()
        self.presenter.viewIsReady()
    }

    // MARK: - Configure
    
    private func configureCollectionView() {
        collectionView.register(ProductCVC.self, FoterCVC.self)
		
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func createSpinnerFooter()-> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
}

// MARK: - ProductsCollesctionViewInput

extension ProductsCollesctionViewController: ProductsCollesctionViewInput {
	func setupInitialState() {

    }

    func didUpdateCollectionStructure(cells: [ProductsCollesctionCellType]) {
        self.cells = cells
        print(cells)
        self.collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension ProductsCollesctionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
}

// MARK: - UICollectionViewDelegate

extension ProductsCollesctionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch cells[indexPath.row] {
        case .product(product: let product):
            let cell = collectionView[ProductCVC.self, indexPath]
            cell.setup(model: product)
            collectionView.reloadData()
            return cell
        case .footer:
            let cell = collectionView[FoterCVC.self, indexPath]
            collectionView.reloadData()
            return cell
        }
    }    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProductsCollesctionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch cells[indexPath.row] {
        case .product(product: _):
            return CGSize(width: collectionView.frame.width, height: 200)
        case .footer:
            return CGSize(width: collectionView.frame.width, height: 100)
        }
    }
}

extension ProductsCollesctionViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.collectionView.contentOffset.y >= (self.collectionView.contentSize.height - self.collectionView.bounds.size.height)) {
            self.presenter.pagination(pag: page)
          }
    }
}

