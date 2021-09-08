//
//  CardsViewController.swift
//  FlashcardsUITests
//
//  Created by Julie Connors on 9/8/21.
//

import UIKit

class CardsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
    }
    
//    func configureCollection() {
//            collectionView.dataSource = self
//            collectionView.delegate = self
//            collectionView.register(UINib(nibName: MyCell.identifier, bundle: nil), forCellWithReuseIdentifier: MyCell.identifier)
//        }
}
extension CardsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //viewModel.numItems
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        ///create custom cell
        let cell = UICollectionViewCell()
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCell.identifier, for: indexPath) as? MyCell else {
//            fatalError()
//        }
        
        cell.backgroundColor = .red
//        cell.topLabel.text = viewModel.getCellData(at: indexPath.row)
        return cell
    }
    
}

extension CardsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.row % 4 {
        case 0:
            return CGSize(width: 310, height: 50)
        default:
            return CGSize(width: 90, height: 100)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
}
