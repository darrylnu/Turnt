//
//  ProfileViewController.swift
//  Turnt
//
//  Created by Darryl Nunn on 3/31/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
import ParseFacebookUtilsV4
import FBSDKCoreKit
import FBSDKLoginKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var userImage: UIImageView!
    
    @IBOutlet var userLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if userLabel.text == "" {
            
            //fetches info from fb
            let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "name, id"])
            graphRequest.startWithCompletionHandler { (connection, result, error) in
                if error != nil {
                    print(error)
                } else if let result = result {
                    PFUser.currentUser()?["name"] = String(result["name"])
                    self.userLabel.text = String(result["name"])
                    
                    do {
                        try PFUser.currentUser()?.save()
                    } catch _ {
                        // catch error
                    }
                    var userId = String(result["id"])
                    var facebookProfilePictureUrl = "http://graph.facebook.com/" + userId + "/picture?type=large"
                    
                    if let fbpicUrl = NSURL(string:facebookProfilePictureUrl) {
                        if let data = NSData(contentsOfURL: fbpicUrl) {
                           self.userImage.image = UIImage(data:data)
                            let imageFile: PFFile = PFFile(data:data)!
                            PFUser.currentUser()?["image"] = imageFile
                            do {
                                try PFUser.currentUser()?.save()
                            } catch _ {
                                // catch error
                            }
                        }
                    }
                }
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        // Configure the cell...
        
        
        
        
        return cell
    }
    
    
}
