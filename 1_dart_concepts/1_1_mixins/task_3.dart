abstract class Item {}

mixin Weapon on Item {
  int get damage;
}

mixin Armor on Item {
  int get defense;
}

class Sword extends Item with Weapon {
  @override
  final int damage;
  Sword(this.damage);
}

class Shield extends Item with Armor {
  @override
  final int defense;
  Shield(this.defense);
}

class Helmet extends Item with Armor {
  @override
  final int defense;
  Helmet(this.defense);
}

class Chestplate extends Item with Armor {
  @override
  final int defense;
  Chestplate(this.defense);
}

class Pants extends Item with Armor {
  @override
  final int defense;
  Pants(this.defense);
}

class Boots extends Item with Armor {
  @override
  final int defense;
  Boots(this.defense);
}

class Character {
  Item? leftHand;
  Item? rightHand;
  Item? hat;
  Item? torso;
  Item? legs;
  Item? shoes;

  Iterable<Item> get equipped =>
      [leftHand, rightHand, hat, torso, legs, shoes].whereType<Item>();

  int get damage =>
      equipped.whereType<Weapon>().fold(0, (sum, w) => sum + w.damage);

  int get defense =>
      equipped.whereType<Armor>().fold(0, (sum, a) => sum + a.defense);

  void equip(Item item) {
    if (item is Weapon) {
      if (leftHand == null) {
        leftHand = item;
      } else if (rightHand == null) {
        rightHand = item;
      } else {
        throw OverflowException();
      }
    } else if (item is Helmet) {
      if (hat == null) hat = item; else throw OverflowException();
    } else if (item is Chestplate) {
      if (torso == null) torso = item; else throw OverflowException();
    } else if (item is Pants) {
      if (legs == null) legs = item; else throw OverflowException();
    } else if (item is Boots) {
      if (shoes == null) shoes = item; else throw OverflowException();
    } else {
      throw Exception('Unknown item type: ${item.runtimeType}');
    }
  }
}

class OverflowException implements Exception {
  @override
  String toString() => 'OverflowException: Slot already occupied';
}

void main() {
  final hero = Character();
  hero.equip(Sword(25));
  hero.equip(Shield(10));
  hero.equip(Helmet(5));
  hero.equip(Chestplate(15));
  hero.equip(Pants(10));
  hero.equip(Boots(8));

  print('Total damage: ${hero.damage}');
  print('Total defense: ${hero.defense}');
}
