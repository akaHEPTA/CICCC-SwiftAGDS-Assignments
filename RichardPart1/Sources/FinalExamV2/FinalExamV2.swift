
/// Serialize a binary tree into an array.
///
/// - Parameter node: the root node of a binary tree.
/// - Returns: serialialized binary tree as an array.
func serialize<T>(_ node: BinaryNode<T>) -> [T?] {
    var result = [T?]()
    node.traversePreOrder(visit: { result.append($0) })
    return result
}

/// Deserialize the resulting array into a binary tree.
///
/// - Parameter arr: serialized array.
/// - Returns: the root node of deserialized binary tree.
func deserialize<T>(_ arr: inout [T?]) -> BinaryNode<T>? {
    arr = arr.reversed()
    let root = BinaryNode(value: arr.removeFirst()!)
    
    func addChild(parent: BinaryNode<T>, arr: inout [T?]) {
        if let leftChild = arr.removeFirst() {
            parent.leftChild = BinaryNode(value: leftChild)
            addChild(parent: parent.leftChild!, arr: &arr)
        }
        if let rightChild = arr.removeFirst() {
            parent.rightChild = BinaryNode(value: rightChild)
            addChild(parent: parent.rightChild!, arr: &arr)
        }
    }
    
    addChild(parent: root, arr: &arr)
    
    return root
}

class BinaryNode<Element> {
    var value: Element
    var leftChild: BinaryNode?
    var rightChild: BinaryNode?
    init(value: Element) {
        self.value = value
    }
}

extension BinaryNode {
    func traversePreOrder(visit: (Element?) -> Void) {
        visit(value)
        if let leftChild = leftChild {
            leftChild.traversePreOrder(visit: visit)
        } else {
            visit(nil)
        }
        if let rightChild = rightChild {
            rightChild.traversePreOrder(visit: visit)
        } else {
            visit(nil)
        }
    }
    
    func traverseInOrder(visit: (Element?) -> Void) {
        if let leftChild = leftChild {
            leftChild.traverseInOrder(visit: visit)
        } else {
            visit(nil)
        }
        visit(value)
        if let rightChild = rightChild {
            rightChild.traverseInOrder(visit: visit)
        } else {
            visit(nil)
        }
    }
    
    func traversePostOrder(visit: (Element?) -> Void) {
        if let leftChild = leftChild {
            leftChild.traversePostOrder(visit: visit)
        } else {
            visit(nil)
        }
        if let rightChild = rightChild {
            rightChild.traversePostOrder(visit: visit)
        } else {
            visit(nil)
        }
        visit(value)
    }
}

extension BinaryNode: CustomStringConvertible {
    var description: String {
        return diagram(for: self)
    }
    
    private func diagram(for node: BinaryNode?,
                         _ top: String = "",
                         _ root: String  = "",
                         _ bottom: String = "") -> String {
        
        guard let node = node else {
            return root + "nil\n"
        }
        if node.leftChild == nil && node.rightChild == nil {
            // leaf node
            return root + "\(node.value)\n"
        }
        return diagram(for: node.rightChild,
                       top + " ",
                       top + "┌──",
                       top + "│ ") + root
            + "\(node.value)\n"
            + diagram(for: node.leftChild,
                      bottom + "│ ",
                      bottom + "└──",
                      bottom + " ")
    }
}
