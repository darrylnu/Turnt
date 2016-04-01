//
//  FeedViewController.swift
//  Turnt
//
//  Created by Darryl Nunn on 3/31/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    var images = [PFFile]()
    var userImages = [PFFile]()
    var usernames = [String]()
    var attending = [String]()
    
    @IBAction func imGoingButton(sender: AnyObject) {
        //add code for this to update attending
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let query = PFQuery(className: "Events")
        
        query.findObjectsInBackgroundWithBlock { (object, error) -> Void in
            
            self.usernames.removeAll(keepCapacity: true)
            self.images.removeAll(keepCapacity: true)
            self.userImages.removeAll(keepCapacity: true)
            self.attending.removeAll(keepCapacity: true)

            if let object = object {
                for events in object {
                    print(events)
                    self.images.append(events["image"] as! PFFile)
                    self.usernames.append(events["user"] as! String)
                    self.attending.append(String(events["attending"]))
                    
                    var userQuery = PFUser.query()
                    userQuery?.whereKey("name", equalTo: events["user"])
                    userQuery?.findObjectsInBackgroundWithBlock({ (object, error) -> Void in
                        if error == nil {
                            for users in object! {
                                if users["image"] != nil {
                                    self.userImages.append(users["image"] as! PFFile)
                                    print(self.userImages, "hi")
                                    self.table.reloadData()
                                }
                            }
                        }
                    })

                }
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usernames.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("feedCell", forIndexPath: indexPath) as! FeedTableViewCell
        
        // Configure the cell...
        
        if images.count > 0{
            cell.usernameLabel.text = usernames[indexPath.row]
            cell.goingLabel.text = "Going: \(attending[indexPath.row])"
            images[indexPath.row].getDataInBackgroundWithBlock({ (data, error) -> Void in
                if let downloadedImage = UIImage(data: data!) {
                    
                    cell.eventImage.image = downloadedImage
                    
                }
            })
            if userImages.count ==  images.count {
            userImages[indexPath.row].getDataInBackgroundWithBlock({ (data, error) in
                if let downloadedUserImage = UIImage(data: data!) {
                    cell.userImage.image = downloadedUserImage
                }
                
            })
            }
        }
        
        
        
        
        return cell
    }


}
