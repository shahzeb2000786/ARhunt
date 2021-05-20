//
//  Leaderboard.swift
//  ARhunt
//
//  Created by Shahzeb Ahmed on 4/27/21.
//

import Foundation
import UIKit
import Firebase
class Leaderboard: UIViewController {
   

   // let db = Firestore.firestore()
    let leaderBoardTable = UITableView()
    
    var arrayOfLeaderboardUsers: [User] = []{
        willSet{
        }didSet{
            self.leaderBoardTable.reloadData()
        }
    }
    override func viewDidLoad() {

        super.viewDidLoad()
        
      
        leaderBoardTable.dataSource = self
        leaderBoardTable.delegate = self
        leaderBoardTable.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(leaderBoardTable)
        NSLayoutConstraint.activate([
            leaderBoardTable.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            leaderBoardTable.heightAnchor.constraint(equalToConstant: self.view.frame.height),
            leaderBoardTable.topAnchor.constraint(equalTo: self.view.topAnchor),
            leaderBoardTable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        setTableViewData()
    
    }//viewDidLoad

}

extension Leaderboard: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfLeaderboardUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = arrayOfLeaderboardUsers[indexPath.row].email + "    " + arrayOfLeaderboardUsers[indexPath.row].points
        return cell
    }
    
    func setTableViewData(){
        let db = Firestore.firestore()
        db.collection("Users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var tempLeaderboardArray: [User] = []
                for document in querySnapshot!.documents {
                    let userData = document.data()
                    
                    let firstName = (userData["firstName"]) as? String ?? "-"
                    let lastName = (userData["lastName"]) as? String ?? "-"
                    let id = (userData["id"]) as? String ?? "-"
                    let email = (userData["email"]) as? String ?? "-"
                    let points = (userData["points"]) as? String ?? "-"
                
                    let userToAdd = User(email: email, firstName: firstName, id: id, lastName: lastName, points: points)
                    tempLeaderboardArray.append(userToAdd)
                    print(userToAdd)
                    //print("\(document.documentID) => \(document.data())")
                }//end of for
                self.arrayOfLeaderboardUsers = tempLeaderboardArray
            }//end of else
        }//end of db.collection closure
    }//end of function
}

extension Leaderboard: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let inventoryViewController = storyBoard.instantiateViewController(identifier: "inventoryViewController") as! InventoryViewController
        self.present(inventoryViewController, animated: true, completion: nil)
    }
}






