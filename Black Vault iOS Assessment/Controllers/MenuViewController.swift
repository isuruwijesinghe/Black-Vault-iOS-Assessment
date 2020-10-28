//
//  MenuViewController.swift
//  Black Vault iOS Assessment
//
//  Created by Isuru Wijesinghe on 10/26/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var menuArray: Array<Menu> = Array()

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.register(UINib(nibName: "MenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MenuCollectionViewCell")
        

        collectionView.register(UINib(nibName: "MenuHeaderCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MenuHeaderCell")
        
        let menuItems = Menu(title: "Your Deets", names: ["Update Profile","Change passcode","Notifications"], image: ["faceIcon", "passcodeIcon", "notifiactionIcon"])
        let menuItems1 = Menu(title: "privacy", names: ["Privacy Policy","Terms & Coditions", "Request you data"], image: ["lockIcon", "privacyIcon", "dataIcon"])
        let menuItems2 = Menu(title: "Support", names: ["FAQs"], image: ["faqIcon"])
//        menuArray.append(menuItems)
//        menuArray.append(menuItems1)
//        menuArray.append(menuItems2)
        menuArray.append(contentsOf: [menuItems, menuItems1, menuItems2])
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return menuArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuArray[section].names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MenuHeaderCell", for: indexPath) as? MenuHeaderCollectionReusableView{
            sectionHeader.headerLabel.text = menuArray[indexPath.section].title
            return sectionHeader
        }
        return UICollectionReusableView()
        
//        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MenuHeaderCell", for: indexPath) as! MenuHeaderCollectionReusableView
//
//        return sectionHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionViewCell", for: indexPath) as! MenuCollectionViewCell
        cell.iconImageView.image = UIImage(named: menuArray[indexPath.section].image[indexPath.row])
        cell.menuLabel.text = menuArray[indexPath.section].names[indexPath.row]
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
