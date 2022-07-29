//
//  ProductsViewController.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 28/07/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import UIKit
import EBSSwiftUtils

protocol ProductsViewInput: AnyObject {
	func setupInitialState()
    func didUpdateTableStructure(cells: [ProductsCellType])
}

protocol ProductsViewOutput {
    func viewIsReady()
    func didTapOnCell(model: About)
}

final class ProductsViewController: BaseVC, StoryboardInstantiable {
	static var storyboardName: String = "Products"
	
    var presenter: ProductsViewOutput!
    var moduleInput: ProductsModuleInput!

    private var cells: [ProductsCellType] = []
    
    // MARK: - Outlets
    
    @IBOutlet private weak var tableView: UITableView!

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        if presenter == nil {
        	ProductsViewController.configureVIPERModule(for: self)
		}
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if presenter == nil {
        	ProductsViewController.configureVIPERModule(for: self)
		}
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        presenter.viewIsReady()
        
        
    }

    // MARK: - Configure
    
    private func configureTableView() {
        tableView.register(ProductTVC.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - ProductsViewInput

extension ProductsViewController: ProductsViewInput {
	func setupInitialState() {

    }

    func didUpdateTableStructure(cells: [ProductsCellType]) {
        self.cells = cells
        self.tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension ProductsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
}

// MARK: - UITableViewDelegate

extension ProductsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 215
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cells[indexPath.row] {
        case .products(let product):
            let cell = tableView[ProductTVC.self, indexPath]
            cell.setup(model: product )
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .products(product: let product):
            self.presenter.didTapOnCell(model: product)
        }
    }
    
}
