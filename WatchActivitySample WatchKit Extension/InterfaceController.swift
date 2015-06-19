//
//  InterfaceController.swift
//  WatchActivitySample WatchKit Extension
//
//  Created by An Phung on 6/19/15.
//  Copyright © 2015 HDE, Inc. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity



class InterfaceController: WKInterfaceController, WCSessionDelegate {
    // MARK: Properties
    
    /// Default WatchConnectivity session for communicating with the phone.
    let session = WCSession.defaultSession()
    
    var count = 0
    
    @IBOutlet var label: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Initialize the `WCSession`.
        session.delegate = self
        session.activateSession()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    func session(session: WCSession, didReceiveMessage message: [String: AnyObject], replyHandler: [String: AnyObject] -> Void) {
        guard let m = message["m"] as? String else { return }
        self.label.setText(m)
    }
    
    @IBAction func buttonPressed() {
        let message = [
            "m": "😀Watch \(count++)"
        ]
        session.sendMessage(message, replyHandler: { replyDict in
            }, errorHandler: { error in
        })
    }
}
