//
//  FavoritesPresenter.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 11/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import Foundation

protocol FavoritesModuleInput: AnyObject {
    func setup(model: [FavoriteModel])
    
}

final class FavoritesPresenter {
    weak var view: FavoritesViewInput!
	
    var interactor: FavoritesInteractorInput!
    var router: FavoritesRouterInput!
    
    private var model: [FavoriteModel] = []
    
	private var baseVC: BaseVC {
        guard let baseVC = view as? BaseVC else {
            fatalError("ViewController was not inherited from BaseVC")
        }
        return baseVC
    }
    
    private func generateCell() {
        var cell:[FavoritesCellType] = []
        model.forEach { model in
            cell.append(contentsOf: [.products(model: model)])
        }
        view.didUpdateCollectionStructure(cells: cell)
        
    }
    
    
}

// MARK: - FavoritesModuleInput

extension FavoritesPresenter: FavoritesModuleInput {
    func setup(model: [FavoriteModel]) {
        self.model = model
        
    }
    

}

// MARK: - FavoritesViewOutput

extension FavoritesPresenter: FavoritesViewOutput {
    func didSelectItem() {
        self.router.didSelectCell()
    }
    
    
    func didTapFavorite(model: FavoriteModel) {
        try? FavoriteManager.shared.delete(id: model.id)
        self.model = FavoriteManager.shared.getFavorites()
        generateCell()
    
    }
    
	func viewIsReady() {
		view.setupInitialState()
        generateCell()
    }
}

// MARK: - FavoritesInteractorOutput

extension FavoritesPresenter: FavoritesInteractorOutput {

}
