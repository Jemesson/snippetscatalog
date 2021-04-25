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
    weak var delegate: SelectedTagDelegate?

    var tags: [Tag] = [
        Tag(name: "Networking"),
        Tag(name: "Persistência"),
        Tag(name: "Layouts")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = tableView.dequeueReusableCell(withIdentifier: "TagRow", for: indexPath)

        row.textLabel?.text = tags[indexPath.row].name

        return row
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTag = tags[indexPath.row]
        delegate?.selectedTag(selectedTag)
    }
}
