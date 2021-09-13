//
//  CardsViewController.swift
//  FlashcardsUITests
//
//  Created by Julie Connors on 9/8/21.
//

import UIKit
import Firebase

class CardsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
        
    var viewModel: CardCollectionViewModel?
    var remoteConfig: RemoteConfig!
    var carousel: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollection()
        configureViewModel()
        getRemoteConfig()
    }
    
    func configureViewModel() {
        let setCompletion = { [weak self] in
            guard let wself = self else { return }
            wself.setCard()
        }
        
        viewModel?.bind(completion: setCompletion)
    }
    
    func setCard() {
        collectionView.reloadData()
    }
    
    func configureCollection() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: CardCell.identifier, bundle: nil), forCellWithReuseIdentifier: CardCell.identifier)
    }
    
}

extension CardsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.number ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.identifier, for: indexPath) as? CardCell else {
            fatalError()
        }
        
        let card = viewModel?.setCard(at: indexPath.row)
        
        cell.headline.text = card?.headline
                
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let card = viewModel?.setCard(at: indexPath.row) else { return }
        
        let cardSB = UIStoryboard(name: "Cards", bundle: nil)
        guard let popupVC = cardSB.instantiateViewController(identifier: "CardBackVC") as? CardBackViewController else { return }
        popupVC.collectionViewModel = viewModel
        popupVC.cardViewModel = CardViewModel(card: card)
        popupVC.modalPresentationStyle = .popover

        present(popupVC, animated: true, completion: nil)
    }
}

extension CardsViewController: UICollectionViewDelegateFlowLayout {
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            if carousel {
                return CGSize(width: 300, height: 400)
            }
            return CGSize(width: 100, height: 100)
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        20
        }
    
    func configureCarouselView(with data: [Card]) {
        let carouselLayout = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection = .horizontal
        carouselLayout.itemSize = .init(width: 350, height: 500)
        collectionView.collectionViewLayout = carouselLayout
        
        collectionView.reloadData()
    }
    
    func getRemoteConfig() {
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        let defaults: [String: NSObject] = ["carousel": false as NSObject]

        remoteConfig.setDefaults(defaults)

        remoteConfig.fetch { (status, error) -> Void in
            if status == .success {
                self.remoteConfig.activate { changed, error in
                    let value = self.remoteConfig.configValue(forKey: "carousel").boolValue
                    if value {
                        self.carousel = true
                        DispatchQueue.main.async {
                            self.configureCarouselView(with: self.viewModel?.cardVM ?? [])
                        }
                    }
                }
            } else {
                print("Config not fetched")
            }
        }
    }
}

