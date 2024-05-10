import Map "mo:base/HashMap";
import Hash "mo:base/Hash";
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";
import Text "mo:base/Text";

actor Assistant { 
  type TODO = {
    description : Text;
    completed : Bool;
  };

  //defination of hash function of natural numbers
  func natHash(n : Nat) : Hash.Hash {
    Text.hash(Nat.toText(n));
  };
  
  //HashMap needs a hash function and a equality function
  var todos = Map.HashMap<Nat, TODO>(0, Nat.equal, natHash);
  var nextID : Nat = 0;

  //a query function to get TODO list
  public query func getTODOs() : async [TODO] {
    Iter.toArray(todos.vals());
  };

  //an update function to insert values into TODO list
  public func addTODO(desc : Text) : async Nat {
    let id = nextID;
    todos.put(id, {description = desc; completed = false});
    nextID += 1;
    return id;
  };

  //an update function to change the status of a todo when it's completed
  public func completeTODO(id : Nat) : async () {
    ignore do ? {
      let desc = todos.get(id)!.description;
      todos.put(id, {description = desc; completed = true});
    };
  };

  //an query function to show TODO list with status
  public query func showTODOs() : async Text {
    var output : Text = "\n___________TODOs___________";
    for (todo : TODO in todos.vals()){
      output #= "\n" # todo.description; 
      if (todo.completed) {
        output #= " +";
      };
    };
    output # " \n";
  };

  //a function to clear completed list
  public func clearCompletedTODOs() : async () {
    todos := Map.mapFilter<Nat, TODO, TODO>(todos, Nat.equal, natHash, func(_, todo){ if (todo.completed) null else ?todo})
  };
};
