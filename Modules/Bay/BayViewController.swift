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
}

protocol BayViewOutput {
    func viewIsReady()
}

final class BayViewController: BaseVC, StoryboardInstantiable {
	static var storyboardName: String = "Bay"
	
    var presenter: BayViewOutput!
    var moduleInput: BayModuleInput!

    private var cells: [BayCellType] = []
    
    // MARK: - Outlets
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var viewLabel: UIView!


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
			BayCVC.self
		)
		
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setButton() {
        viewLabel.cornerRadius = viewLabel.frame.width / 2
    }
}

// MARK: - BayViewInput

extension BayViewController: BayViewInput {
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
        case .poductBay:
            let cell = collectionView[BayCVC.self, indexPath]
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension BayViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch cells[indexPath.row] {
        case .poductBay:
            return CGSize(width: collectionView.frame.width, height: 170)
        }
    }
}
