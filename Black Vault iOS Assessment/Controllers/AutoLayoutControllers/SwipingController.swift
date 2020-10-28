//
//  SwipingController.swift
//  Black Vault iOS Assessment
//
//  Created by Isuru Wijesinghe on 10/28/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import UIKit

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout()
            
            if self.pageControle.currentPage == 0 {
                self.collectionView.contentOffset = .zero
            }else {
                let indexPath = IndexPath(item: self.pageControle.currentPage, section: 0)
                self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
            
        }) { (_) in
            
        }
//        collectionViewLayout.invalidateLayout()
    }
    
    let pages = [
        Page(imageName: "bearImage", titleText: "Hi this is an autoLayout app !"),
        Page(imageName: "lion", titleText: "Hi this is an autoLayout the 2 !"),
        Page(imageName: "dog", titleText: "Hi this is an autoLayout the 3 !"),
        Page(imageName: "panda", titleText: "Hi this is an autoLayout the 4!")
    ]
    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV.", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
        return button
    }()
    
    @objc private func handlePrevious(){
        
        let nextIndex = max(pageControle.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControle.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
    }
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.mainPink, for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleNext(){
        
        let nextIndex = min(pageControle.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControle.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    
    private lazy var pageControle: UIPageControl = {
        let page = UIPageControl()
        page.currentPage = 0
        page.numberOfPages = pages.count
        page.currentPageIndicatorTintColor = .mainPink
        page.pageIndicatorTintColor = .lowPink
        return page
    }()
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        
        pageControle.currentPage = Int(x / view.frame.width)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtonControlls()
        
        collectionView.backgroundColor = .white
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: "CellId")
        
        collectionView.isPagingEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath) as! PageCell
        
//        cell.backgroundColor = indexPath.item % 2 == 0 ? .red :  .green
        let page = pages[indexPath.row]
        cell.page = page
//        cell.bearImageView.image = UIImage(named: pages[indexPath.row].imageName)
//        cell.titleTextView.text = pages[indexPath.row].titleText
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    fileprivate func setButtonControlls(){

        let bottomStackView = UIStackView(arrangedSubviews: [previousButton, pageControle, nextButton])
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomStackView.distribution = .fillEqually
        
        view.addSubview(bottomStackView)
        
        
        NSLayoutConstraint.activate([
            bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomStackView.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
}
