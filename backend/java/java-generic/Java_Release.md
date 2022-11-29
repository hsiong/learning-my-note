This is a proj about JAVA release info and practise, within version from JAVA 8

- [java 1.8](#java-18)
  - [Lambda Expressions](#lambda-expressions)
  - [Method References](#method-references)
  - [Streams](#streams)
  - [Functional Interfaces](#functional-interfaces)
  - [Default Methods](#default-methods)
    - [stream()](#stream)
      - [forEach](#foreach)
      - [map](#map)
      - [filter](#filter)
      - [limit](#limit)
      - [sorted](#sorted)
        - [Basic Sorted](#basic-sorted)
        - [Sort a List with Comparator.reverseOrder()](#sort-a-list-with-comparatorreverseorder)
        - [Reversing Sorted](#reversing-sorted)
    - [parallelStream()](#parallelstream)
  - [Optional Class](#optional-class)
- [JAVA 9](#java-9)
  - [Try With Resources improvement](#try-with-resources-improvement)
- [JAVA 11](#java-11)
  - [String API](#string-api)
  - [Compile free Launch](#compile-free-launch)
  - [Standard HttpClient](#standard-httpclient)
- [JAVA 17](#java-17)
  - [if…else chain (Preview)](#ifelse-chain-preview)
  - [Context-Specific Deserialization Filters](#context-specific-deserialization-filters)

# java 1.8

**Reference**
1. https://www.tutorialspoint.com/java8/java8_lambda_expressions.htm
2. https://www.oracle.com/java/technologies/javase/8-whats-new.html

+ Lambda Expressions, a new language feature, has been introduced in this release. They enable you to treat functionality as a method argument, or code as data. Lambda expressions let you express instances of single-method interfaces (referred to as functional interfaces) more compactly.
+ Method references provide easy-to-read lambda expressions for methods that already have a name.
+ Default methods enable new functionality to be added to the interfaces of libraries and ensure binary compatibility with code written for older versions of those interfaces.
+ Repeating Annotations provide the ability to apply the same annotation type more than once to the same declaration or type use.
+ Type Annotations provide the ability to apply an annotation anywhere a type is used, not just on a declaration. Used with a pluggable type system, this feature enables improved type checking of your code.
Improved type inference.
+ Method parameter reflection.

## Lambda Expressions
A lambda expression is characterized by the following syntax.
```
parameter -> expression body
```
Following are the important characteristics of a lambda expression.

+ Optional type declaration − No need to declare the type of a parameter. The compiler can inference the same from the value of the parameter.

+ Optional parenthesis around parameter − No need to declare a single parameter in parenthesis. For multiple parameters, parentheses are required.

+ Optional curly braces − No need to use curly braces in expression body if the body contains a single statement.

+ Optional return keyword − The compiler automatically returns the value if the body has a single expression to return the value. Curly braces are required to indicate that expression returns a value.

<b> Example </b>

```
public class Java8Tester {

   public static void main(String args[]) {
      Java8Tester tester = new Java8Tester();
		
      //with type declaration
      MathOperation addition = (int a, int b) -> a + b;
		
      //with out type declaration
      MathOperation subtraction = (a, b) -> a - b;
		
      //with return statement along with curly braces
      MathOperation multiplication = (int a, int b) -> { return a * b; };
		
      //without return statement and without curly braces
      MathOperation division = (int a, int b) -> a / b;
		
      System.out.println("10 + 5 = " + tester.operate(10, 5, addition));
      System.out.println("10 - 5 = " + tester.operate(10, 5, subtraction));
      System.out.println("10 x 5 = " + tester.operate(10, 5, multiplication));
      System.out.println("10 / 5 = " + tester.operate(10, 5, division));
		
      //without parenthesis
      GreetingService greetService1 = message ->
      System.out.println("Hello " + message);
		
      //with parenthesis
      GreetingService greetService2 = (message) ->
      System.out.println("Hello " + message);
		
      greetService1.sayMessage("Mahesh");
      greetService2.sayMessage("Suresh");
   }
	
   interface MathOperation {
      int operation(int a, int b);
   }
	
   interface GreetingService {
      void sayMessage(String message);
   }
	
   private int operate(int a, int b, MathOperation mathOperation) {
      return mathOperation.operation(a, b);
   }
}
```

## Method References
Method references help to point to methods by their names. A method reference is described using "::" symbol. A method reference can be used to point the following types of methods −
+ Static methods
+ Instance methods
+ Constructors using new operator (TreeSet::new)

**Example**
```
import java.util.List;
import java.util.ArrayList;

public class Java8Tester {

   public static void main(String args[]) {
      List names = new ArrayList();
		
      names.add("Mahesh");
      names.add("Suresh");
      names.add("Ramesh");
      names.add("Naresh");
      names.add("Kalpesh");
		
      names.forEach(System.out::println);
   }
}
```

**COMPILE WITH LAMBDA**
```
    @Test
    public void doLambdaTest() {
        LambdaTestModule.GreetingService greetingService = i -> {
            i.setS1("2");
            System.out.println(i);
            return i;
        };
        /**
         * 基本类型 以及 String
         */
        List<LambdaTestModule> stringList = Lists.newArrayList();
        stringList.add(new LambdaTestModule("1", "1"));
        stringList.forEach(greetingService::changeMessage);
    }

@Data
@AllArgsConstructor
public class LambdaTestModule {

    private String s1;
    private String s2;
    public interface GreetingService {
        LambdaTestModule changeMessage(LambdaTestModule message);
    }

}
```

> **Extensive**
> [forEach not modify java(8) collection: ](https://stackoverflow.com/questions/23852286/foreach-not-modify-java8-collection)
> In my examples, As u can see, forEach-not-modify-java-collection is aimed for primitive types and String,   
> But forEach can modify values for objects

## Streams


## Functional Interfaces
**Reference**
https://www.tutorialspoint.com/java8/java8_functional_interfaces.htm

## Default Methods
https://www.tutorialspoint.com/java8/java8_default_methods.htm

Stream is a new abstract layer introduced in Java 8, Java 8 introduced the concept of stream that lets the developer to process data declaratively and leverage multicore architecture without the need to write any specific code for it.

### stream()

#### forEach
```
Random random = new Random();
random.ints().limit(10).forEach(System.out::println);
```

#### map
The ‘map’ method is used to map each element to its corresponding result. The following code segment prints unique squares of numbers using map.
```
List<Integer> numbers = Arrays.asList(3, 2, 2, 3, 7, 3, 5);

//get list of unique squares
List<Integer> squaresList = numbers.stream().map( i -> i*i).distinct().collect(Collectors.toList());

```

#### filter
The ‘filter’ method is used to eliminate elements based on a criteria. The following code segment prints a count of empty strings using filter.
```
List<String>strings = Arrays.asList("abc", "", "bc", "efg", "abcd","", "jkl");

//get count of empty string
int count = strings.stream().filter(string -> string.isEmpty()).count();
```

#### limit
The ‘limit’ method is used to reduce the size of the stream. The following code segment shows how to print 10 random numbers using limit.
```
Random random = new Random();
random.ints().limit(10).forEach(System.out::println);
```

#### sorted
##### Basic Sorted
```
Random random = new Random();
random.ints().limit(10).sorted().forEach(System.out::println);
```

##### Sort a List with Comparator.reverseOrder()
```
    @Test
    public void sortedCompareTest() {
        List<LambdaTestModule> stringList = Lists.newArrayList();
        stringList.add(new LambdaTestModule(1, 1));
        stringList.add(new LambdaTestModule(2, 2));
        stringList.add(new LambdaTestModule(3, 3));
        stringList = stringList.stream().sorted(Comparator.comparing(LambdaTestModule::getS1)).collect(Collectors.toList());
        System.out.println(stringList);
    }
```

##### Reversing Sorted
```
    @Test
    public void sortedCompareTest() {
        List<LambdaTestModule> stringList = Lists.newArrayList();
        stringList.add(new LambdaTestModule(1, 1));
        stringList.add(new LambdaTestModule(2, 2));
        stringList.add(new LambdaTestModule(3, 3));
        stringList = stringList.stream().sorted(Comparator.comparing(LambdaTestModule::getS1).reversed()).collect(Collectors.toList());
        System.out.println(stringList);
    }
```

### parallelStream()
parallelStream is the alternative of stream for parallel processing. It's opers are same to stream()

## Optional Class
Optional is a container object used to contain not-null objects. Optional object is used to represent null with absent value. This class has various utility methods to facilitate code to handle values as ‘available’ or ‘not available’ instead of checking null values. 

Its source code is very simple. u can read it in `java.util.Optional<T>` to know how to use it

# JAVA 9
## Try With Resources improvement
The try-with-resources statement is a try statement with one or more resources duly declared. Here resource is an object which should be closed once it is no more required. The try-with-resources statement ensures that each resource is closed after the requirement finishes. Any object implementing java.lang.AutoCloseable or java.io.Closeable, interface can be used as a resource.

Prior to Java 9, resources are to be declared before try or inside try statement as shown below in given example. In this example, we'll use BufferedReader as resource to read a string and then BufferedReader is to be closed.

```
import java.io.BufferedReader;
import java.io.IOException;
import java.io.Reader;
import java.io.StringReader;

public class Tester {
   public static void main(String[] args) throws IOException {
      System.out.println(readData("test"));
   } 
   static String readData(String message) throws IOException {
      Reader inputString = new StringReader(message);
      BufferedReader br = new BufferedReader(inputString);
      try (BufferedReader br1 = br) {
         return br1.readLine();
      }
   }
}
```

# JAVA 11
You don't need to study JAVA 11 because JAVA 11 only Enhanced some API compare to JAVA 8. But there is one thing u need pay attention to : 
 **JAVA 11 replaced `sun.misc.BASE64Encoder` WITH `Base64.Encoder`**

**Reference**
1. https://mkyong.com/java/what-is-new-in-java-11/
2. https://www.tutorialspoint.com/java11/java11_overview.htm

## String API
https://www.tutorialspoint.com/java11/java11_string_api.htm

## Compile free Launch
https://mkyong.com/java/what-is-new-in-java-11/

## Standard HttpClient
https://www.tutorialspoint.com/java11/java11_standard_httpclient.htm

# JAVA 17
**Reference**
1. https://mkyong.com/java/what-is-new-in-java-17/

## if…else chain (Preview)
**Before Java 17**
```
  public static void main(String[] args) {

      System.out.println(formatter("Java 17"));
      System.out.println(formatter(17));

  }

  static String formatter(Object o) {
      String formatted = "unknown";
      if (o instanceof Integer i) {
          formatted = String.format("int %d", i);
      } else if (o instanceof Long l) {
          formatted = String.format("long %d", l);
      } else if (o instanceof Double d) {
          formatted = String.format("double %f", d);
      } else if (o instanceof String s) {
          formatted = String.format("String %s", s);
      }
      return formatted;
  }
```
**In Java 17**
```
    public static void main(String[] args) {

        System.out.println(formatterJava17("Java 17"));
        System.out.println(formatterJava17(17));

    }

    static String formatterJava17(Object o) {
        return switch (o) {
            case Integer i -> String.format("int %d", i);
            case Long l    -> String.format("long %d", l);
            case Double d  -> String.format("double %f", d);
            case String s  -> String.format("String %s", s);
            default        -> o.toString();
        };
    }
```

## Context-Specific Deserialization Filters
Deserialization Enhanced.

+ java decompiler code is same as source code after java 11
+ javap -c x.class