// This is inline comment

/* This
is
block
comment */

/* // Importing some libraries
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";
import Debug "mo:base/Debug";

//actor is cannister (smart contract)
actor {
  //variables
  // let -> immutable
  // var -> mutable

  let name : Text = "Burak";
  let surname : Text = "Ayvall";

  Debug.print(debug_show (name));
  Debug.print(debug_show (surname));
};
 */


import Map "mo:base/HashMap";
import Text "mo:base/Text";

//motoko is a type language
//actor is cannister (smart contract)
actor {

  type Name = Text;
  type Phone = Text;

  type Entry = {
    desc: Text;
    phone: Phone;
  };

  //variables
  // let => immutable and var => mutable

  let phonebook = Map.HashMap<Name, Entry>(0, Text.equal, Text.hash);

  //functions
  // query
  // update
  public func insert(name : Name, entry : Entry): async () {
    phonebook.put(name, entry);
  };

  public query func lookup(name : Name) : async ?Entry {
    phonebook.get(name)
  };
};
