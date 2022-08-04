//
//  ImageViewController.swift
//  WOOWProjectVIPER
//
//  Created by Mosneag Gheorghe on 02/08/2022.
//  Copyright © 2022 Andrei. All rights reserved.
//

import UIKit
import EBSSwiftUtils

protocol ImageViewInput: AnyObject {
	func setupInitialState()
    func setupImage(model: String)
}

protocol ImageViewOutput {
    func viewIsReady()
}

final class ImageViewController: BaseVC, StoryboardInstantiable {
	static var storyboardName: String = "Image"
	
    var presenter: ImageViewOutput!
    var moduleInput: ImageModuleInput!
    private var image = ["https://img.joomcdn.net/077bbe2ce1543f1cbd0a7201dec19a54d0e58233_original.jpeg", "https://img.joomcdn.net/077bbe2ce1543f1cbd0a7201dec19a54d0e58233_original.jpeg", "https://img.joomcdn.net/077bbe2ce1543f1cbd0a7201dec19a54d0e58233_original.jpeg"]
    var productImage: String?
    var currentPage: Int = 0

    
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControll: UIPageControl!
    
    
    

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        if presenter == nil {
        	ImageViewController.configureVIPERModule(for: self)
		}
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if presenter == nil {
			ImageViewController.configureVIPERModule(for: self)
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewIsReady()
        configureCollectionView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func configureCollectionView() {
        collectionView.register(ImageCVC.self)
        collectionView.delegate = self
        collectionView.dataSource = self
//        self.collectionView.scrollToItem(at: self.IndexPath, at: .centeredHorizontally, animated: true)
//        collectionView.contentSize = CGSize(width: 200, height: 280)
    }
    
}

// MARK: - ImageViewInput

extension ImageViewController: ImageViewInput {
    func setupImage(model: String) {
        self.productImage = model
        
    }
    
	func setupInitialState() {

    }
}
extension ImageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return image.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView[ImageCVC.self,indexPath]
        if let image = productImage {
            cell.setup(model: image )

        }
       
        return cell
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}

extension ImageViewController: UIScrollViewDelegate {
    
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

