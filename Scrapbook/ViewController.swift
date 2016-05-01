//
//  ViewController.swift
//  Scrapbook
//
//  Created by SABai on 29/04/2016.
//  Copyright © 2016 Shaobai Li. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("test start")
        // Do any additional setup after loading the view, typically from a nib.
        let test: ScrapbookModel = ScrapbookModel()
        var collections: [Collection]
        var clippings: [Clipping]
        let collection1 = test.CreateCollec("A")
        test.CreateCollec("B")
        let clip1 = test.CreateClipp("1 foo", image: "URL")
        let clip2 = test.CreateClipp("2 foo", image: "URL")
        test.CreateClipp("3 bar", image: "URL")
        collections = test.GetCollec()
        clippings = test.GetClip()
        for (index, collec) in collections.enumerate()
        {
            print("num\(index): \(collec.name)")
        }
        for (index, clip) in clippings.enumerate()
        {
            print("num\(index): \(clip.note), \(clip.dataCreated), \(clip.image)")
        }
        
        test.addCliptoCollec(clip1, collec: collection1)
        test.addCliptoCollec(clip2, collec: collection1)
        
        let temp = ((collection1.own?.allObjects)! as! [Clipping]) //Dont understand I have to use cast here, If dont use every thing is normal as using cast but image will be ambigious
        for (index, clip) in temp.enumerate()
        {
            print("in collection1 num\(index): \(clip.note), \(clip.dataCreated), \(clip.image)")
            
        }
        
        for (index, clip) in test.Search("foo").enumerate()
        {
            print("in search num\(index): \(clip.note), \(clip.dataCreated), \(clip.image)")
            
        }
        
        for (index, clip) in test.Search2("foo", collec: collection1).enumerate()
        {
            print("in search2(collection1) num\(index): \(clip.note), \(clip.dataCreated), \(clip.image)")
            
        }
        print("test end")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

