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
            let totalInventoryItems = self.arrayOfARItems.count
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
                    itemToAddToRowIndex >= totalItemsInRow ?
                        stackToAdd.addArrangedSubview(createInventoryItemView(itemImage: UIImage.add)):
                        stackToAdd.addArrangedSubview(createInventoryItemView(itemImage: UIImage.checkmark))
                }//for loop
                
                if rowStackViewIndex == 0{
                    stackToAdd.topAnchor.constraint(equalTo: inventoryScrollView.topAnchor, constant: 20).isActive = true
                }else{
                    stackToAdd.topAnchor.constraint(equalTo: tempStackView.bottomAnchor, constant: 20).isActive = true
                }
                stackToAdd.widthAnchor.constraint(equalTo: inventoryScrollView.widthAnchor).isActive = true
                stackToAdd.heightAnchor.constraint(equalToConstant: view.frame.height/10).isActive = true
                tempStackView = stackToAdd
            }//for loop
        }//didset
    }//arrayOfARItems

    let inventoryScrollView = UIScrollView() // viewf
    func createInventoryItemView(itemImage: UIImage) -> UIView{
        let view: UIImageView = {
            let view = UIImageView(image: itemImage)
            view.widthAnchor.constraint(equalToConstant: self.view.frame.width/4).isActive = true
            view.backgroundColor = .yellow
            return view
        }()
        return view
    }//createInventoryItemView
    
    func createInventoryStackView()-> UIStackView {
        let inventoryStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.backgroundColor = .blue
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.spacing = 0
            return stackView
        }()
        return inventoryStackView
    }//createInventoryStackView


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.backgroundColor = .white
        view.addSubview(inventoryScrollView)
        
        inventoryScrollView.contentSize = CGSize(width: view.frame.width, height: 2000)
        inventoryScrollView.backgroundColor = .green
        inventoryScrollView.translatesAutoresizingMaskIntoConstraints = false
        inventoryScrollView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        inventoryScrollView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        inventoryScrollView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        inventoryScrollView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
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


                    arObjArray.append(arObjectToAdd)
                   // print(userToAdd)
                    //print("\(document.documentID) => \(document.data())")
                }//end of for
                self.arrayOfARItems = arObjArray
                //self.arrayOfLeaderboardUsers = tempLeaderboardArray
            }//end of else
        }//end of db.collection closure
    }
}
   
     
  



