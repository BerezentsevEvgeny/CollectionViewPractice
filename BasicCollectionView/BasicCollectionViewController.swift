//
//  BasicCollectionViewController.swift
//  BasicCollectionView
//
//  Created by Евгений Березенцев on 28.04.2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class BasicCollectionViewController: UICollectionViewController, UISearchResultsUpdating {
     
    let searchController = UISearchController()
    
    lazy var filteredItems: [String] = self.items

    private let items = [
        "Alabama", "Alaska", "Arizona", "Arkansas", "California",
        "Colorado", "Connecticut", "Delaware", "Florida",
        "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa",
        "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland",
        "Massachusetts", "Michigan", "Minnesota", "Mississippi",
        "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire",
        "New Jersey", "New Mexico", "New York", "North Carolina",
        "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania",
        "Rhode Island", "South Carolina", "South Dakota", "Tennessee",
        "Texas", "Utah", "Vermont", "Virginia", "Washington",
        "West Virginia", "Wisconsin", "Wyoming"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Задаем параметры контроллера
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        
        collectionView.setCollectionViewLayout(generateLayout(), animated: false)
    }
    
    // Логика фильтрации элементов
    func updateSearchResults(for searchController: UISearchController) {
        if let searchString = searchController.searchBar.text, searchString.isEmpty == false {
            filteredItems = items.filter { (item) -> Bool in
                item.localizedCaseInsensitiveContains(searchString)
            }
        } else {
            filteredItems = items
        }

            collectionView.reloadData()

    }
    

    
    //MARK: - Конфигурируем Layout
    private func generateLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 10
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0, leading: spacing, bottom: 0, trailing: spacing)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(70.0))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item, count: 2)
        group.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: 0, trailing: spacing)
 
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    

    // MARK: - DataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return filteredItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BasicCollectionViewCell

        cell.label.text = filteredItems[indexPath.item]

        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
