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
    func didTapFavorite(model: About)
    func didTapFavoriteButtonView()
    func didTapMyCard()
    func didTapAddCart(model: About)
    
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
    @IBOutlet weak var gridButton: UIButton!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var imageSale: UIImageView!
    @IBOutlet weak var uiViewCount: UIView!
    @IBOutlet weak var uiViewBack: UIView!
    

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        presenter.viewIsReady()
        setButton()
    }

    // MARK: - Configure
    
    private func configureCollectionView() {
        collectionView.register(ProductCVC.self)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setButton() {
        gridButton.backgroundColor = UIColor(named: "blue")
        gridButton.tintColor = UIColor(named: "gri")
        gridButton.cornerRadius = 2
        listButton.backgroundColor =  UIColor(named: "gri")
        listButton.tintColor = UIColor(named: "blue")
        gridButton.cornerRadius = 2
        uiViewCount.cornerRadius = uiViewCount.frame.size.width/2
        uiViewBack.roundCorners([.topRight, .bottomRight], radius: 3)
        imageSale.roundCorners([.topLeft, .bottomLeft], radius: 3)
        
    }
    
    // MARK: - Action
    @IBAction func didTapButtonProfile(_ sender: Any) {
        self.presenter.didTapButtonProfile()
    }
    
    @IBAction func gridButton(_ sender: Any) {
        stack = false
        collectionView.reloadData()
        setButton()
        
    }
    
    @IBAction func listButton(_ sender: Any) {
        buttonType = .list
        stack = true
        collectionView.reloadData()
        gridButton.backgroundColor = UIColor(named: "gri")
        gridButton.tintColor = UIColor(named: "blue")
        listButton.backgroundColor =  UIColor(named: "blue")
        listButton.tintColor = UIColor(named: "gri")

    }
    @IBAction func filterAction(_ sender: Any) {
        self.presenter.didTapFilterButton()
//        collectionView.reloadData()
        
    }
    
    @IBAction func favoritesButtoonView(_ sender: Any) {
        self.presenter.didTapFavoriteButtonView()
        
    }
    
    @IBAction func myCard(_ sender: Any) {
        self.presenter.didTapMyCard()
    
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
            let params: ProductCVC.Params = .init(id: product.id ?? 0, name: product.name ?? "", size: product.size ?? "", pice: product.price ?? 0, priceSale: product.price ?? 0, image: product.mainImage ?? "")
            cell.setup(model: params, stack: stack )
            cell.didTapFavorite = { [weak self] in
                self?.presenter.didTapFavorite(model: product)
            }

            cell.didTapAddCart = { [weak self] in
                self?.presenter.didTapAddCart(model: product)
            }
            
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

