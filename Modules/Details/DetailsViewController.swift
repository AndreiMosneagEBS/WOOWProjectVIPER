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
    func setup(model: ProductDetails)
    
}

protocol DetailsViewOutput {
    
    func viewIsReady()
    func didTapOnImage(model: String?)
    
}

final class DetailsViewController: BaseVC, StoryboardInstantiable {
    
    static var storyboardName: String = "Details"
    
    var image: [String] = ["https://img.joomcdn.net/077bbe2ce1543f1cbd0a7201dec19a54d0e58233_original.jpeg", "https://img.joomcdn.net/077bbe2ce1543f1cbd0a7201dec19a54d0e58233_original.jpeg", "https://img.joomcdn.net/077bbe2ce1543f1cbd0a7201dec19a54d0e58233_original.jpeg"]
    
    var productDetails: ProductDetails?
    var currentPage: Int = 0
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var sizeProduct: UILabel!
    @IBOutlet weak var priceProduct: UILabel!
    @IBOutlet weak var saleProduct: UILabel!
    @IBOutlet weak var detailProduct: UILabel!
    
    
    
    
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
        
    }
    
    private func configureCollectionView() {
        collectionView.register(ImageProductCVC.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

// MARK: - DetailsViewInput

extension DetailsViewController: DetailsViewInput {
    func setup(model: ProductDetails) {
        self.productDetails = model
        if let product = productDetails?.mainImage {
            image.append(product)
        }
        nameProduct.text = productDetails?.name
        sizeProduct.text = productDetails?.size
        if let price = productDetails?.price {
            priceProduct.text = String(price)
            saleProduct.text = String(price)
        }
        detailProduct.text = productDetails?.details
        collectionView.reloadData()
        pageControl.numberOfPages = image.count
    }
    
    
    
	func setupInitialState() {

    }
    
  
}


extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return image.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView[ImageProductCVC.self,indexPath]
        if let product = productDetails {
            cell.setup(model: product, page: currentPage)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(collectionView.bounds.width)
        return CGSize(width: collectionView.bounds.width , height: 288)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let image = productDetails?.mainImage{
            self.presenter.didTapOnImage(model: image)}
    }
}

extension DetailsViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let witdh = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / witdh
        let roundedIndex = round(index)
        self.pageControl?.currentPage = Int(roundedIndex)
        
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.collectionView.scrollToNearestVisibleCollectionViewCell()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.collectionView.scrollToNearestVisibleCollectionViewCell()
        }
    }
}


