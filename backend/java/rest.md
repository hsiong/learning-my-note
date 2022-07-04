# Difference Between REST and HTTP
***Reference***  
https://www.baeldung.com/cs/rest-vs-http#:~:text=While%20many%20people%20continue%20to,features%20of%20a%20RESTful%20system.

## What Is REST
REST stands for Representational State Transfer. REST is not a standard or a specification. Instead, Fielding described REST as an architectural style for distributed hypermedia systems. 

> Representational <sup>代表性的</sup>
> transfer <sup>n/v 转移</sup>
> specification <sup>n 规范</sup>
> field <sup>n 字段;场地</sup>
> architecture <sup>n 架构</sup>
> distributed <sup>adj 分布式的</sup>
> hypermedia <sup>n 超媒体</sup>

## Resources and Representations
The core building blocks of RESTful systems are resources. A resource can be a web page, a video stream, or an image. For example, a resource can even be an abstract concept, such as the list of all users in a database or the weather forecast for a particular location. The only real constraint is that every resource in a system is uniquely identifiable.

Additionally, resources may be available in multiple representations. In a client-server model, the server is responsible for managing the state of the resource, but a client can choose which representation they prefer to interact with.

> constraint <sup>n 约束/限制</sup>
> identifiable <sup>adj 可识别的</sup>

## Uniform Interface