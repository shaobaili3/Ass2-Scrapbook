//
//  CollectionListViewController.swift
//  Scrapbook
//
//  Created by SABai on 29/04/2016.
//  Copyright © 2016 Shaobai Li. All rights reserved.
//

import UIKit

class CollectionListViewController: UITableViewController {

    var book: ScrapbookModel = ScrapbookModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:  UIBarButtonSystemItem.Add, target:  self, action: Selector("addCollection"))
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationNavigationController = segue.destinationViewController as! ClippingListViewController
        let row = self.tableView.indexPathForSelectedRow?.row
        var coll: [Collection] = book.GetCollec()
        
        if(row > 0){
        destinationNavigationController.clips = coll[row! - 1].own?.allObjects as! [Clipping]
        destinationNavigationController.collect = coll[row! - 1]
        }
        else{
        destinationNavigationController.clips = book.GetClip()
        destinationNavigationController.ifAll = true
        }
    }
    
    func addCollection() {
        //Create the AlertController
        let alert: UIAlertController = UIAlertController(title: "Create New Collection", message: "", preferredStyle: .Alert)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Do some stuff
        }
        alert.addAction(cancelAction)
        
        //Add a text field
        alert.addTextFieldWithConfigurationHandler { textField -> Void in
            textField.text = "Collection Name Here"
            //TextField configuration
            //textField.textColor = UIColor.blueColor()
        }

        
        //Create and an option action
        let createAction: UIAlertAction = UIAlertAction(title: "Create", style: .Default) { action -> Void in
            if alert.textFields![0].text != nil{
                self.book.CreateCollec(alert.textFields![0].text!)
            }
            
            self.tableView.reloadData()
         }
        alert.addAction(createAction)
        
        
        //Present the AlertController
        alert.view.setNeedsLayout() //kill bug
        self.presentViewController(alert, animated: true, completion: nil)
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

        return book.GetCollec().count + 1
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("collection", forIndexPath: indexPath)
        var coll: [Collection] = book.GetCollec()
        if indexPath.row > 0{
        cell.textLabel?.text = coll[indexPath.row - 1].name
        
        }
        else{
        cell.textLabel?.text = "All Clipping"
        print("ahahah\(book.GetClip().count)")
        }
        return cell
    }


    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        if indexPath.row == 0{
            return false
        }
        else{
            return true
        }
    }



    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            book.delCollec(book.GetCollec()[indexPath.row - 1])
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            
        }
        
        //else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
       // }
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
