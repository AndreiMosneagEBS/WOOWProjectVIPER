//
//  BayViewController.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 11/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import UIKit
import EBSSwiftUtils

protocol BayViewInput: AnyObject {
    func setupInitialState()
    func didUpdateCollectionStructure(cells: [BayCellType])
    func setTotalPrice(price: Int)
    func updateCardOfCount(count: Int)
}

protocol BayViewOutput {
    func viewIsReady()
    func didTapDeleteProduct(id: Int)
    func didTapPlus(productId: Int)
    func didTapMinus(productId: Int)
    func totalPriceCout(price: Int)
}

final class BayViewController: BaseVC, StoryboardInstantiable {
    static var storyboardName: String = "Bay"
    
    var presenter: BayViewOutput!
    var moduleInput: BayModuleInput!
    var coutText: String?
    var priceTotal: Int = 0
    var coutOfProduct: Int = 0
    private var cells: [BayCellType] = []
    
    // MARK: - Outlets
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var viewLabel: UIView!
    @IBOutlet weak var priceProduct: UILabel!
    @IBOutlet weak var deliveri: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var coutPoductSale: UILabel!
    
    
    // MARK: - View lifecycle
    override func viewWillAppear(_ animated: Bool) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        presenter.viewIsReady()
        setButton()

    }
    
    // MARK: - Configure
    
    private func configureCollectionView() {
        collectionView.register(
            BayCVC.self
        )
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setButton() {
        viewLabel.cornerRadius = viewLabel.frame.width / 2
        collectionView.reloadData()
    
        
    }
}

// MARK: - BayViewInput

extension BayViewController: BayViewInput {
    func updateCardOfCount(count: Int) {
        self.coutPoductSale.text = String(count)
    }
    
    func setTotalPrice(price: Int) {
        priceProduct.text = "\(String(price)) $"
        if priceProduct.text == "0 $" {
            deliveri.text = "0 $"
        } else {
            deliveri.text = "250 $"
        }
        total.text = "\(String(price + 250)) $"
    }
        
    func setupInitialState() {
    }
    
    func didUpdateCollectionStructure(cells: [BayCellType]) {
        self.cells = cells
        self.collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension BayViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
}

// MARK: - UICollectionViewDelegate

extension BayViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch cells[indexPath.row] {
        case .poductBay(let product):
            let cell = collectionView[BayCVC.self, indexPath]
            let params: BayCVC.Params = .init(id: product.id,
                                              name: product.name,
                                              size: product.size,
                                              price: product.price,
                                              priceSale: product.price,
                                              image: product.image,
                                              count: product.count)
            
            cell.setup(params: params)
            cell.didTapPlus = { [weak self] in
                self?.presenter.didTapPlus(productId: product.id)
            }
            cell.didTapMinus = { [weak self] in
                self?.presenter.didTapMinus(productId: product.id)
            }
            cell.didTapDelete = { [weak self] in
                self?.presenter.didTapDeleteProduct(id: product.id)
            }
            cell.labelPriceTotal = { [weak self] totalPiceProduct in
                self?.presenter.totalPriceCout(price: totalPiceProduct)
                self?.priceTotal = totalPiceProduct
            }
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension BayViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch cells[indexPath.row] {
        case .poductBay:
            return CGSize(width: collectionView.bounds.width, height: 170)
        }
    }
}
