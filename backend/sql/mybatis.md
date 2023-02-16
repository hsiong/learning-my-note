
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









































