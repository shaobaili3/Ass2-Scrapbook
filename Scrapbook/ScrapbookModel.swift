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
    
    //for (index, value) in shoppingList.enumerate() {
    //print("Item \(index + 1): \(value)")
    
//    2) Get all collections (returns an array of Collections). Note, if you’re developing for Android, it is inside
//    this function that you create instances of your basic Collection class and return an array of them.
//    3) Create a new clipping (pass this function new clipping details: ie an image and notes string)
//    4) Android only: Get all clippings that belong to a certain collection (pass in the primary key of the
//    Collection). Note iOS: you can forgo implementing this method, as you can access a Collection’s
//    Clippings directly from a Collection object using the dot syntax.
//    5) Add a Clipping to a Collection

    
    
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
    //    6) Delete a Collection
    //    7) Delete a Clipping
    //    8) Search function: Get all clippings whos notes attribute contains a provided search string (pass in a
    //    search string, return an array of Clippings). Make this search case insensitive. iOS: you must use
    //    NSPredicate for this.
    //    9) Search function #2: Same as above but this method should also take a Collection parameter (primary
    //    key on Android) that searches for the search string in Clippings contained within the provided Collection. Make this search case insensitive.
    
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
        let temp: [Clipping] = collec.own?.allObjects as! [Clipping]
        let predicate = NSPredicate(format: "note contains[cd] %@", keyword)
        (temp as NSArray).filteredArrayUsingPredicate(predicate)
        return temp
    }

}