//
//  CardsViewController.swift
//  FlashcardsUITests
//
//  Created by Julie Connors on 9/8/21.
//

import UIKit

class CardsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cards = ["generics", "protocols", "structs"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollection()
    }
    
    func configureCollection() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: CardCell.identifier, bundle: nil), forCellWithReuseIdentifier: CardCell.identifier)
    }
}

extension CardsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //viewModel.numItems
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        ///create custom cell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.identifier, for: indexPath) as? CardCell else {
            fatalError()
        }
                
        return cell
    }
}

extension CardsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 90, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
}
