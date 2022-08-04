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
    func didUpdateTableStructure(cells: [ProductsCellType], countOfProductsPerPage: Bool)
}

protocol ProductsViewOutput {
    func viewIsReady()
    func didTapOnCell(model: About)
    func pagination(page: Int)
    func didTapButtonProfile()
}

final class ProductsViewController: BaseVC, StoryboardInstantiable {
	static var storyboardName: String = "Products"
	
    var presenter: ProductsViewOutput!
    var moduleInput: ProductsModuleInput!

    private var cells: [ProductsCellType] = []
    private var productsDysplayType: ButtonType = .list
    private var page: Int = 1
    private var countProductPerPage: Bool?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var countSale: UILabel!
    @IBOutlet weak var myCartButton: UIButton!
    @IBOutlet weak var imageSale: UIImageView!
    @IBOutlet weak var uiViewCount: UIView!
    @IBOutlet weak var uiViewBack: UIView!
    @IBOutlet weak var gridButton: UIButton!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    
    enum ButtonType {
        case grid
        case list
    }
    
    
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
        configureButton()
        self.presenter.pagination(page: page)
        
        
    }

    // MARK: - Configure
    
    private func configureTableView() {
        tableView.register(ProductTVC.self, GridTVC.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func createSpinnerFooter()-> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    

// MARK: - Configure Button
private func configureButton() {
    uiViewCount.cornerRadius = uiViewCount.frame.size.width/2
    uiViewBack.roundCorners([.topRight, .bottomRight], radius: 3)
    imageSale.roundCorners([.topLeft, .bottomLeft], radius: 3)
    gridButton.cornerRadius = 2
    listButton.cornerRadius = 2
    
}
    // MARK: - Action
    @IBAction func profileButtonAction(_ sender: Any) {
        self.presenter.didTapButtonProfile()
        
    }

}
// MARK: - ProductsViewInput

extension ProductsViewController: ProductsViewInput {
    func setupInitialState() {

    }

    func didUpdateTableStructure(cells: [ProductsCellType], countOfProductsPerPage: Bool) {
        self.cells = cells
        self.countProductPerPage = countOfProductsPerPage
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

extension ProductsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height-100-scrollView.frame.size.height) {
            
            guard !Request.shared.isPagination else {
                return
            }
            if countProductPerPage!  {
                self.tableView.tableFooterView = createSpinnerFooter()
            }
            Request.shared.fetchProducts(requestingPorcess: true, page: page) { [self] result  in
                page += 1
                DispatchQueue.main.async {
                    
                    self.tableView.tableFooterView = nil
                }
                self.presenter.pagination(page: page)
            }
        }
    }
}
