//
//  AddEventViewController.swift
//  Turnt
//
//  Created by Darryl Nunn on 3/31/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    var activityIndicator = UIActivityIndicatorView()


    @IBOutlet var eventGuest: UITextField!
    @IBOutlet var eventImage: UIImageView!
    @IBOutlet var eventTime: UITextField!
    @IBOutlet var eventName: UITextField!
    @IBOutlet var eventAges: UITextField!
    @IBOutlet var eventMusic: UITextField!
    @IBOutlet var eventDate: UITextField!
    @IBOutlet var eventState: UITextField!
    @IBOutlet var eventStreet: UITextField!
    
    
    
    @IBAction func addFlyer(sender: AnyObject) {
        
        let image = UIImagePickerController()
        image.delegate = self
        image.allowsEditing = true
        
        if #available(iOS 8.0, *) {
            let alert = UIAlertController(title: "Choose Upload Source", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            alert.view.tintColor = UIColor.purpleColor()
            alert.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                image.sourceType = UIImagePickerControllerSourceType.Camera
                alert.dismissViewControllerAnimated(true, completion: nil)
                self.presentViewController(image, animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                alert.dismissViewControllerAnimated(true, completion: nil)
                self.presentViewController(image, animated: true, completion: nil)
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
        
    }
  
    
    @IBAction func submitButton(sender: AnyObject) {
        
        activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        let imageData = UIImagePNGRepresentation(eventImage.image!)
        let imageFile = PFFile(name: "image.png", data: imageData!)
        
        let post = PFObject(className: "Events")
        post["time"] = eventTime.text
        post["date"] = eventDate.text
        post["ages"] = eventAges.text
        post["address"] = "\(eventStreet.text!), \(eventState.text!), USA"
        post["music"] = eventMusic.text
        post["guest"] = eventGuest.text
        post["name"] = eventName.text
        post["image"] = imageFile
        post["user"] = PFUser.currentUser()?["name"]
        post["attending"] = 0
        
        post.saveInBackgroundWithBlock { (success, error) in
            
            self.activityIndicator.stopAnimating()
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            if error == nil {
                self.postedAlerter("Post Successful", message: "Turn up!", addAction: "Bet")
                self.eventImage.image = UIImage(named: "Placeholder.png")
                self.eventStreet.text = ""
                self.eventState.text = ""
                self.eventGuest.text = ""
                self.eventAges.text = ""
                self.eventMusic.text = ""
                self.eventDate.text = ""
                self.eventStreet.text = ""
                self.eventName.text = ""
                self.eventTime.text = ""
                
            } else {
                self.postedAlerter("Uh Oh!", message: "Please try again later.", addAction: "Womp")
            }
        }
        
        
        
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        eventImage.image = image
    }
    
    func postedAlerter (title:String, message: String, addAction: String){
        
        if #available(iOS 8.0, *) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.view.tintColor = UIColor.purpleColor()
            alert.addAction(UIAlertAction(title: addAction, style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                alert.dismissViewControllerAnimated(true, completion: nil)
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)

        } else {
            // Fallback on earlier versions
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField:UITextField!) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

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
