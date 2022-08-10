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
    func pagination()
    func didTapButtonProfile()
    func didTapCell(model: About)
    func didTapFilterButton()
    
}

final class ProductsCollesctionViewController: BaseVC, StoryboardInstantiable {
	static var storyboardName: String = "ProductsCollesction"
	
    enum TypeButton {
        case grid
        case list
    }
    
    
    var presenter: ProductsCollesctionViewOutput!
    var moduleInput: ProductsCollesctionModuleInput!
    private var isLoading: Bool = false
    private var countProductPerPage: Bool?
    private var cells: [ProductsCollesctionCellType] = []
    private var page: Int = 1
    private var buttonType: TypeButton = .list
    private var stack: Bool = false

    
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
        collectionView.register(ProductCVC.self)
		
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: - Action
    
    @IBAction func gridButton(_ sender: Any) {
        stack = false
        collectionView.reloadData()
    }
    
    @IBAction func listButton(_ sender: Any) {
        buttonType = .list
        stack = true
        collectionView.reloadData()

    }
    @IBAction func filterAction(_ sender: Any) {
        self.presenter.didTapFilterButton()
//        collectionView.reloadData()    
        
    }
    
    
}

// MARK: - ProductsCollesctionViewInput

extension ProductsCollesctionViewController: ProductsCollesctionViewInput {
	func setupInitialState() {

    }

    func didUpdateCollectionStructure(cells: [ProductsCollesctionCellType]) {
        self.cells = cells
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
            cell.setup(model: product, stack: stack )
            
            return cell
     
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch cells[indexPath.section] {
        case .product(product: let product):
            self.presenter.didTapCell(model: product)
        }
    }
    
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProductsCollesctionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch cells[indexPath.row] {
        case .product(product: _):
            if stack{
                return CGSize(width: collectionView.frame.width, height: 170)
            }else {
                return CGSize(width: ((collectionView.frame.width)-5)/2, height: 250)

            }
       
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension ProductsCollesctionViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.collectionView.contentOffset.y >= (self.collectionView.contentSize.height - self.collectionView.bounds.size.height)) {
            self.presenter.pagination()
          }
    }
}

