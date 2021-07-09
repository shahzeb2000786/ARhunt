//
//  InventoryViewController.swift
//  ARhunt
//
//  Created by Shahzeb Ahmed on 5/20/21.
//

import Foundation
import UIKit
import FirebaseFirestore
class InventoryViewController: UIViewController{
    var arrayOfARItems: [ARItem] = []{
        willSet{
        }didSet{
            var tempStackView = UIStackView()
            let totalInventoryItems = 65
            let totalInventoryRows = Int(ceil(Float(totalInventoryItems)/4))
            let itemCountInLastRow = totalInventoryItems % 4
            for rowStackViewIndex in (0...totalInventoryRows - 1){
                let stackToAdd = createInventoryStackView()
                inventoryScrollView.addSubview(stackToAdd)
                var totalItemsInRow = 4
                if rowStackViewIndex == totalInventoryRows - 1{
                    totalItemsInRow = itemCountInLastRow
                }
                
                for itemToAddToRowIndex in (0...3){
                    var itemToAdd = UIView()
                    if (itemToAddToRowIndex >= totalItemsInRow){
                        let itemToAdd = createInventoryItemView(itemImage: UIImage(named:"HubCoin") ?? .checkmark)
                    }else{
                        itemToAdd = createInventoryItemView(itemImage: UIImage(named:"HubCoin") ?? .checkmark )
                    }
                    stackToAdd.addArrangedSubview(itemToAdd)
                }//for loop
                if rowStackViewIndex == 0{
                    stackToAdd.topAnchor.constraint(equalTo: inventoryScrollView.topAnchor, constant: 20).isActive = true
                }else{
                    stackToAdd.topAnchor.constraint(equalTo: tempStackView.bottomAnchor, constant: 20).isActive = true
                }
                stackToAdd.widthAnchor.constraint(equalTo: inventoryScrollView.widthAnchor).isActive = true
                stackToAdd.heightAnchor.constraint(equalToConstant: view.frame.width/4 - view.frame.width/20).isActive = true
                inventoryScrollView.contentSize.height +=  view.frame.width/4 - view.frame.width/20 + 20

                tempStackView = stackToAdd
            }//for loop
        }//didset
    }//arrayOfARItems

    let inventoryScrollView = UIScrollView()
    let inventoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: label.font.fontName, size: 40)
        label.text = "Inventory"
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }()
    func createInventoryItemView(itemImage: UIImage) -> UIView{
        let view: UIImageView = {
            let view = UIImageView(image: itemImage)
            view.layer.cornerRadius = 20
            view.backgroundColor = .lightGray
            view.widthAnchor.constraint(equalToConstant: self.view.frame.width/4).isActive = true
            return view
        }()
        return view
    }//createInventoryItemView
    
    func createInventoryStackView()-> UIStackView {
        let inventoryStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.spacing = view.frame.width/20
            return stackView
        }()
        return inventoryStackView
    }//createInventoryStackView


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(inventoryScrollView)
        inventoryScrollView.contentSize = CGSize(width: view.frame.width, height: 0)
        inventoryScrollView.translatesAutoresizingMaskIntoConstraints = false
        inventoryScrollView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        inventoryScrollView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor,constant: 10).isActive = true
        inventoryScrollView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        inventoryScrollView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        inventoryScrollView.showsHorizontalScrollIndicator = false
        inventoryScrollView.backgroundColor = UIColor(named: "inventory-background-color") ?? .white
        setARInventoryItems()
       
        

    }//viewDidLoad
    
    func setARInventoryItems(){
        let db = Firestore.firestore()
        db.collection("ARObjects").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var arObjArray: [ARItem] = []
                for document in querySnapshot!.documents {
                    let arObject = document.data()
                    
                    let findCount = (arObject["FindCount"]) as? String ?? "-"
                    let location = (arObject["Location"]) as? String ?? "-"
                    let points = (arObject["Points"]) as? String ?? "-"
                    let rarity = (arObject["Rarity"]) as? String ?? "-"
                    let arObjectToAdd = ARItem(FindCount: findCount, Location: location, Points: points, Rarity: rarity)
                    arObjArray.insert(arObjectToAdd, at: 0)
                   // print(userToAdd)
                    //print("\(document.documentID) => \(document.data())")
                }//end of for
                self.arrayOfARItems = arObjArray
                //self.arrayOfLeaderboardUsers = tempLeaderboardArray
            }//end of else
        }//end of db.collection closure
    }
}
   
     
  






