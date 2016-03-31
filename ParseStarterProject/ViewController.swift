/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse
import ParseFacebookUtilsV4
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let permissions = ["public_profile"]
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions) { (user, error) -> Void in
            if let error = error {
                print(error)
            } else {
                if let user = user {
                print(user)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        if let username  = PFUser.currentUser()?.username {
            performSegueWithIdentifier("showSigninScreen", sender: self)
        }
    }
}
