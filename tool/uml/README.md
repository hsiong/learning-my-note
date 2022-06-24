
> tip: knowing how to use is enough.

- [Reference](#reference)
- [Overview](#overview)
  - [Object-Oriented Concepts](#object-oriented-concepts)
  - [Building Blocks](#building-blocks)
    - [Things](#things)
    - [Relationship](#relationship)
      - [Dependency](#dependency)
      - [Association](#association)
      - [Generalization](#generalization)
    - [UML Diagrams](#uml-diagrams)
      - [Stuctural Modeling](#stuctural-modeling)
      - [Behavioral Modeling](#behavioral-modeling)
      - [Architectural Modeling](#architectural-modeling)
      - [Additions in UML 2.0 –](#additions-in-uml-20-)
- [Basic Notations](#basic-notations)
  - [Structural Things](#structural-things)
    - [Class Notation](#class-notation)
    - [Object Notation](#object-notation)
    - [Interface Notation](#interface-notation)
    - [Collaboration Notation](#collaboration-notation)
    - [Use Case Notation](#use-case-notation)
    - [Actor Notation](#actor-notation)

# Reference
https://www.tutorialspoint.com/uml/uml_overview.htm  

https://www.geeksforgeeks.org/unified-modeling-language-uml-introduction/

# Overview
UML is a standard language for specifying, visualizing, constructing, and documenting the artifacts of software systems. 

> specifying<sup>详细说明</sup>

A picture is worth a thousand words.

## Object-Oriented Concepts
+ Objects − Objects represent an entity and the basic building block.

+ Class − Class is the blue print of an object.

+ Abstraction − Abstraction represents the behavior of an real world entity.
> Abstraction<sup>抽象</sup>

+ Encapsulation − Encapsulation is the mechanism of binding the data together and hiding them from the outside world.
> Encapsulation<sup>封装</sup>

+ Inheritance − Inheritance is the mechanism of making new classes from existing ones.

+ Polymorphism − It defines the mechanism to exists in different forms.

```OO Analysis → OO Design → OO implementation using OO languages```

The conceptual model of UML can be mastered by learning the following three major elements −

+ UML building blocks  
+ Rules to connect the building blocks  
+ Common mechanisms<sup>结构</sup> of UML  

## Building Blocks

The building blocks of UML can be defined as −

+ Things  
+ Relationships  
+ Diagrams

### Things
Things are the most important building blocks of UML. Things can be −

+ Structural  
+ Behavioral  
+ Grouping  
+ Annotational  

### Relationship
Relationship shows how the elements are associated with each other and this association describes the functionality of an application.  
There are four kinds of relationships available.

#### Dependency
Dependency is a relationship between two things in which change in one element also affects the other.
![](https://www.tutorialspoint.com/uml/images/uml_dependency.jpg)

#### Association
Association is basically a set of links that connects the elements of a UML model. It also describes how many objects are taking part in that relationship.
![](https://www.tutorialspoint.com/uml/images/uml_association.jpg)

#### Generalization
Generalization basically describes the inheritance relationship in the world of objects.

> Generalization<sup>泛化</sup>
> inheritance<sup>继承</sup>

### UML Diagrams

#### Stuctural Modeling

Structural model represents the framework for the system and this framework is the place where all other components exist. They all represent the elements and the mechanism to assemble them.  
> Hence <sup>因此</sup>
> machanism <sup>机制</sup>
> assemble <sup>v.组合</sup>

+ Classes diagrams
+ Objects diagrams
+ Deployment diagrams
+ Package diagrams
+ Composite structure diagram
+ Component diagram

> Composite <sup>组合</sup>

#### Behavioral Modeling
Behavioral model describes the interaction in the system. It represents the interaction among the structural diagrams.
+ Activity diagrams
+ Interaction diagrams
+ Use case diagrams

#### Architectural Modeling
Architectural model represents the overall framework of the system. It contains both structural and behavioral elements of the system. ***Package diagram*** comes under architectural modeling.

> architectrual <sup>adj. 建筑的</sup>

#### Additions in UML 2.0 –
Software development methodologies like agile have been incorporated and scope of original UML specification has been broadened.  
Originally UML specified 9 diagrams. UML 2.x has increased the number of diagrams from 9 to 13. The four diagrams that were added are : timing diagram, communication diagram, interaction overview diagram and composite structure diagram. UML 2.x renamed statechart diagrams to state machine diagrams.  
UML 2.x added the ability to decompose software system into components and sub-components.

# Basic Notations
UML is popular for its diagrammatic notations. We all kown that UML is for visualizing, specifying, constructing and documenting the components of software and non-software systems.

> specify <sup>v. 详细说明</sup>
> notation <sup>n. 记号; 注解</sup>

UML notations are the most important elements in modeling. Efficient and appropiate use of notations is very important for making a complete and meaningful model.

Different notations are available for things and relationships. UML diagrams are made using the notations of things and relationships.

## Structural Things
Structural things represent the physical and conceptual elements
+ Classes
+ Object
+ Interface
+ Collaboration
+ Use case
+ Active classes
+ Components
+ Nodes

### Class Notation
UML class is represented by the following figure.
+ The top section is used to ***name the class***
+ The second one is used to show the ***attributes*** of the class
+ the third section is used to ***describe the operations*** performed by the class
+ the fourth section is optional to ***show any additional components***.
![](https://www.tutorialspoint.com/uml/images/notation_class.jpg)

Classes are used to represent objects. Objects can be anything having properties and responsibility.

### Object Notation
The object is represented in the same way as the class. The only difference is ***the name which is underlined*** as shown in the following figure.
![](https://www.tutorialspoint.com/uml/images/notation_object.jpg)

### Interface Notation
Interface is represented by a ***circle*** as shown in the following figure. It has a name which is generally written below the circle.
![](https://www.tutorialspoint.com/uml/images/notation_interface.jpg)

Interface is used to describe the functionality without implementation. When a class implements the interface, it also implements the functionality as per requirement.

### Collaboration Notation
Collaboration is represented by a dotted eclipse as shown in the following figure. It has a name written inside the eclipse.

> collaboration <sup>n. 协作</sup>
> dot <sup>n. 点; 虚线</sup>
> eclipse <sup>n. 日蚀; 此处引申环状</sup>
> clarification <sup>n. 说明</sup>

![](https://www.tutorialspoint.com/uml/images/notation_collaboration.jpg)

Collaboration represents responsibilities. Generally, responsibilities are in a group.


### Use Case Notation
Use case is represented as an eclipse with a name inside it. It may contain additional responsibilities.
![](https://www.tutorialspoint.com/uml/images/notation_usecase.jpg)

Use case is used to capture high level functionalities of a system.

### Actor Notation
An actor can be defined as some internal entity that interacts with the system.

> actor <sup>n. 角色</sup>

![](https://www.tutorialspoint.com/uml/images/notation_actor.jpg)

An actor is used in a use case diagram to describe the internal or external entities.

