import Foundation

// MARK: - Struct
/// Struct is fast compared to Class
/// Struct are stored in the Stack type (memory)
/// Struct Objects are Value types.
/// Value types are copied and mutated
/// Structs are Value Types: When assigned or passed, they are copied.

// MARK: Important Concepts
/// Case 1: To modify a mutable struct's property from outside the struct, use a `var` property (see UserModel2 example).
/// Case 2: To modify a struct’s property from within the struct, use either:
/// - A method that returns a new instance with updated values (immutable approach, as in UserModel3).
/// - A `mutating` method that modifies the property directly (as in UserModel4).


/// Imutable Struct :- (Reassign Entire Object)
/// Object can't be changed in here.
struct UserModel1{
    let name: String
    let isPremium: Bool
    
    /// Struct have an Implcit Init but
    /// If you want to modify the struct object then you can add custom init.
    
    /*init(name: String, isPremium: Bool = false) {
        self.name = name
        self.isPremium = isPremium
    }*/
    
    /// Custom initializer that handles optional `isPremium`
    init(name: String, isPremium: Bool?) {
        self.name = name
        self.isPremium = isPremium ?? false /// Here isPremium set be Optional and value is nil and it's default value is false.
    }
}

var user1 = UserModel1(name: "Soumya", isPremium: nil)

/// If you want to modify the Imuatble Struct then
func markUser1Premium(){
    print("Before:", user1)
    
    /// Reassigning a new instance to update values
    user1 = UserModel1(name: "Soumya", isPremium: true)
    print("After:", user1)
}
// markUser1Premium()

/// ---------------------------------------------------------------------------------------------------------
/// -----------------------------------

/// Mutable Struct :- (Direct Property Mutation)
/// Object should be mutated here.
/// Case 1:  if you want to modify the mutable struct object  value outside of the struct then you can modify it like UserModel2 example
struct Usermodel2{
    let name: String
    var isPremium: Bool
}

var user2 = Usermodel2(name: "Nick", isPremium: false)

func markUser2Premium(){
    print("Before:", user2)
    /// Mutating the property directly since it's a var
    user2.isPremium = true /// Here isPremium value is changed because of object mutated
    print("After:", user2)
}
// markUser2Premium()

/// ---------------------------------------------------------------------------------------------------------
/// -----------------------------------

///  Imutable Struct :- with Functional Update (Recommended Immutable Pattern)
///  Here value could be changed in easy and prefrable way (Best way to modify the Immutable struct object)
struct UserModel3{
    let name: String
    let isPremium: Bool
    
    /// Returns a new instance with updated `isPremium`
    func markUserPremium(newVal: Bool) -> UserModel3{
        UserModel3(name: name, isPremium: newVal)
    }
}

var user3 = UserModel3(name: "Steve", isPremium: false)
user3 = user3.markUserPremium(newVal: true)
// print(user3) /// Best way to update immutable struct

/// ---------------------------------------------------------------------------------------------------------
/// -----------------------------------

/// Mutable Struct :- Mutable Struct Using `mutating` Keyword
/// Other way to modify the struct object using mutating keywaord
struct UserModel4{
    let name: String
    private(set) var isPremium: Bool
    
    /// Mutating method to set `isPremium` to true
    mutating func markUserPremium(){
        isPremium = true
    }
    
    /// Mutating method to set `isPremium` to a specific value
    mutating func updateUserPremium(newval: Bool){
        isPremium = newval
    }
}
var user4 = UserModel4(name: "Rick", isPremium: false)
user4.markUserPremium()
user4.updateUserPremium(newval: true)

/// Accessing the value (read-only), as the setter is private
print(user4.isPremium) /// Here only value can be get not set the value
