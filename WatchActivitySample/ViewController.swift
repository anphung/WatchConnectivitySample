//
//  ViewController.swift
//  WatchActivitySample
//
//  Created by An Phung on 6/19/15.
//  Copyright © 2015 HDE, Inc. All rights reserved.
//

import UIKit
import WatchConnectivity


class ViewController: UIViewController, WCSessionDelegate {
    /// Default WatchConnectivity session for communicating with the phone.
    let session = WCSession.defaultSession()
    
    var count = 0

    @IBOutlet weak var label: UILabel!
    // MARK: Initialization
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        commonInit()
    }
    
    /**
    Sets the delegates and activate the `WCSession`.
    
    The `WCSession` needs to be activated in the init methods so that when the
    app is launched into the background when it wasn't previously running, the
    session can still be activated allowing communication between the watch and
    the phone. Activating the session in the `viewDidLoad()` method wont suffice
    since the `viewDidLoad()` method will not be called if the app is launched
    into the background.
    */
    func commonInit() {
        
        // Initialize the `WCSession` and the `CLLocationManager`.
        session.delegate = self
        session.activateSession()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func session(session: WCSession, didReceiveMessage message: [String: AnyObject], replyHandler: [String: AnyObject] -> Void) {
        guard let m = message["m"] as? String else { return }
        self.label.text = m

    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        let message = [
            "m": "iPhone \(count++)"
        ]
        session.sendMessage(message, replyHandler: { replyDict in
            }, errorHandler: { error in
        })
    }
}

