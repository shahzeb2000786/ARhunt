//
//  InventoryViewController.swift
//  ARhunt
//
//  Created by Shahzeb Ahmed on 5/20/21.
//

import Foundation
import UIKit

class InventoryViewController: UIViewController{
    let testArray = [3,4,3,4,3,2,4,5,4,3,5,6,7,8,9]

    override func viewDidLoad(){
        super.viewDidLoad()
       // self.view.backgroundColor = .yellow
        let totalItems = testArray.count
        let totalRows = ceil(Float(totalItems)/4)
        let itemCountInLastRow = totalItems % 4
        


       // let inventoryScrollView = UIScrollView()

       // self.view.addSubview(inventoryScrollView)
        let fullStackView = UIStackView()
        self.view.addSubview(fullStackView)
        //inventoryScrollView
//        inventoryScrollView.backgroundColor = .green
//        inventoryScrollView.showsHorizontalScrollIndicator = false
//        inventoryScrollView.translatesAutoresizingMaskIntoConstraints = false
//        inventoryScrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height * 2);
//        inventoryScrollView.layer.borderWidth = 5.0
//        inventoryScrollView.layer.borderColor = UIColor.red.cgColor
//        NSLayoutConstraint.activate([
//            inventoryScrollView.heightAnchor.constraint(equalToConstant: self.view.frame.height),
//            inventoryScrollView.widthAnchor.constraint(equalToConstant: self.view.frame.width),
////            inventoryScrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
////            inventoryScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
//        ])
//

        self.view.addSubview(fullStackView)
        //fullStackView
        fullStackView.translatesAutoresizingMaskIntoConstraints = false
        fullStackView.axis = .vertical
        fullStackView.distribution = .fillEqually
        fullStackView.spacing = 10.0
        fullStackView.backgroundColor = .orange
        fullStackView.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        let navBar = self.navigationController!.navigationBar
        
        NSLayoutConstraint.activate([
            fullStackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: navBar.frame.height),
            fullStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            fullStackView.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            fullStackView.heightAnchor.constraint(equalToConstant: self.view.frame.height)

        ])
        for i in 0...Int(totalRows){
            let inventoryRowStackView = UIStackView()
            inventoryRowStackView.translatesAutoresizingMaskIntoConstraints = false
            inventoryRowStackView.axis = .horizontal
            inventoryRowStackView.distribution = .fillEqually
            inventoryRowStackView.spacing = 5
            inventoryRowStackView.backgroundColor = .yellow
            
//            if i == (Int(totalRows) - 1){//executes when the last row does not have four items in it.
//                let numOfItemsInRow = totalItems - 4 * i
//            }//if
//            else{
            
                for _ in 0...4{
                    let inventoryViewToAdd = UIView()
                    inventoryViewToAdd.translatesAutoresizingMaskIntoConstraints = false
                    inventoryViewToAdd.backgroundColor = .green
                    inventoryRowStackView.addArrangedSubview(inventoryViewToAdd)
                }
            //}else
            fullStackView.addArrangedSubview(inventoryRowStackView)
            
            
        }//for
    }
    
}


