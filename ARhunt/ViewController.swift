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
        let boxAnchor = try! Experience.loadBox()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestAlwaysAuthorization()
      //  let db = Firestore.firestore()

     print("hello there dude")
//         Load the "Box" scene from the "Experience" Reality File
//        // Add the box anchor to the scene
        arView = ARView()
        self.view.addSubview(arView)
        arView.translatesAutoresizingMaskIntoConstraints = false
        arView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        arView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        arView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        arView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true

        
       // arView.scene.anchors.append(boxAnchor)
            boxAnchor.children[0].transform = Transform(pitch: 0,
                                                        yaw: 0,
                                                       roll: .pi/4)
        print("---------------------------------------------------")
        print(boxAnchor.children[0])
        print("---------------------------------------------------")

        let timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { timer in
            let curOrientationAngle = boxAnchor.coin?.orientation.angle
            

            boxAnchor.coin?.orientation = simd_quatf(angle: (curOrientationAngle! + .pi/100).truncatingRemainder(dividingBy: (2 * 3.14159265)),     /* 45 Degrees */
                                                          axis: [1, 0, 0])
            //print(boxAnchor.coin?.orientation.vector);
        })
      
       // timer.fire()



    }//viewDidLoad
    
    
   

    
    //        let anchor = AnchorEntity(plane: .horizontal, classification: .floor, minimumBounds: [0.2,0.2])
    //        var cards: [Entity] = []
    //
    //        for _ in 1...4{
    //            let box = MeshResource.generateBox(width: 0.25, height: 2.5, depth: 0.25)
    //            let metalMaterial = SimpleMaterial(color: .cyan, isMetallic: true)
    //            let model = ModelEntity(mesh: box, materials: [metalMaterial])
    //            cards.append(model)
    //        }//for
    //        for (index, card) in cards.enumerated(){
    //            let x = Float(index % 2)
    //            let z = Float(index / 2)
    //
    //            card.position = [x*1, 0, z*1]
    //            anchor.addChild(card)
    //        }
    //        arView.scene.addAnchor(anchor)
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
        if(Float(location.coordinate.latitude) > 39.7610 && Float(location.coordinate.latitude) < 39.7620 && Float(location.coordinate.longitude) < -77.5482 && Float(location.coordinate.longitude) > -77.5493 ){
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
