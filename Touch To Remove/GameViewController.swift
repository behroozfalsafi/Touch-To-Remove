//
//  GameViewController.swift
//  Pong4
//
//  Created by Behrooz Falsafi on 3/1/20.
//  Copyright © 2020 Behrooz Falsafi. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

//setup currentGameType variable here so we can pass it alone from menuVC to GameScene.swift
var currentGameType = gameType.medium
let colorArray = [ 5 ,5 , 5, 189]

class GameViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("TableView elements count = \(countriesArray.count)")
        return countriesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("---------------------------")//Debugging
        
        //set our cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
        let country = countriesArray[indexPath.row]
        //configure the UI
        cell.countLb.text = country.country
        cell.slugLb.text = country.slug
        cell.nConfLb.text = country.nConf
        
        cell.moon.backgroundColor = UIColor(red: CGFloat(colorArray[0]), green: CGFloat(colorArray[3]) / 200, blue: CGFloat(colorArray[1]), alpha: CGFloat(colorArray[2]))
        //cell.moon.backgroundColor = UIColor.red
        cell.countLb.textColor = UIColor(red: CGFloat(colorArray[0]), green: CGFloat(colorArray[3]) / 200, blue: CGFloat(colorArray[1]), alpha: CGFloat(colorArray[2]))
        cell.nConfLb.textColor = UIColor(red: CGFloat(colorArray[0]), green: CGFloat(colorArray[3]) / 200, blue: CGFloat(colorArray[1]), alpha: CGFloat(colorArray[2]))
        //for color in colorArray {
        //cell.nDeathLb.text = nDeathArray[indexPath.row]
        //cell.tDeathLb.text = tDeathArray[indexPath.row]
        //cell.nRecLb.text = nRecArray[indexPath.row]
        //cell.tRecLb.text = tRecArray[indexPath.row]
        print(cell)
        //cell.scoreLabel.text = scoreArray[indexPath.row]
        //lets get the image URL to transfer it to NSURL
        //let imgURL = NSURL(string: imgURLArray[indexPath.row])
        //if imgURL != nil {
            //lets get data from the image URL.
            //let data = NSData(contentsOf: (imgURL as? URL)!)
            //cell.imgView.image = UIImage(data: data as! Data)
        //}
        return cell
    }
    
     final let urlString = "https://api.covid19api.com/summary"
    @IBOutlet weak var tableView: UITableView!
    var countriesArray = [Country]()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //create a view
         self.downloadudJsonWithURL()
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                //Grabbing the boundaries of our scene project and applying it to our scene that we created right above
                scene.size = view.bounds.size
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    func moveToEndMenuVC () {
        performSegue(withIdentifier: "name", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func buttonPressed(sender:UIButton!)
    {
       //let buttonRow = sender.tag
       print("button is Pressed")
       //print("Clicked Button Row is",buttonRow)
    }
    //first way to create the data task.
    func downloadudJsonWithURL() {
        
        let url = NSURL(string: urlString)
        print("let url = NSURL(string: url...")//Debugging
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler:  {(Data, response, Error) -> Void in
            print("URLSession.shared.dataTask...")//Debugging
            //Transfer data into NSDictionary
            if let jsonObj = try? JSONSerialization.jsonObject(with: Data!, options: .allowFragments) as? NSDictionary {
                print("if let jsonObj = try?...")//Debugging
                //Define "Countries" Array
                if let countryArray = jsonObj.value(forKey: "Countries") as? NSArray {
                    print("if let responseArray = ....")//Debugging
                    
                    ////we are in the main treath
                    OperationQueue.main.addOperation({
                        
                    //for every element of the "Countries" erray
                    for country in countryArray{

                        self.tableView.reloadData()
                        //Parse the dictionary.
                        if let countryeDict = country as? NSDictionary {
                            
                            let countryStr: String = {
                                if let country = countryeDict.value(forKey: "Country") {
                                    return country as! String
                                }
                                return "dummy name"
                            }()
                            
                            let slugStr: String = {
                                if let slug = countryeDict.value(forKey: "Slug") {
                                    return slug as! String
                                }
                                return "dummy name"
                            }()
                            
                            let nConfStr: String = {
                                if let nConfNewFormat = countryeDict.value(forKey: "NewConfirmed") {
                                    let nConf:String = String(format: "%@", nConfNewFormat as! CVarArg)
                                    return nConf
                                }
                                return "dummy name"
                            }()
                            

                            self.countriesArray.append(Country(country: countryStr, slug: slugStr, nConf: nConfStr))
                            //--------------------
                        }
                     print( "total elements(jsonObj) in array = \((jsonObj as AnyObject).count ?? 0) ")//Debugging
                    }
                        //Reload data in the background so we can get number of rows
                        self.tableView.reloadData()
                        })
                }
            }
        }).resume()
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}
