//
//  TagsViewController.swift
//  CatalogoSnippets
//
//  Created by Jemesson Lima on 21/04/21.
//

import UIKit

protocol SelectedTagDelegate: AnyObject {
    func selectedTag(_ tag: Tag)
}

class TagsViewController: UITableViewController {
    var tags: [Tag] = [
        Tag(name: "Networking"),
        Tag(name: "Persistência"),
        Tag(name: "Layouts")
    ]

    weak var delegate: SelectedTagDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell", for: indexPath)

        cell.textLabel?.text = tags[indexPath.row].name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTag = tags[indexPath.row]
        delegate?.selectedTag(selectedTag)
    }
}
