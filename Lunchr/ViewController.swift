//
//  ViewController.swift
//  Lunchr
//
//  Created by Rudd Fawcett on 6/5/15.
//  Copyright (c) 2015 Rudd Fawcett. All rights reserved.
//

// Icon by https://thenounproject.com/diegonaive/

import UIKit
import Alamofire

extension UIImage {
    func imageWithColor(color: UIColor) -> UIImage {
        var rect = CGRectMake(0, 0, 1, 1)
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1), false, 0)
        color.setFill()
        UIRectFill(rect)
        var image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

class ViewController: UIViewController {

    let clientId : String = ""
    let clientSecret : String = ""
    let v : String = "20131103"
    let listId : String = "55726bba498e410d55d35db2"

    var venues : NSArray = []

    let intros = ["You should go to",
                "Dude.",
                "Definitely time for some",
                "Don’t you feel like",
                "How about",
                "GET ME SOME FUCKING",
                "Know what would hit the spot?",
                "Feels like a day for",
                "Why not go to",
                "Need somethin healthy.\nHow ’bout",
                "Indulge in some",
                "What about",
                "Hmm...",
                "Jonesing for some",
                "Let’s treat ourselves to",
                "Aren’t you in the mood for",
                "Maybe",
                "Been a while since you’ve gone to",
                "I think Rudd really wants"]

    let backgroundColors = [UIColor(red:0.35, green:0.35, blue:0.83, alpha:1),
                            UIColor(red:0.08, green:0.49, blue:0.98, alpha:1),
                            UIColor(red:0.24, green:0.67, blue:0.85, alpha:1),
                            UIColor(red:0.38, green:0.79, blue:0.97, alpha:1),
                            UIColor(red:0.33, green:0.84, blue:0.41, alpha:1),
                            UIColor(red:1, green:0.8, blue:0.18, alpha:1),
                            UIColor(red:0.99, green:0.58, blue:0.15, alpha:1),
                            UIColor(red:0.99, green:0.24, blue:0.22, alpha:1),
                            UIColor(red:0.99, green:0.2, blue:0.35, alpha:1)]

    lazy var label : UILabel = {
        let label = UILabel()

        let padding : CGFloat = 30
        let width = self.view.bounds.size.width - (2 * padding)

        label.frame = CGRectMake(padding, 100, width, 300)
        label.numberOfLines = 0
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center
        return label
    }()

    lazy var somewhereElse : UIButton = {
       let button = UIButton()

        let buttonWidth : CGFloat = 170
        let padding = (self.view.bounds.size.width - buttonWidth) / 2

        button.frame = CGRectMake(padding, 400, buttonWidth, 40)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.setTitleColor(UIColor(white:0.27, alpha:1.0), forState: .Normal)
        button.setTitle("Somewhere else", forState: .Normal)
        button.backgroundColor = UIColor(white:0.93, alpha:1.0)
        button.setBackgroundImage(UIImage().imageWithColor(UIColor(white:0.8, alpha:1.0)), forState: .Highlighted)

        button.addTarget(self, action: "fetchList", forControlEvents: .TouchUpInside)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(label)

        self.view.addSubview(somewhereElse)

        self.fetchList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func buildAttributedString(intro: String, place: String) -> NSAttributedString {
        var labelString = "\(intro)\n\(place)"
        var attributedString = NSMutableAttributedString(string: labelString, attributes: [NSFontAttributeName : UIFont.systemFontOfSize(25), NSForegroundColorAttributeName : UIColor.whiteColor()])
        attributedString.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(40), range: NSMakeRange((count(labelString) - count(place)), count(place)))

        return attributedString
    }

    func fetchList() {
        let queryString : String = "https://api.foursquare.com/v2/lists/\(listId)/?client_id=\(clientId)&client_secret=\(clientSecret)&v=\(v)"

        var introIndex = Int(arc4random_uniform(UInt32(intros.count)))
        var itemIndex = Int(arc4random_uniform(UInt32(venues.count)))
        var backgroundIndex = Int(arc4random_uniform(UInt32(self.backgroundColors.count)))

        if venues.count == 0 {
            Alamofire.request(.GET, queryString)
                .responseJSON { (_, _, JSON, _) in
                    var response = JSON as! NSDictionary
                    response = response.objectForKey("response") as! NSDictionary
                    response = response.objectForKey("list") as! NSDictionary
                    response = response.objectForKey("listItems") as! NSDictionary
                    var items = response.objectForKey("items") as! NSArray

                    self.venues = items

                    let place = self.venues[itemIndex] as! NSDictionary
                    let name = place.objectForKey("venue")?.objectForKey("name") as! String

                    self.label.attributedText = self.buildAttributedString(self.intros[introIndex], place: name)
                    self.view.backgroundColor = self.backgroundColors[backgroundIndex]
            }
        }
        else {
            let place = self.venues[itemIndex] as! NSDictionary
            let name = place.objectForKey("venue")?.objectForKey("name") as! String

            self.label.attributedText = self.buildAttributedString(self.intros[introIndex], place: name)
            self.view.backgroundColor = self.backgroundColors[backgroundIndex]
        }
    }
}
