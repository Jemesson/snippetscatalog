//
//  MasterTableViewController.swift
//  CatalogoSnippets
//
//  Created by Jemesson Lima on 18/04/21.
//

import UIKit

protocol SnippetSelectionDelegate: AnyObject {
    func snippetSelected(_ newSnippet: Snippet)
}

class MasterTableViewController: UITableViewController {
    weak var delegate: SnippetSelectionDelegate?
    var selectedTag: Tag = Tag(name: "Networking")

    var snippets: [Snippet] = [
        Snippet(name: "Snippet 1", content: "let x = 10", tag: Tag(name: "Networking")),
        Snippet(name: "Snippet 2", content: "let y = true", tag: Tag(name: "Persistência")),
        Snippet(name: "Snippet 3", content: "let z = \"zZzZ\"", tag: Tag(name: "Layouts"))
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snippets.filter{ $0.tag.name == selectedTag.name}.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = tableView.dequeueReusableCell(withIdentifier: "SnippetRow", for: indexPath)

        row.textLabel?.text = snippets.filter{ $0.tag.name == selectedTag.name}[indexPath.row].name
        
        return row
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSnippet = snippets.filter{ $0.tag.name == selectedTag.name}[indexPath.row]
        delegate?.snippetSelected(selectedSnippet)
        
        if let detailViewController = delegate as? DetailViewController {
            splitViewController?.showDetailViewController(detailViewController, sender: nil)
        }
    }

    @IBAction func addNewSnippet(_ sender: UIBarButtonItem) {
        let snippet = Snippet(
            name: "Snippet \(snippets.count + 1)",
            content: "let x = \(snippets.count + 1)",
            tag: selectedTag
        )

        snippets.append(snippet)
        tableView.reloadData()
    }
}

extension MasterTableViewController: SelectedTagDelegate {
    func selectedTag(_ tag: Tag) {
        self.selectedTag = tag
        tableView.reloadData()
    }
}
