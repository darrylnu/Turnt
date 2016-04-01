//
//  SignUpViewController.swift
//  Turnt
//
//  Created by Darryl Nunn on 3/31/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

var signedUpAlready = false

class SignUpViewController: UIViewController {

    @IBAction func backButton(sender: AnyObject) {
        PFUser.logOut()
    }
    
    @IBAction func nextButton(sender: AnyObject) {
        signedUpAlready = true
    }
    
    @IBOutlet var userImage: UIImageView!
    
    @IBOutlet var userLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if signedUpAlready == true {
            performSegueWithIdentifier("showMapView", sender: self)
        } else {
        
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "name, id"])
        graphRequest.startWithCompletionHandler { (connection, result, error) in
            if error != nil {
                print(error)
            } else if let result = result {
                print(result)
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

}
