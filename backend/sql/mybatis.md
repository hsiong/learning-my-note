
## if 
<if test="dto.searchType != null  and dto.searchType != '' ">
    <choose>
        <when test='dto.searchType == "1"'>
            and  pr.column = #{column}
        </when>
        <otherwise>
            and find_in_set(#{column},pr.receiver)
        </otherwise>
    </choose>
</if>

## like
LIKE CONCAT('%', #{column}, '%')


## mybatis
1. Invalid bound statement (not found)   ||   Property 'mapperLocations' was not specified.
https://www.jianshu.com/p/6dc534bcc512

2. mybatis-plus tableField
https://baomidou.com/pages/6b03c5/
https://www.tabnine.com/code/java/classes/com.baomidou.mybatisplus.annotation.TableLogic
```
	@TableLogic(value = "null", delval = "now()")
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@JSONField(format = "yyyy-MM-dd HH:mm:ss")
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd HH:mm:ss")
	@Schema(description = "删除标志")
	private LocalDateTime deleteAt;
```






































