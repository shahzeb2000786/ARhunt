//
//  Leaderboard.swift
//  ARhunt
//
//  Created by Shahzeb Ahmed on 4/27/21.
//

import Foundation
import UIKit
import FirebaseFirestore
import CoreLocation
class Leaderboard: UIViewController{
   

   // let db = Firestore.firestore()
    let leaderBoardTable = UITableView()
    var locationManager: CLLocationManager?
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
        
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.requestWhenInUseAuthorization()
            locationManager?.requestAlwaysAuthorization()
        
        
        leaderBoardTable.translatesAutoresizingMaskIntoConstraints = false
        leaderBoardTable.backgroundColor = UIColor(named: "inventory-background-color") ?? .white
        
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
        cell.textLabel?.textColor = .black
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
                }//end of for
                self.arrayOfLeaderboardUsers = tempLeaderboardArray
            }//end of else
        }//end of db.collection closure
    }//end of function
}

extension Leaderboard: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let inventoryViewController = ViewController()
        self.navigationController?.pushViewController(inventoryViewController, animated: true)
    }
}


extension Leaderboard: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
    case .denied: // Setting option: Never
      print("LocationManager didChangeAuthorization denied")
    case .notDetermined: // Setting option: Ask Next Time
      print("LocationManager didChangeAuthorization notDetermined")
    case .authorizedWhenInUse: // Setting option: While Using the App
      print("LocationManager didChangeAuthorization authorizedWhenInUse")
      locationManager?.requestLocation()
    case .authorizedAlways: // Setting option: Always
      print("LocationManager didChangeAuthorization authorizedAlways")
      locationManager?.requestLocation()
    case .restricted: // Restricted by parental control
      print("LocationManager didChangeAuthorization restricted")
    default:
      print("LocationManager didChangeAuthorization")
    }
  }

  // Step 7: Handle the location information
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    print("LocationManager didUpdateLocations: numberOfLocation: \(locations.count)")
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    locations.forEach { (location) in
        if(Float(location.coordinate.latitude) > 39.8540 && Float(location.coordinate.latitude) < 39.8550 && Float(location.coordinate.longitude) < -77.2310 && Float(location.coordinate.longitude) > -77.2320 ){
            print("You are on top of an AR object")
        }
        
      print("LocationManager didUpdateLocations: \(dateFormatter.string(from: location.timestamp)); \(location.coordinate.latitude), \(location.coordinate.longitude)")
      print("LocationManager altitude: \(location.altitude)")
      print("LocationManager floor?.level: \(location.floor?.level)")
      print("LocationManager horizontalAccuracy: \(location.horizontalAccuracy)")
      print("LocationManager verticalAccuracy: \(location.verticalAccuracy)")
      print("LocationManager speedAccuracy: \(location.speedAccuracy)")
      print("LocationManager speed: \(location.speed)")
      print("LocationManager timestamp: \(location.timestamp)")
      print("LocationManager courseAccuracy: \(location.courseAccuracy)") // 13.4
      print("LocationManager course: \(location.course)")
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("LocationManager didFailWithError \(error.localizedDescription)")
    if let error = error as? CLError, error.code == .denied {
       // Location updates are not authorized.
      // To prevent forever looping of `didFailWithError` callback
       locationManager?.stopMonitoringSignificantLocationChanges()
       return
    }
  }
}





