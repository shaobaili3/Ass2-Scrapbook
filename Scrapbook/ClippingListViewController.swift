//
//  ClippingListViewController.swift
//  Scrapbook
//
//  Created by SABai on 30/04/2016.
//  Copyright © 2016 Shaobai Li. All rights reserved.
//

import UIKit

class ClippingListViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var ifAll: Bool = false; // if this is all clips, if it is show edit button, if not show add button
    var clips: [Clipping] = []
    var collect: Collection?
    var imagePicker = UIImagePickerController()
    var book: ScrapbookModel = ScrapbookModel()
    var note:String!
    var image:String!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationNavigationController = segue.destinationViewController as! ClippingDetailViewController
        let row = self.tableView.indexPathForSelectedRow?.row
        destinationNavigationController.label = clips[row!].note
        destinationNavigationController.img = clips[row!].image
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if ifAll
        {
            self.navigationItem.rightBarButtonItem = self.editButtonItem()
        }
        else
        {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:  UIBarButtonSystemItem.Add, target:  self, action: Selector("addClipping"))
        }
            
        imagePicker.delegate = self
            
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            print("dis")        })
        //let newImg: UIImage = image
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let fileURL = documentsURL.URLByAppendingPathComponent(String(NSDate()) + ".png")
        let pngImageData = UIImagePNGRepresentation(image) //save as png
        let result = pngImageData!.writeToFile(fileURL.path!, atomically: true) //save to file
        //fileURL.path! use to display the image again
        if result{
            print("savesuccess")}
        else{
            print("save error")
        }

        print("xxxxx")
        
        //Create the AlertController
        let alert: UIAlertController = UIAlertController(title: "Create New Collection", message: "", preferredStyle: .Alert)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Do some stuff
        }
        alert.addAction(cancelAction)
        
        //Add a text field
        alert.addTextFieldWithConfigurationHandler { textField -> Void in
            textField.text = "Clipping Name Here"
            //TextField configuration
            //textField.textColor = UIColor.blueColor()
        }
        
        
        //Create and an option action
        let createAction: UIAlertAction = UIAlertAction(title: "Create", style: .Default) { action -> Void in
            if alert.textFields![0].text != nil{
                let newClip: Clipping = self.book.CreateClipp(alert.textFields![0].text!, image: fileURL.path!)
                self.clips.append(newClip)
                self.book.addCliptoCollec(newClip, collec: self.collect!)
            }
            
            self.tableView.reloadData()
        }
        alert.addAction(createAction)
        
        
        //Present the AlertController
        alert.view.setNeedsLayout() //kill bug
        self.presentViewController(alert, animated: true, completion: nil)
    }
    


//    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary?){
//        self.dismissViewControllerAnimated(true, completion: { () -> Void in
//            print("dis")        })
//        print(image)
//        print(editingInfo)
//        //imageView.image = image
//        
//    }
    
    func addClipping() {
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Create New Clipping", message: "", preferredStyle: .ActionSheet)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        //Create and add first option action
        let takePictureAction: UIAlertAction = UIAlertAction(title: "Take Picture", style: .Default) { action -> Void in
            //Code for launching the camera goes here
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
            {
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
                //self.imagePicker.allowsEditing = true //make photo can be edited
                self .presentViewController(self.imagePicker, animated: true, completion: nil)
            }
            else
            {
                //let alertWarning = UIAlertView(title:"Warning", message: "You don't have camera", delegate:nil, cancelButtonTitle:"OK")
                
                let alert: UIAlertController = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .Alert)
                
                //Create and add the Cancel action
                let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
                    //Do some stuff
                }
                alert.addAction(cancelAction)
                alert.view.setNeedsLayout() //kill bug
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        actionSheetController.addAction(takePictureAction)
        //Create and add a second option action
        let choosePictureAction: UIAlertAction = UIAlertAction(title: "Choose From Camera Roll", style: .Default) { action -> Void in
            //Code for picking from camera roll goes here
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
                
                
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
                self.imagePicker.allowsEditing = false
                
                self.presentViewController(self.imagePicker, animated: true, completion: nil)
            }
            
        }
        actionSheetController.addAction(choosePictureAction)
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("hhe \(clips.count)")
        return clips.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Clipping", forIndexPath: indexPath)
        print("ahhah")
        cell.textLabel!.text = clips[indexPath.row].note
        note = clips[indexPath.row].note
        image = clips[indexPath.row].image
        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

 
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            
            book.delClipping(clips[indexPath.row])
            clips.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
