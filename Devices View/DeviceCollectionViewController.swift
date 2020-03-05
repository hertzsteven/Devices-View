//
//  DeviceCollectionViewController.swift
//  Devices View
//
//  Created by Steven Hertz on 3/4/20.
//  Copyright © 2020 DevelopItSolutions. All rights reserved.
//

import UIKit
import CloudKit

private let reuseIdentifier = "Cell"

class DeviceCollectionViewController: UICollectionViewController {

    var dbs = CKContainer(identifier: "iCloud.com.dia.cloudKitExample.open").publicCloudDatabase
    
    var devices =  Array<Device>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Create NSPredicate
        let predicate = NSPredicate(format: "teacherGroup = %@", "29")
        
        //      let query = CKQuery(recordType: "iPad", predicate: NSPredicate(format: "TRUEPREDICATE"))
        let query = CKQuery(recordType: "iPad", predicate: predicate)
        
        dbs.perform(query, inZoneWith: nil) { (records, error) in
            guard let records = records, error == nil else { fatalError("iPads Not found") }
            
            for iPadRecord in records {
                print(iPadRecord["name"] as Any)
                self.devices.append(Device(name: iPadRecord["name"]! ))
                self.devices.append(Device(name: iPadRecord["name"]! ))
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
       // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return devices.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("In cell")
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? DeviceCollectionViewCell else {fatalError("Could not cast it")}
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DeviceCollectionViewCell
        //cell.setup(device: devices[indexPath.row])
    
    
        // Configure the cell
    
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
