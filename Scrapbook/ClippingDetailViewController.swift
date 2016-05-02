//
//  ClippingDetailViewController.swift
//  Scrapbook
//
//  Created by SABai on 1/05/2016.
//  Copyright © 2016 Shaobai Li. All rights reserved.
//

import UIKit

class ClippingDetailViewController: UIViewController {

    var img: String!
    var label: String!
    

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var note: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let fileURL = documentsURL.URLByAppendingPathComponent(img)
        image.image = UIImage(contentsOfFile: fileURL.path!)
        //image.image =  UIImage(contentsOfFile: img) //display image from path
        note.text = label
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
