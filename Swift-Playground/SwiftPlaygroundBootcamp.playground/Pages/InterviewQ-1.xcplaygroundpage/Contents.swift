import SwiftUI
import Foundation
/*
 {
     "post_id": 1,
     "id": 1,
     "name": "id labore ex et quam laborum",
     "email": "Eliseo@gardner.biz",
     "body": "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium"
   }
*/

// MARK: - Model
struct Post: Decodable, Identifiable {
    let post_id: Int
    let id: Int
    let name, email, body: String

    enum CodingKeys: String, CodingKey {
        case post_id
        case id
        case name
        case email
        case body
    }
}

// MARK: - Post View
struct PostView: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Name: \(post.name)")
            Text("Email: \(post.email)")
            Text("Body: \(post.body)")
        }
        .padding()
    }
}

// MARK: - Dummy Data
let dummyPosts: [Post] = [
    Post(post_id: 1, id: 1, name: "John Doe", email: "john@example.com", body: "This is a test comment."),
    Post(post_id: 1, id: 2, name: "Jane Smith", email: "jane@example.com", body: "Another test comment.")
]

// MARK: - List View
struct ContentView: View {
    var body: some View {
        List(dummyPosts) { post in
            PostView(post: post)
        }
    }
}

// MARK: - App Entry Point
/*@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}*/

/*
 Given array - [1, 3, 6, 2, nil, 7, 2, nil, 9, 11]
  Even number should replace with +1 and odd should replace with -1 Nil, should also replace with -1
 Expected output - [-1, -1, +1, +1, -1, -1, +1, -1, -1, -1]
*/

let n = [1, 3, 6, 2, nil, 7, 2, nil, 9, 11]
let replaceNum = n.map { n in
    guard let num = n else{
        return -1 /// nil handling
    }
    return num % 2 == 0 ? 1 : -1
}
print(replaceNum)


// MARK: - HungerBox
/*
 1->2->3->4->5 K=1

 2->1->4->3->5 K=2

 3->2->1->4->5 k=3

 4->3->2->1->5 k=4
 Definition for singly-linked list.
 and reversed it.
*/

/*
 Approach:
 1. First, check if there are at least 'k' nodes remaining in the linked list.
    - Initialize count = 0 and currentNode = head
    - Traverse the list while currentNode != nil and count < k
    - If count < k at the end, there aren't enough nodes to reverse — return head as-is

 2. If there are at least k nodes:
    - Reverse the first k nodes using the standard iterative reversal
    - After reversing, recursively call the same function for the remaining nodes
    - Connect the end of the reversed group to the result of the recursive call

 3. Return the new head of the reversed group
*/

class ListNode {
    var val: Int
    var nextNode: ListNode?
    
    init(val: Int, nextNode: ListNode? = nil) {
        self.val = val
        self.nextNode = nextNode
    }
}

/// Helper function to print the linked list
func printList(_ head: ListNode?) {
    var current = head
    while current != nil {
        print(current!.val, terminator: current?.nextNode == nil ? "\n" : " → ")
        current = current?.nextNode
    }
}

class Solution {
    func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
        /// Step 1: Check if we have at least k nodes
        var count = 0
        var current = head
        while current != nil && count < k {
            current = current?.nextNode
            count += 1
        }
        
        /// If less than k nodes, return head as-is
        if count < k {
            return head
        }
        
       /// Step 2: Reverse k nodes
        var prev: ListNode? = nil
        var curr = head
        var next: ListNode? = nil
        count = 0
        while curr != nil && count < k {
            next = curr?.nextNode
            curr?.nextNode = prev
            prev = curr
            curr = next
            count += 1
        }
        
        /// Step 3: Recursive call for the rest of the list
        head?.nextNode = reverseKGroup(curr, k)
        
        return prev /// New head after reversal
    }
}


let node5 = ListNode(val: 5)
let node4 = ListNode(val: 4, nextNode: node5)
let node3 = ListNode(val: 3, nextNode: node4)
let node2 = ListNode(val: 2, nextNode: node3)
let node1 = ListNode(val: 1, nextNode: node2)

let solution = Solution()
print("Original List:")
printList(node1)

let k = 2
let result = solution.reverseKGroup(node1, k)

print("Reversed in groups of \(k):")
printList(result)
