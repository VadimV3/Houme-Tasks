void main() {
  final Zoo zoo = Zoo();
  zoo.addAnimal(Lion(5, 'Simba', true));
  zoo.addAnimal(Eagle(3, 'Yoshi', 180));
  zoo.addAnimal(Snake(2, 'Kaa', true));
  zoo.addAnimal(Lizard(1, 'Lizzy', false));
  zoo.addAnimal(Shark(6, 'Bruce', true));
  zoo.addAnimal(Butterfly(1, 'Flappy'));
  zoo.addAnimal(Snail(3, 'Gary'));
  zoo.addAnimal(Spider(2, 'Charlotte'));

  zoo.showAnimals();
  zoo.makeSoundAnimals();
  zoo.feedAnimals();
}

abstract class Animal {
  String name;
  int age;
  String species;

  Animal(this.age, this.name, this.species);
  void makeSound();
}

abstract class Vertebrate extends Animal {
  Vertebrate(super.age, super.name, super.species);
}

abstract class Invertebrate extends Animal {
  Invertebrate(super.age, super.name, super.species);
}

abstract class Mammal extends Vertebrate {
  bool hasFur;
  Mammal(super.age, super.name, super.species, this.hasFur);
}

class Lion extends Mammal {
  Lion(int age, String name, bool hasFur) : super(age, name, 'Lion', hasFur);
  @override
  void makeSound() {
    print('Lion roar');
  }
}

abstract class Bird extends Vertebrate {
  int wingSpan;
  Bird(super.age, super.name, super.species, this.wingSpan);
}

class Eagle extends Bird {
  Eagle(int age, String name, int wingSpan) : super(age, name, 'Eagle', wingSpan);
  @override
  void makeSound() {
    print('Eagle Screem');
  }
}

abstract class Reptile extends Vertebrate {
  bool isVenom;
  Reptile(super.age, super.name, super.species, this.isVenom);
}

class Snake extends Reptile {
  Snake(int age, String name, bool isVenom) : super(age, name, 'Crocedile', isVenom);
  @override
  void makeSound() {
    print('Snake shhhhhhhhh');
  }
}

abstract class Amphibian extends Vertebrate {
  bool inWater;
  Amphibian(super.age, super.name, super.species, this.inWater);
}

class Lizard extends Amphibian {
  Lizard(int age, String name, bool inWater) : super(age, name, 'Lizard', inWater);

  @override
  void makeSound() {
    print('Lizzard screem');
  }
}

abstract class Fish extends Vertebrate {
  bool inSaltWater;
  Fish(super.age, super.name, super.species, this.inSaltWater);
}

class Shark extends Fish {
  Shark(int age, String name, bool inSaltWater) : super(age, name, 'Shark', inSaltWater);

  @override
  void makeSound() {
    print('Shark sound');
  }
}

abstract class Insect extends Invertebrate {
  int wingsCount;
  Insect(super.age, super.name, super.species, this.wingsCount);
}

class Butterfly extends Insect {
  Butterfly(int age, String name) : super(age, name, 'Butterfly', 4);

  @override
  void makeSound() {
    print('$name (Butterfly): Flutter flutter');
  }
}

abstract class Mollusk extends Invertebrate {
  bool hasShall;
  Mollusk(super.age, super.name, super.species, this.hasShall);
}

class Snail extends Mollusk {
  Snail(int age, String name) : super(age, name, 'Snail', true);

  @override
  void makeSound() {
    print('$name (Snail): ...slow slither...');
  }
}

abstract class Arthropod extends Invertebrate {
  int legCount;
  Arthropod(super.age, super.name, super.species, this.legCount);
}

class Spider extends Arthropod {
  Spider(int age, String name) : super(age, name, 'Spider', 8);

  @override
  void makeSound() {
    print('$name (Spider): Skitter skitter...');
  }
}

class Zoo {
  List<Animal> _animals = [];

  void addAnimal(Animal animal) {
    _animals.add(animal);
  }

  void showAnimals() {
    for (var animal in _animals) {
      print('Animal name is ${animal.name}, age: ${animal.age}, species: ${animal.species}');
    }
  }

  void feedAnimals() {
    for (Animal animal in _animals) {
      print('You feed ${animal.species}, animal name is ${animal.name}');
    }
  }

  void makeSoundAnimals() {
    for (Animal animal in _animals) {
      animal.makeSound();
    }
  }
}
