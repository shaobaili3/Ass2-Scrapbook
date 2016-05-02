//
//  ScrapbookModel.swift
//  Scrapbook
//
//  Created by SABai on 29/04/2016.
//  Copyright © 2016 Shaobai Li. All rights reserved.
//
import UIKit
import Foundation
import CoreData

class ScrapbookModel{
    //let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    //Create a new collection
    func CreateCollec(name: String) -> Collection {
        let newCollection: Collection = NSEntityDescription.insertNewObjectForEntityForName("Collection", inManagedObjectContext: context) as! Collection
        newCollection.name = name
        
        do{
            try context.save()
        }
        catch let error as NSError{
            print("Could not save \(error), \(error.userInfo)")
        }
        return newCollection
    }
    
    //Get all collections
    func GetCollec() -> [Collection] {
        let fetch = NSFetchRequest(entityName: "Collection")
        var temp = [Collection]()
        do{
            temp = try context.executeFetchRequest(fetch) as! [Collection]
        }catch let error as NSError{
            print("Fetch error: \(error), \(error.userInfo)")
        }
        return temp
    }
    
    //Get all clipping for testing
    func GetClip() -> [Clipping]{
        let fetch = NSFetchRequest(entityName: "Clipping")
        var temp = [Clipping]()
        do{
            temp = try context.executeFetchRequest(fetch) as! [Clipping]
        }catch let error as NSError{
            print("Fetch error: \(error), \(error.userInfo)")
        }
        return temp
    }

    
    //Create a new clipping
    func CreateClipp(note:String, image:String) -> Clipping{
        let newClip: Clipping = NSEntityDescription.insertNewObjectForEntityForName("Clipping", inManagedObjectContext: context) as! Clipping
        newClip.note = note
        newClip.dataCreated = NSDate()
        newClip.image = image
        
    
        do{
            try context.save()
        }
        catch let error as NSError{
            print("Could not save \(error), \(error.userInfo)")
        }
        return newClip
    }
    
    //Add a Clipping to a Collection
    func addCliptoCollec(clip: Clipping, collec: Collection){
        clip.belong = collec
        do{
            try context.save()
        }
        catch let error as NSError{
            print("Could not add Cliping to Collection \(error), \(error.userInfo)")
        }
    }
    
    //Delete a Collection
    func delCollec(collec: Collection){
        context.deleteObject(collec)
        do{
            try context.save()
        }
        catch let error as NSError{
            print("Could deleteCollection\(error), \(error.userInfo)")
        }
    }
    
    //Delete a Clipping
    func delClipping(clip: Clipping){
        context.deleteObject(clip)
        do{
            try context.save()
        }
        catch let error as NSError{
            print("Could deleteClip\(error), \(error.userInfo)")
        }
    }
    
    //search without Collection parameter
    func Search(keyword:String)->[Clipping]{
        
        let fetchRequest = NSFetchRequest(entityName: "Clipping")
        let predicate = NSPredicate(format: "note contains[cd] %@", keyword)
        fetchRequest.predicate = predicate
        var re: [Clipping]?
        do{
            re = try context.executeFetchRequest(fetchRequest) as? [Clipping]
        }
        catch let error as NSError{
            print("Could search\(error), \(error.userInfo)")
        }
        
        return re!
    }
     //search with collection parameter
    func Search2(keyword:String, collec: Collection)-> [Clipping]{
        let fetchRequest = NSFetchRequest(entityName: "Clipping")
        let predicate = NSPredicate(format: "note contains[cd] %@", keyword)
        fetchRequest.predicate = predicate
        var re: [Clipping]?
        do{
            re = try context.executeFetchRequest(fetchRequest) as? [Clipping]
        }
        catch let error as NSError{
            print("Could search\(error), \(error.userInfo)")
        }
        
        var re2: [Clipping] = []
        
        for clip in re!
        {
            if clip.belong == collec
            {
                re2.append(clip)
            }
        }
        
        return re2
    }
    

}