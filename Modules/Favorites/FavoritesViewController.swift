//
//  FavoritesViewController.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 11/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import UIKit
import EBSSwiftUtils

protocol FavoritesViewInput: AnyObject {
	func setupInitialState()
    func didUpdateCollectionStructure(cells: [FavoritesCellType])
}

protocol FavoritesViewOutput {
    func viewIsReady()
    func didTapFavorite(model: FavoriteModel)
    func didSelectItem()
}

final class FavoritesViewController: BaseVC, StoryboardInstantiable {
	static var storyboardName: String = "Favorites"
	
    var presenter: FavoritesViewOutput!
    var moduleInput: FavoritesModuleInput!

    private var cells: [FavoritesCellType] = []
    
    // MARK: - Outlets
    
    @IBOutlet weak var viewLabel: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        presenter.viewIsReady()
        setButton()
    }
    
    // MARK: - Configure
    
    private func configureCollectionView() {
        collectionView.register(
			ProductCVC.self
		)
		
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setButton() {
        viewLabel.cornerRadius = viewLabel.frame.width / 2
    }
    
    
}

// MARK: - FavoritesViewInput

extension FavoritesViewController: FavoritesViewInput {
	func setupInitialState() {

    }

    func didUpdateCollectionStructure(cells: [FavoritesCellType]) {
        self.cells = cells
        self.collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension FavoritesViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
}

// MARK: - UICollectionViewDelegate

extension FavoritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch cells[indexPath.row] {
        case .products(let favorite) :
            let cell = collectionView[ProductCVC.self, indexPath]
            let params: ProductCVC.Params = .init(id: favorite.id,
                                                  name: favorite.name,
                                                  size: favorite.size,
                                                  pice: favorite.price,
                                                  priceSale: favorite.price,
                                                  image: favorite.image)
            cell.setup(model: params, stack: true)
            cell.didTapFavorite = { [weak self] in
                self?.presenter.didTapFavorite(model: favorite)
            }
            return cell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter.didSelectItem()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch cells[indexPath.row] {
        case .products(_
        ):
            return CGSize(width: collectionView.frame.width, height: 170)
        }
    }
}
