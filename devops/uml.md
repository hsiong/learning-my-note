
- [Before you start](#before-you-start)
- [Things](#things)
  - [Structural things](#structural-things)
    - [Class](#class)
    - [Object](#object)
    - [Interface](#interface)
    - [Collaboration](#collaboration)
    - [Use case](#use-case)
    - [Actor](#actor)
    - [Component](#component)
    - [Node](#node)
  - [Behavioral Things](#behavioral-things)
    - [Interaction](#interaction)
    - [State machine](#state-machine)
  - [Grouping Things](#grouping-things)
    - [Package](#package)
  - [Annotational Things](#annotational-things)
    - [Note](#note)
- [Relationship](#relationship)
  - [Dependency](#dependency)
  - [Association](#association)
  - [Generalization](#generalization)
  - [Realization](#realization)
  - [Aggregation](#aggregation)
- [What is UML Diagram?](#what-is-uml-diagram)
  - [Structural diagrams in UML](#structural-diagrams-in-uml)
  - [Behavioral diagrams in UML](#behavioral-diagrams-in-uml)
  - [Interaction diagrams in UML](#interaction-diagrams-in-uml)

# Before you start

***Reference***
+ https://www.visual-paradigm.com/guide/uml-unified-modeling-language/uml-class-diagram-tutorial/
+ https://www.tutorialspoint.com/uml/uml_building_blocks.htm
+ https://www.guru99.com/uml-tutorial.html

Following object-oriented concepts are required to begin with UML:

+ Object: It is a real-world entity. There are multiple objects available within a single system. It is a fundamental building block of UML.
+ Class: A class is nothing but a container where objects and their relationships are maintained.
+ Abstraction: It is a mechanism of representing an entity without showing the implementation details. It is used to visualize the behavior of an object.
+ Inheritance: It is a mechanism of extending an existing class to create a new class.
+ Polymorphism: It is a mechanism of representing an object having multiple forms which are used for different purposes.
+ Encapsulation: It is a method of binding the object and the data together as a single unit. It ensures tight coupling between the object and the data.

# Things
Things are the most important building blocks of UML. Things can be −

+ Structural
+ Behavioral
+ Grouping
+ Annotational

## Structural things 
Structural things define the static part of the model. They represent the physical and conceptual elements. Following are the brief descriptions of the structural things: 

### Class

Class represents a set of objects having similar responsibilities.

![class](https://www.guru99.com/images/1/041519_1219_UMLNotation1.png)

### Object

An object is an entity which is used to describe the behavior and functions of a system. The class and object have the same notations. The only difference is that an object name is always underlined in UML.

The UML notation of any object is given below.

![1234](https://www.guru99.com/images/1/041519_1219_UMLNotation2.png)


### Interface

Interface defines a set of operations, which specify the responsibility of a class.

![Interface](https://www.tutorialspoint.com/uml/images/uml_interface.jpg)



### Collaboration

Collaboration defines an interaction between elements.

![Collaboration](https://www.guru99.com/images/1/041519_1219_UMLNotation4.png)

### Use case

Use case represents a set of actions performed by a system for a specific goal.

![Use case](https://www.tutorialspoint.com/uml/images/uml_usecase.jpg)

### Actor
It is used inside use case diagrams. The Actor notation is used to denote an entity that interacts with the system. A user is the best example of an actor. The actor notation in UML is given below.  
![1234](https://www.guru99.com/images/1/041519_1219_UMLNotation6.png)


### Component

Component describes the physical part of a system.

![Component](https://www.tutorialspoint.com/uml/images/uml_component.jpg)

### Node 

A node can be defined as a physical element that exists at run time.

![Node](https://www.tutorialspoint.com/uml/images/uml_node.jpg)



## Behavioral Things

A behavioral thing consists of the dynamic parts of UML models. Following are the behavioral things: 



### Interaction  

Interaction is defined as a behavior that consists of a group of messages exchanged among elements to accomplish a specific task.

![Interaction](https://www.tutorialspoint.com/uml/images/uml_message.jpg)

### State machine 

State machine is useful when the state of an object in its life cycle is important. It defines the sequence of states an object goes through in response to events. Events are external factors responsible for state change

![State machine](https://www.guru99.com/images/1/041519_1219_UMLNotation10.png)



## Grouping Things

Grouping things can be defined as a mechanism to group elements of a UML model together. There is only one grouping thing available −

### Package  

Package is the only one grouping thing available for gathering structural and behavioral things.

![Package](https://www.tutorialspoint.com/uml/images/uml_package.jpg)

## Annotational Things

Annotational things can be defined as a mechanism to capture remarks, descriptions, and comments of UML model elements.

### Note  

It is the only one Annotational thing available. A note is used to render comments, constraints, etc. of an UML element.

![Note](https://www.tutorialspoint.com/uml/images/uml_note.jpg)



# Relationship

Relationship is another most important building block of UML. It shows how the elements are associated with each other and this association describes the functionality of an application.

There are four kinds of relationships available: 

## Dependency

Dependency is a relationship between two things in which change in one element also affects the other.

![Dependency](https://www.tutorialspoint.com/uml/images/uml_dependency.jpg)

## Association

Association is basically a set of links that connects the elements of a UML model. It also describes how many objects are taking part in that relationship.

![Association](https://www.guru99.com/images/1/041519_1219_UMLNotation15.png)   


## Generalization

Generalization can be defined as a relationship which connects a specialized element with a generalized element. It basically describes the inheritance relationship in the world of objects.

![Generalization](https://www.tutorialspoint.com/uml/images/uml_generalization.jpg)



## Realization

Realization can be defined as a relationship in which two elements are connected. One element describes some responsibility, which is not implemented and the other one implements them. This relationship exists in case of interfaces.

![Realization](https://www.tutorialspoint.com/uml/images/uml_realization.jpg)

## Aggregation






# What is UML Diagram?

![1234](https://upload.wikimedia.org/wikipedia/commons/e/ed/UML_diagrams_overview.svg)
UML diagrams are divided into three different categories such as,

+ Structural diagram
+ Behavioral diagram
+ Interaction diagram

## Structural diagrams in UML
Structural diagrams are used to represent a static view of a system. It represents a part of a system that makes up the structure of a system. A structural diagram shows various objects within the system.

Following are the various structural diagrams in UML:

+ Class diagram
+ Object diagram
+ Package diagram
+ Component diagram
+ Deployment diagram
+ Composite structure diagram

## Behavioral diagrams in UML
Any real-world system can be represented in either a static form or a dynamic form. A system is said to be complete if it is expressed in both the static and dynamic ways. The behavioral diagram represents the functioning of a system.

UML diagrams that deals with the static part of a system are called structural diagrams. UML diagrams that deals with the moving or dynamic parts of the system are called behavioral diagrams.

Following are the various behavioral diagrams in UML:

+ Activity diagram
+ Use case diagram
+ State machine diagram

## Interaction diagrams in UML
Interaction diagram is nothing but a subset of behavioral diagrams. It is used to visualize the flow between various use case elements of a system. Interaction diagrams are used to show an interaction between two entities and how data flows within them.

Following are the various interaction diagrams in UML:

+ Timing diagram
+ Sequence diagram
+ Collaboration diagram