- [Before you start](#before-you-start)
- [Things](#things)
  - [Structural things & Notation](#structural-things--notation)
    - [Class](#class)
      - [Active Class Notation](#active-class-notation)
    - [Object](#object)
    - [Interface](#interface)
    - [Collaboration](#collaboration)
    - [Use case](#use-case)
    - [Actor](#actor)
    - [Initial State Notation](#initial-state-notation)
    - [Final State Notation](#final-state-notation)
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
  - [Association](#association)
    - [Aggregation](#aggregation)
      - [Composition](#composition)
  - [Inheritance(or Generalization)](#inheritanceor-generalization)
  - [Realization](#realization)
  - [Dependency](#dependency)
- [What is UML Diagram?](#what-is-uml-diagram)
  - [Structural diagrams in UML](#structural-diagrams-in-uml)
    - [Class diagram](#class-diagram)
      - [How to Draw a Class Diagram?](#how-to-draw-a-class-diagram)
    - [Object Diagram](#object-diagram)
      - [How to Draw an Object Diagram?](#how-to-draw-an-object-diagram)
  - [Behavioral diagrams in UML](#behavioral-diagrams-in-uml)
  - [Interaction diagrams in UML](#interaction-diagrams-in-uml)

# Before you start

***Reference***
+ https://www.visual-paradigm.com/guide/uml-unified-modeling-language/uml-class-diagram-tutorial/
+ https://www.tutorialspoint.com/uml/uml_building_blocks.htm
+ https://www.guru99.com/uml-tutorial.html
+ https://www.softwaretestinghelp.com/uml-diagram-tutorial/



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

## Structural things & Notation
Structural things define the static part of the model. They represent the physical and conceptual elements. Following are the brief descriptions of the structural things: 

### Class

A class represent a concept which encapsulates state (**attributes**) and behavior (**operations**). Each attribute has a type. Each **operation** has a **signature**. *The class name is the **only mandatory information***.

![image](https://user-images.githubusercontent.com/37357447/189065154-2998486e-8a09-4a2c-898f-af458c22718c.png)



**Class Name:**

- The name of the class appears in the first partition.

**Class Attributes:**

- Attributes are shown in the second partition.
- The attribute type is shown after the colon.
- Attributes map onto member variables (data members) in code.

**Class Operations (Methods):**

- Operations are shown in the third partition. They are services the class provides.
- The return type of a method is shown after the colon at the end of the method signature.
- The return type of method parameters are shown after the colon following the parameter name. Operations map onto class methods in code.



![image](https://user-images.githubusercontent.com/37357447/189064978-1849db8f-b407-4f78-8f7f-59d23ac57997.png)



**Class Visibility**:

The +, - and # symbols before an attribute and operation name in a class denote the visibility of the attribute and operation.

- \+ denotes public attributes or operations
- \- denotes private attributes or operations
- \# denotes protected attributes or operations

![image](https://user-images.githubusercontent.com/37357447/189064885-c848eac8-e537-4ee2-8217-8ec43d38bd98.png)

**Parameter Directionality**

Each parameter in an operation (method) may be denoted as in, **out** or **inout** which specifies its direction with respect to the caller. This directionality is shown before the parameter name.

![image](https://user-images.githubusercontent.com/37357447/189064812-27ca42ba-1eaf-4b14-995a-f88f39ee5a30.png)



![image](https://user-images.githubusercontent.com/37357447/189064750-c5997116-6623-40a4-8f7a-9e24545a6fdc.png)



#### Active Class Notation

Active class looks similar to a class with a solid border. Active class is generally used to describe the concurrent behavior of a system.

![image](https://user-images.githubusercontent.com/37357447/189064550-e715a3f5-f66a-4bd2-917b-097c174ff9f4.png)

Active class is used to represent the concurrency in a system.



### Object

The *object* is represented in the same way as the class. The only difference is the *name* which is underlined as shown in the following figure.

![image](https://user-images.githubusercontent.com/37357447/189063705-ae7c9f8d-f5b3-4253-9d15-5de5973bd84d.png)

As the object is an actual implementation of a class, which is known as the instance of a class. Hence, it has the same usage as the class.


### Interface

Interface is represented by a circle as shown in the following figure. It has a name which is generally written below the circle.

![image](https://user-images.githubusercontent.com/37357447/189063926-8e76ddc9-1532-4147-8743-4c3b22db40a3.png)

Interface is used to describe the functionality without implementation. Interface is just like a template where you define different functions, not the implementation. When a class implements the interface, it also implements the functionality as per requirement.

### Collaboration

Collaboration is represented by a dotted eclipse as shown in the following figure. It has a name written inside the eclipse.

![image](https://user-images.githubusercontent.com/37357447/189063848-72662cd8-7cb2-4cee-af20-a1903377fed2.png)

Collaboration represents responsibilities. Generally, responsibilities are in a group.

### Use case

Use case is represented as an eclipse with a name inside it. It may contain additional responsibilities.

![image](https://user-images.githubusercontent.com/37357447/189063985-a24e8634-7e5a-426e-8af4-0f842d80c4be.png)

Use case is used to capture high level functionalities of a system.

### Actor

An actor can be defined as some internal or external entity that interacts with the system.

![image](https://user-images.githubusercontent.com/37357447/189064329-47e38785-e407-459a-b380-5a4818136a69.png)

An actor is used in a use case diagram to describe the internal or external entities.

### Initial State Notation

Initial state is defined to show the start of a process. This notation is used in almost all diagrams.

![image](https://user-images.githubusercontent.com/37357447/189064385-5b9d4e00-6bb8-4f72-acb8-d32d510d3634.png)

The usage of Initial State Notation is to show the starting point of a process.

### Final State Notation

Final state is used to show the end of a process. This notation is also used in almost all diagrams to describe the end.

![image](https://user-images.githubusercontent.com/37357447/189064484-34c5f13f-98bb-44f8-80cb-3394c46780c0.png)

The usage of Final State Notation is to show the termination point of a process.

### Component

A component in UML is shown in the following figure with a name inside. Additional elements can be added wherever required.

![image](https://user-images.githubusercontent.com/37357447/189065286-c841d90a-6889-4200-8418-77f962146646.png)

Component is used to represent any part of a system for which UML diagrams are made.

### Node 

A node in UML is represented by a square box as shown in the following figure with a name. A node represents the physical component of the system.

![image](https://user-images.githubusercontent.com/37357447/189065323-49edfde4-d64a-4ebc-ab55-54a04b3ca8cb.png)

Node is used to represent the physical part of a system such as the server, network, etc.

## Behavioral Things

A behavioral thing consists of the dynamic parts of UML models. Following are the behavioral things: 



### Interaction  

Interaction is basically a message exchange between two UML components. The following diagram represents different notations used in an interaction.

![image](https://user-images.githubusercontent.com/37357447/189066892-92acae6a-ad99-4bbd-8354-902f923e596a.png)

Interaction is used to represent the communication among the components of a system.



### State machine 

State machine describes the different states of a component in its life cycle. The notations are described in the following diagram.

![image](https://user-images.githubusercontent.com/37357447/189067489-3450711d-dd66-4a90-b56b-4a388867659b.png)

State machine is used to describe different states of a system component. The state can be active, idle, or any other depending upon the situation.

## Grouping Things

Grouping things can be defined as a mechanism to group elements of a UML model together. There is only one grouping thing available −

### Package  

Package notation is shown in the following figure and is used to wrap the components of a system.

![image](https://user-images.githubusercontent.com/37357447/189069805-cb8713de-60a4-4ddb-a317-5c6187de41aa.png)



## Annotational Things

Annotational things can be defined as a mechanism to capture remarks, descriptions, and comments of UML model elements.

### Note  

This notation is shown in the following figure. These notations are used to provide necessary information of a system.

![image](https://user-images.githubusercontent.com/37357447/189071203-f211a830-8833-4e9b-b6c6-736c6524fff3.png)



# Relationship

Relationship is another most important building block of UML. It shows how the elements are associated with each other and this association describes the functionality of an application.

There are six kinds of relationships available: 

![image](https://user-images.githubusercontent.com/37357447/189287006-99f6d5bd-c575-4c4b-b3d8-caea4c0a5e24.png)

## Association

Association describes how the elements in a UML diagram are associated. In simple words, it describes how many elements are taking part in an interaction.

Association is represented by a dotted line with (without) arrows on both sides. The two ends represent two associated elements as shown in the following figure. The multiplicity is also mentioned at the ends (1, *, etc.) to show how many objects are associated.

![image](https://user-images.githubusercontent.com/37357447/189287811-19a21df2-115a-48fe-a455-534e4dc5587f.png)

Association is used to represent the relationship between two elements of a system.

### Aggregation

A special type of association.

- It represents a "part of" relationship.
- Class2 is part of Class1.
- Many instances (denoted by the *) of Class2 can be associated with Class1.
- Objects of Class1 and Class2 have separate lifetimes.

The figure below shows an example of aggregation. The relationship is displayed as a solid line with a unfilled diamond at the association end, which is connected to the class that represents the aggregate.

![image](https://user-images.githubusercontent.com/37357447/189286964-e2806fca-fdbc-4e2f-b772-054335376137.png)

#### Composition

- A special type of aggregation where parts are destroyed when the whole is destroyed.
- Objects of Class2 live and die with Class1.
- Class2 cannot stand by itself.

The figure below shows an example of composition. The relationship is displayed as a solid line with a filled diamond at the association end, which is connected to the class that represents the whole or composite.

![Composition](https://cdn-images.visual-paradigm.com/guide/uml/uml-class-diagram-tutorial/13-composition.png)





## Inheritance(or Generalization)

Generalization describes the inheritance relationship of the object-oriented world. It is a parent and child relationship.

Generalization is represented by an arrow with a hollow arrow head as shown in the following figure. One end represents the parent element and the other end represents the child element.

![image](https://user-images.githubusercontent.com/37357447/189072392-9fcf8553-8174-4079-9e37-62cc9e442e74.png)

Generalization is used to describe parent-child relationship of two elements of a system.



## Realization

Realization can be defined as a relationship in which two elements are connected. One element describes some responsibility, which is not implemented and the other one implements them. This relationship exists in case of interfaces.

![image](https://user-images.githubusercontent.com/37357447/189072793-2dccf621-d640-4ca8-9f4f-818b542966c6.png)

## Dependency

Dependency is an important aspect in UML elements. It describes the dependent elements and the direction of dependency.

Dependency is represented by a dotted arrow as shown in the following figure. The arrow head represents the independent element and the other end represents the dependent element.

![image](https://user-images.githubusercontent.com/37357447/189072103-b23fb680-3e79-4e78-91bf-4098f40eb12f.png)

Dependency is used to represent the dependency between two elements of a systemAssociation

Association is basically a set of links that connects the elements of a UML model. It also describes how many objects are taking part in that relationship. 








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



### Class diagram

Class diagrams are the most common diagrams used in UML. Class diagram consists of classes, interfaces, associations, and collaboration. Class diagrams basically represent the object-oriented view of a system, which is static in nature.

Active class is used in a class diagram to represent the concurrency of the system.

Class diagram represents the object orientation of a system. Hence, it is generally used for development purpose. This is the most widely used diagram at the time of system construction.



+ Example: Order System

![image](https://user-images.githubusercontent.com/37357447/189074935-05cf66fb-3c40-427a-be9e-c00cad0c7457.png)



+ Example: GUI

![image](https://user-images.githubusercontent.com/37357447/189075395-abfdc446-0a34-400b-883d-17d35a4439c5.png)



#### How to Draw a Class Diagram?

Class diagrams are the most popular UML diagrams used for construction of software applications. 

Class diagram is basically a graphical representation of the static view of the system and represents different aspects of the application. A collection of class diagrams represent the whole system.

The following points should be remembered while drawing a class diagram −

- The ***name*** of the class diagram should be meaningful to describe the aspect of the system.
- Each element and their ***relationships*** should be identified in advance.
- ***Responsibility*** (attributes and methods) of each class should be clearly identified
- For each class, ***minimum number of properties*** should be specified, as unnecessary properties will make the diagram complicated.
- Use ***notes*** whenever required to describe some aspect of the diagram. At the end of the drawing it should be understandable to the developer/coder.
- Finally, before making the final version, the diagram should be drawn on plain paper and ***reworked*** as many times as possible to make it correct.





The following diagram is an example of an Order System of an application. It describes a particular aspect of the entire application.

- First of all, Order and Customer are identified as the two elements of the system. They have a one-to-many relationship because a customer can have multiple orders.
- Order class is an abstract class and it has two concrete classes (inheritance relationship) SpecialOrder and NormalOrder.
- The two inherited classes have all the properties as the Order class. In addition, they have additional functions like dispatch () and receive ().

<img src="https://user-images.githubusercontent.com/37357447/189291508-d97d63c5-7c12-4660-a0e1-937fd21edfe0.png" alt="image" style="zoom:50%;" />

### Object Diagram

Object diagrams can be described as an instance of class diagram. Thus, these diagrams are more close to real-life scenarios where we implement a system.

Object diagrams are a set of objects and their relationship is just like class diagrams. They also represent the static view of the system.

The usage of object diagrams is similar to class diagrams but they are used to build prototype of a system from a practical perspective.



#### How to Draw an Object Diagram?

Class Diagrams & Object Diagram are both made of same basic elements but in different form. In class diagram elements are in abstract form to represent the blue print and in object diagram the elements are in concrete form to represent the real world object.

To capture a particular system, numbers of class diagrams are limited. However, if we consider <u>object diagrams then we can have unlimited number of instances</u>, which are unique in nature. Only those instances are considered, which have an impact on the system.

1. From the above discussion, it is clear that a single object diagram cannot capture all the necessary instances or rather cannot specify all the objects of a system. Hence, the solution is −

- First, ***decide instances*** - Analyze the system and decide which instances have important data and association.
- Second, ***consider instantces & function*** - Consider only those instances, which will cover the functionality.
- Third, ***optimize*** - Make some optimization as the number of instances are unlimited.

2. Before drawing an object diagram, the following things should be remembered and understood clearly −

- ***Objects and links*** are the two elements used to construct an object diagram.

- Same as Class Diagram: 

  - The object diagram should have a ***meaningful name*** to indicate its purpose.

  - The ***most important elements*** are to be identified.

  - The ***association*** among objects should be clarified.

  - Values of ***different elements*** need to be captured to include in the object diagram.

  - Add ***proper notes*** at points where more clarity is required.



The following diagram is an example of an object diagram. It represents the Order management system which we have discussed in the chapter Class Diagram. The following diagram is an instance of the system at a particular time of purchase. It has the following objects.

- Customer
- Order
- SpecialOrder
- NormalOrder

Now the customer object (C) is associated with three order objects (O1, O2, and O3). These order objects are associated with special order and normal order objects (S1, S2, and N1). The customer has the following three orders with different numbers (12, 32 and 40) for the particular time considered.

The customer can increase the number of orders in future and in that scenario the object diagram will reflect that. If order, special order, and normal order objects are observed then you will find that they have some values.

For orders, the values are 12, 32, and 40 which implies that the objects have these values for a particular moment (here the particular time when the purchase is made is considered as the moment) when the instance is captured

The same is true for special order and normal order objects which have number of orders as 20, 30, and 60. If a different time of purchase is considered, then these values will change accordingly.

The following object diagram has been drawn considering all the points mentioned above

![image](https://user-images.githubusercontent.com/37357447/189292039-3d61cb4d-7937-49fe-9a37-e0be57b821f4.png)

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