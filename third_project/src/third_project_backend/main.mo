import List "mo:base/List";
import Trie "mo:base/Trie";
import Nat32 "mo:base/Nat32";
import Option "mo:base/Option";
import Text "mo:base/Text";

actor Superheroes {
  public type SuperheroID = Nat32;
  public type Superhero = {
    name : Text;
    superpowers : List.List<Text>;
  };

  private stable var next : SuperheroID = 0;
  private stable var superheroes : Trie.Trie<SuperheroID, Superhero> = Trie.empty();

  private func key(k : SuperheroID) : Trie.Key<SuperheroID>{
    { hash = k; key = k };
  };

  public func create(sh : Superhero) : async SuperheroID {
    let sid = next;
    next += 1;
    superheroes := Trie.replace(
      superheroes,
      key(sid),
      Nat32.equal,
      ?sh
    ).0;
    return sid;
  };

  public query func read(sid : SuperheroID) : async ?Superhero {
    let result = Trie.find(
      superheroes,
      key(sid),
      Nat32.equal
    );
    return result;
  };

  public func update(sid : SuperheroID, sh : Superhero) : async Bool {
    let result = ?read(sid);
    let exists = Option.isSome(result);
    if (exists) {
      superheroes := Trie.replace(
        superheroes,
        key(sid),
        Nat32.equal,
        ?sh
      ).0;
    };
    return exists;
  };

  public func delete(sid : SuperheroID) : async Bool {
    let result = ?read(sid);
    let exists = Option.isSome(result);
    if (exists) {
      superheroes := Trie.replace(
        superheroes,
        key(sid),
        Nat32.equal,
        null
      ).0;
    };
    return exists;
  };
};
