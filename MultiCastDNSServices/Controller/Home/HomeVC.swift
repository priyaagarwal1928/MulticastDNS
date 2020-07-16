//
//  HomeVC.swift
//  MultiCastSearch
//
//  Created by priya agarwal on 15/07/2020.
//  Copyright © 2020 priya agarwal. All rights reserved.
//

import UIKit

var logConsole = ""

class HomeVC: UIViewController,HostPresenterDelegate {
        
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblServices: UILabel!
    
    //MARK: - Variables
    private var hostPresenter = HostPresenter(hostService: HostService())
    private var joinPresenter = JoinPresenter(joinService: JoinService())
    var services: [NetService]?
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        lblServices.isHidden = true
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        logConsole = ""
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    //MARK: - Button Actions
    
    @IBAction func btnScan(_ sender: Any) {
        
        joinPresenter.setDelegate(delegate: self)
        joinPresenter.startBrowsing()
        
    }
    
    @IBAction func btnPublish(_ sender: Any) {
        
        hostPresenter.setDelegate(delegate: self)
        hostPresenter.startBroadcast()
    }
    
}

extension HomeVC: JoinPresenterDelegate
{
    func netService(status: String) {
        
        print(status)
    }
    
    func netServiceBrowser(status: String) {
        
        print(status)
        
    }
    
    func socket(status: String, socket: GCDAsyncSocket) {
        
        print(status)
        
    }
    
    func reloadConnections(services: [NetService]) {
        
        self.services = services
        
        if let servicesArr = self.services
        {
            for serModal in servicesArr {
                
                joinPresenter.serviceSelected(service: serModal)
                
            }
            
            tableView.isHidden = false
            lblServices.isHidden = false
            tableView.reloadData()
            tableView.estimatedRowHeight = 100
            tableView.rowHeight = UITableView.automaticDimension
        }
        
        
    }
    
}


extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.services?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JoiningTableViewCell") as! JoiningTableViewCell
        if let service = self.services?[indexPath.row]
        {
            cell.lblserviceNm.text = service.name
            cell.lblserviceType.text = service.type
            cell.lblPort.text = "\(service.port)"
            
            var ipAdd = ""
            if let address = service.addresses{
                if let addressOfFirstDevice = address.first{
                    let theAddress = addressOfFirstDevice as Data
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    if getnameinfo((theAddress as NSData).bytes.bindMemory(to: sockaddr.self, capacity: theAddress.count), socklen_t(theAddress.count),
                                   &hostname, socklen_t(hostname.count), nil, 0, NI_NUMERICHOST) == 0 {
                        if let numAddress = String(validatingUTF8: hostname) {
                            ipAdd = numAddress
                        }
                    }
                }
            }
            
            cell.lblIPAdd.text = ipAdd
            
        }
        
        
        return cell
    }
    
    
}
