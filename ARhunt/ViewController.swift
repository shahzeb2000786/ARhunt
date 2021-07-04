//
//  ViewController.swift
//  ARhunt
//
//  Created by Shahzeb Ahmed on 4/7/21.
//
import UIKit
import RealityKit
import FirebaseFirestore
import CoreLocation
class ViewController: UIViewController {
    
    //@IBOutlet var arView: ARView!
    var arView: ARView!
    var locationManager: CLLocationManager?
    override func viewDidLoad() {

        super.viewDidLoad()
        let goldCoin = try! Experience.loadGoldCoin()
        let silverCoin = try! Experience.loadSilverCoin()
        let bronzeCoin = try! Experience.loadScene()

        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestAlwaysAuthorization()
      //  let db = Firestore.firestore()
        arView = ARView()
        self.view.addSubview(arView)
        arView.translatesAutoresizingMaskIntoConstraints = false
        arView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        arView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        arView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        arView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true

    }//viewDidLoad

}


extension ViewController: CLLocationManagerDelegate {
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
        if(Float(location.coordinate.latitude) > 39.7550 && Float(location.coordinate.latitude) < 39.7675 && Float(location.coordinate.longitude) < -77.5400 && Float(location.coordinate.longitude) > -77.5543 ){
            let bronzeCoin = try! Experience.loadScene()
            arView.scene.anchors.append(bronzeCoin)
             bronzeCoin.children[0].transform = Transform(pitch: 0,
                                                         yaw: 0,
                                                        roll: .pi/2)
            bronzeCoin.children[0].position.y += 1
            

         let timer = Timer.scheduledTimer(withTimeInterval: 0.015, repeats: true, block: { timer in
            let curOrientationAngle = bronzeCoin.bronzeCoin?.orientation.angle
             
            bronzeCoin.bronzeCoin?.orientation = simd_quatf(angle: (curOrientationAngle! + .pi/100).truncatingRemainder(dividingBy: (2 * 3.14159265)),     /* 45 Degrees */
                                                           axis: [1, 0, 0])
            
         })
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
