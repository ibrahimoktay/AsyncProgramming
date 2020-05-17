//
//  ViewController.swift
//  AsyncProgramming
//
//  Created by ibrahim oktay on 10.05.2020.
//  Copyright © 2020 io. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var viewModel: ViewModel!
    var imageUrls = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Finder"
        
        initCollectionView()
        initSearchController()
        
        viewModel = ViewModel(services: [UnsplashAPI(), PexelsAPI()])
    }
    
    private func initCollectionView() {
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.size.width - 15) / 3
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        collectionView.collectionViewLayout = layout
    }
    
    private func initSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        self.navigationItem.searchController = searchController
    }
}

extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.search(searchController.searchBar.text ?? "") { urls in
            self.imageUrls = urls
            self.collectionView.reloadData()
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageViewCell
        cell.imageView.contentMode = .scaleAspectFill
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: URL(string: self.imageUrls[indexPath.row])!)
            DispatchQueue.main.async {
                cell.imageView.image = UIImage(data: data!)
            }
        }
        return cell
    }
}
