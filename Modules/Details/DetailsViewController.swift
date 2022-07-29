//
//  DetailsViewController.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 29/07/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import UIKit
import EBSSwiftUtils

protocol DetailsViewInput: AnyObject {
	func setupInitialState()
    func setup(model: About)
    
}

protocol DetailsViewOutput {
    func viewIsReady()
}

final class DetailsViewController: BaseVC, StoryboardInstantiable {
    @IBOutlet weak var collectionView: UICollectionView!
    
    static var storyboardName: String = "Details"
    @IBOutlet weak var pageControl: UIPageControl!
    
    var image: [String] = ["https://img.joomcdn.net/077bbe2ce1543f1cbd0a7201dec19a54d0e58233_original.jpeg","https://img.joomcdn.net/077bbe2ce1543f1cbd0a7201dec19a54d0e58233_original.jpeg"]
    var product: About?
    var currentPage: Int = 0
    
    var presenter: DetailsViewOutput!
    var moduleInput: DetailsModuleInput!

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        if presenter == nil {
        	DetailsViewController.configureVIPERModule(for: self)
		}
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if presenter == nil {
			DetailsViewController.configureVIPERModule(for: self)
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewIsReady()
        configureCollectionView()
        if let product = product?.mainImage {
            image.append(product)
        }
        
    }
    
    
    private func configureCollectionView() {
        collectionView.register(ImageProductCVC.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentSize = CGSize(width: 200, height: 280)
    }
    
}

// MARK: - DetailsViewInput

extension DetailsViewController: DetailsViewInput {
	func setupInitialState() {

    }
    
    func setup(model: About) {
        self.product = model
    }
}


extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return image.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView[ImageProductCVC.self,indexPath]
        if let product = product {
            cell.setup(model: product, page: currentPage)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(collectionView.bounds.width)
        return CGSize(width: collectionView.bounds.width , height: 288)
    }
}

extension DetailsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollCenter = self.view.convert (self.view.center, to: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: scrollCenter) else {
            return
        }
        pageControl.currentPage = indexPath.item
    }
}


