# learning-spring-jpa

<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/"><img alt="知识共享许可协议" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-nd/4.0/88x31.png" /></a><br />本作品采用<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/">知识共享署名-非商业性使用-禁止演绎 4.0 国际许可协议</a>进行许可。

# 序
JPA(Java Persistence API) 是为了方便初级开发人员开发数据库而设计的, 开发人员无需接触 SQL, 通过 POJO 的实体映射和相关的 API 调用, 即可完成数据库操作.  

但是随着各种编程思想的进步, 例如 OOM/方法引用 等等, JPA 不可避免地需要与时俱进, 于是这就引来了新的问题, 如何通过 JPA 去动态实现业务查询? 如何通过非侵入式的代码达到业务目的? 如何更加灵活的实现OOM

Hibernate、Spring Data JPA都是 JPA 思想的具体实现, 他们的底层实现原理都是 JDBC, 原则上来说, 您甚至可以借此开发出自己的 ORM 框架. 

本文仅讨论 Spring Data JPA 的具体操作, 希望通过本文的学习, 达到精通 JPA 的程度. 

在阅读文章前, 假设您已经熟悉 Spring JPA 调用的常用注解和流程, 能够自行实现基本业务的 CRUD 操作, 例如, 您至少具备了用以下注解进行开发的能力
+ @Column
+ @Entity
+ @Table
+ @DynamicInsert
+ @DynamicUpdate
+ @Query

如您还不够熟悉, 请参考下文: 
https://www.ideaworks.club/?p=1483

> 题外话, 个人建议, 除非必要, 例如公司标准或者旧有项目需要维护, 为了后期的拓展性, 请您尽量还是选用 mybatis / mybatis-plus 等基于 SQL 实现的框架, 或者自行开发, mybatis github地址: https://github.com/mybatis/mybatis-3


> 个人对 JPA 的评价是, 弄巧成拙, 背道而驰. 只能满足程序员的简单需求, 如果到了业务复杂或要向高代码质量进步的平台, 使用 JPA 只有一个下场, 就是被 JPA 各种形形色色的 API 乱锤敲的人都不是, 被迫写个文章来整理


# 一. Spring Data JPA 总体架构














Example 89. A repository using a dynamic projection parameter
interface PersonRepository extends Repository<Person, UUID> {

  <T> Collection<T> findByLastname(String lastname, Class<T> type);
}
This way, the method can be used to obtain the aggregates as is or with a projection applied, as shown in the following example:

Example 90. Using a repository with dynamic projections
void someMethod(PersonRepository people) {

  Collection<Person> aggregates =
    people.findByLastname("Matthews", Person.class);

  Collection<NamesOnly> aggregates =
    people.findByLastname("Matthews", NamesOnly.class);
}
