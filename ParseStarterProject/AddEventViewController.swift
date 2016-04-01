//
//  AddEventViewController.swift
//  Turnt
//
//  Created by Darryl Nunn on 3/31/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {

    @IBOutlet var eventImage: UIImageView!
    
    @IBAction func addFlyer(sender: AnyObject) {
    }
    @IBOutlet var eventTime: UITextField!
    @IBOutlet var eventName: UITextField!
    @IBOutlet var eventAges: UITextField!
    @IBOutlet var eventMusic: UITextField!
    @IBOutlet var eventDate: UITextField!
    @IBOutlet var eventState: UITextField!
    @IBOutlet var eventCity: UITextField!
    @IBOutlet var eventStreet: UITextField!
    
    @IBAction func submitButton(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(PFUser.currentUser()?["name"])
        
        

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
