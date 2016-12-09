//
//  ViewController.swift
//  JOSNSwiftDemo
//
//  Created by Shinkangsan on 12/5/16.
//  Copyright © 2016 Sheldon. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource {

    final let urlString = "http://microblogging.wingnity.com/JSONParsingTutorial/jsonActors"
    
    @IBOutlet weak var tableView: UITableView!
    
    var actorsArray = [Actor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.downloadJsonWithURL()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func downloadJsonWithURL() {
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                print(jsonObj!.value(forKey: "actors"))
                
                if let actorArray = jsonObj!.value(forKey: "actors") as? NSArray {
                    for actor in actorArray{
                        if let actorDict = actor as? NSDictionary {
                            
                            let nameStr: String = {
                                if let name = actorDict.value(forKey: "name") {
                                    return name as! String
                                }
                                return "dummy name"
                            }()
                            
                            let dobStr: String = {
                                
                                if let dob = actorDict.value(forKey: "dob") {
                                    return dob as! String
                                }
                                return "dummy dob"
                            }()
                            
                            let imgStr: String = {
                               
                                if let img = actorDict.value(forKey: "image") {
                                    return img as! String
                                }
                                return "dummy image"
                            }()
                            
                            self.actorsArray.append(Actor(name: nameStr, dob: dobStr, img: imgStr))
                            
                            OperationQueue.main.addOperation({ 
                                self.tableView.reloadData()
                            })
                        }
                    }
                }
            }
        }).resume()
    }

    
    func downloadJsonWithTask() {
        
        let url = NSURL(string: urlString)
        
        var downloadTask = URLRequest(url: (url as? URL)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 20)
        
        downloadTask.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: downloadTask, completionHandler: {(data, response, error) -> Void in
            
            let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            
            print(jsonData)
            
        }).resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actorsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
        let actor = actorsArray[indexPath.row]
        
        cell.nameLabel.text = actor.name
        cell.dobLabel.text = actor.dob
        
        let imgURL = NSURL(string: actor.imageStr)
        
        if imgURL != nil {
            let data = NSData(contentsOf: (imgURL as? URL)!)
            cell.imgView.image = UIImage(data: data as! Data)
        }
        
        return cell
    }
    

}

