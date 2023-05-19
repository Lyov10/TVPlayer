//
//  ViewController.swift
//  TVPlayer
//
//  Created by 4steps on 19.05.23.
//

import UIKit

enum SelectedTab {
    case all
    case favorite
}

class AllChanellsViewController: UIViewController {

    @IBOutlet weak var searchTextField: CommonTextField!
    @IBOutlet weak var allChanelsButton: UIButton!
    @IBOutlet weak var allChanellsSeperator: UIView!
    @IBOutlet weak var favoriteButtonSeperator: UIView!
    @IBOutlet weak var favoriteChanellsButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private var chanellList: ChanellList? {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var allChanells: ChanellList?
    private let toVideoViewController = "VideoViewController"
    private var selectedTab: SelectedTab = .all {
        didSet {
            setupSelectedTab()
        }
    }
    
    private var channellsId = UserDefaults.standard.array(forKey: Constatns.UserDefaults.channelsIds) as? [Int] ?? []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: TvChannelTableViewCell.id, bundle: nil), forCellReuseIdentifier: TvChannelTableViewCell.id)
        tableView.contentInset.top = 20
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Напишите название телеканала",
            attributes: [NSAttributedString.Key.foregroundColor: Constatns.Collor.placeholder!]
        )
        RequestManager.sharedInstance.getChanells(completion: {[weak self] channelList in
            guard let self = self else {return}
            self.chanellList = channelList
            self.allChanells = channelList
        })
    }

    func setupSelectedTab() {
        allChanelsButton.setTitleColor(selectedTab == .all ? .white : .white.withAlphaComponent(0.5) , for: .normal)
        favoriteChanellsButton.setTitleColor(selectedTab == .favorite ? .white : .white.withAlphaComponent(0.5) , for: .normal)
        allChanellsSeperator.backgroundColor = selectedTab == .all ? Constatns.Collor.seperatorCollor : .clear
        favoriteButtonSeperator.backgroundColor = selectedTab == .favorite ? Constatns.Collor.seperatorCollor : .clear
    }
    
    @IBAction func favoriteButtonTaped(_ sender: Any) {
        selectedTab = .favorite
        guard let chanells = chanellList?.channels else {return}
        chanellList = ChanellList(channels: chanells.filter{channellsId.contains($0.id)})
    }
    
    @IBAction func allButtonTaped(_ sender: Any) {
        selectedTab = .all
        chanellList = allChanells
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case toVideoViewController:
            let VC = segue.destination as! VideoViewController
            guard let model = sender as? ChannelModel else {return}
            VC.chanelModel = model
        default:
            break
        }
    }
}


extension AllChanellsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let chanellList = chanellList else {return 0}
        return chanellList.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let chanellList = chanellList else {return UITableViewCell()}
        let cell =  tableView.dequeueReusableCell(withIdentifier: TvChannelTableViewCell.id, for: indexPath) as! TvChannelTableViewCell
        cell.delegate = self
        cell.setupCell(model: chanellList.channels[indexPath.row],isFavorite: channellsId.contains(chanellList.channels[indexPath.row].id))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let chanellList = chanellList else {return}
        performSegue(withIdentifier: toVideoViewController, sender: chanellList.channels[indexPath.row])
    }
}
 

extension AllChanellsViewController: TvChannelTableViewCellDelegate {
    func favoriteButtonDidTapped(id: Int) {
        if channellsId.contains(id) {
            channellsId.removeAll(where: {$0 == id})
        } else {
            channellsId.append(id)
        }
        UserDefaults.standard.setValue(channellsId, forKey: Constatns.UserDefaults.channelsIds)
    }
}
