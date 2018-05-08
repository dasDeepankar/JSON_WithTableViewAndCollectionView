//
//  ViewController.swift
//  JSON
//
//  Created by brn.developers on 5/5/18.
//  Copyright © 2018 brn.developers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var dataTosend = [String:Any]()
    var dataTask = URLSessionDataTask()
    var urlSession = URLSession(configuration: URLSessionConfiguration.default)
    
 
    @IBOutlet weak var imgV1: UIImageView!
    @IBOutlet weak var imgV2: UIImageView!
    @IBOutlet weak var imgV3: UIImageView!
    @IBOutlet weak var imgV4: UIImageView!
    @IBOutlet weak var imgV5: UIImageView!
    @IBOutlet weak var imgV6: UIImageView!
    @IBOutlet weak var imgV7: UIImageView!
    @IBOutlet weak var imgV8: UIImageView!
    var  imageViewArr: [UIImageView]! = nil
    
    var urlStringArr:NSMutableArray! = nil
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor.black
        urlStringArr = ["https://is1-ssl.mzstatic.com/image/thumb/Music118/v4/24/b6/47/24b64748-76fc-1d73-2316-c6c06ba8fde1/source/200x200bb.png","https://is2-ssl.mzstatic.com/image/thumb/Music128/v4/29/c6/a4/29c6a47d-b708-b102-5218-a33bbd9da0ea/source/200x200bb.png","https://is3-ssl.mzstatic.com/image/thumb/Music128/v4/bb/ca/eb/bbcaeb6e-c981-15c1-2d5d-ffc0935d27b7/source/200x200bb.png","https://is5-ssl.mzstatic.com/image/thumb/Music128/v4/0a/c7/ce/0ac7ce76-e268-3f5e-b772-9776fc9bc8cb/source/200x200bb.png","https://is1-ssl.mzstatic.com/image/thumb/Music118/v4/2d/89/90/2d899017-74da-fc08-ed00-ed1c94945c29/source/200x200bb.png","https://is5-ssl.mzstatic.com/image/thumb/Music118/v4/3e/fc/30/3efc3003-6917-e7ac-07bf-4396713d9e97/source/200x200bb.png","https://is4-ssl.mzstatic.com/image/thumb/Music118/v4/7a/fd/06/7afd0610-2f0a-c570-53b9-33a8e90575a7/source/200x200bb.png","https://is3-ssl.mzstatic.com/image/thumb/Music128/v4/0e/95/c4/0e95c49c-2689-cd21-d4cb-f2787699be7b/source/200x200bb.png"]

        imageViewArr = [imgV1,imgV2,imgV3,imgV4,imgV5,imgV6,imgV7,imgV8]
        print(imageViewArr.count)
        
        activityIndicator.startAnimating()
        DispatchQueue.main.async {
            for i in 0..<self.imageViewArr.count {
                let data = NSData.init(contentsOf: URL.init(string: self.urlStringArr[i] as! String)!)
                self.imageViewArr[i].image = UIImage.init(data: data! as Data)!
                print(i)
            }
             self.activityIndicator.stopAnimating()
        }
    }
    
    
    
    func jsonLoad() {
        
        
    var urlReq = URLRequest(url: URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/hot-tracks/all/10/explicit.json")!)
    urlReq.httpMethod = "GET"

    self.dataTask = self.urlSession.dataTask(with: urlReq, completionHandler: { (data, res, err) in

        do{
            
        self.dataTosend = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : Any]
            
        
            
        }
        catch{
            
        print(err!)
        }
    })
        
        self.dataTask.resume()
            print(self.dataTosend)
        
        
    }
   
    @IBAction func tableViewButton(_ sender: UIButton) {
        
        
        let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated)
        
        queue.sync {
            jsonLoad()
        }
        performSegue(withIdentifier: "show", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let sendingData = segue.destination as! ITuneTableViewController
    
        sendingData.pri = self.dataTosend
        
    }
    
    @IBAction func collectionViewButton(_ sender: UIButton) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}

